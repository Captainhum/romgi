import 'dart:convert';

import 'package:dio/dio.dart';

import '../../utils/platform_names.dart';
import 'metadata_provider.dart';

/// Game descriptions from Wikipedia's public API: no account or key needed.
/// Looks in the requested language first, then English. Text only.
class WikipediaProvider extends GameMetadataProvider {
  WikipediaProvider({Dio? dio})
      : _dio = dio ??
            Dio(BaseOptions(
              connectTimeout: const Duration(seconds: 10),
              receiveTimeout: const Duration(seconds: 20),
              validateStatus: (code) => code != null && code < 500,
              // Wikimedia asks API clients to identify themselves.
              headers: {
                'User-Agent':
                    'romgi (https://github.com/Captainhum/romgi) dart-dio',
              },
            ));

  final Dio _dio;

  /// Words that mark an article as being about a video game, per language.
  static const Map<String, List<String>> _gameWords = {
    'en': ['video game'],
    'fr': ['jeu vidéo', 'jeu de rôle', "jeu d'action", 'jeu de plates-formes'],
    'de': ['videospiel', 'computerspiel'],
    'es': ['videojuego'],
    'it': ['videogioco'],
    'pt': ['jogo eletrônico', 'jogo de vídeo', 'videojogo'],
  };

  @override
  MetadataProviderInfo get info =>
      const MetadataProviderInfo(id: 'wikipedia', name: 'Wikipedia');

  @override
  List<CredentialField> get credentialFields => const [];

  @override
  bool isConfigured(Map<String, String>? creds) => true;

  @override
  Future<String?> validateCredentials(Map<String, String> creds) async => null;

  @override
  Future<MetadataResult> fetch({
    required String title,
    required String platform,
    required Map<String, String> creds,
    String language = 'en',
  }) async {
    var anyAnswer = false;
    for (final lang in {language, 'en'}) {
      try {
        final extract = await _describe(title, platform, lang);
        anyAnswer = true;
        if (extract != null) return MetadataFound(description: extract);
      } on DioException catch (e) {
        if (e.response != null) anyAnswer = true;
      }
    }
    return anyAnswer
        ? const MetadataNoMatch()
        : const MetadataError('Could not reach Wikipedia');
  }

  /// The intro of the best matching game article in [lang], or null.
  /// Articles must be named after the game (with or without its subtitle)
  /// and read as a video game; one that names the [platform] wins.
  Future<String?> _describe(String title, String platform, String lang) async {
    final words = _gameWords[lang] ?? _gameWords['en']!;
    final short = title.split(RegExp(r'\s+-\s+|:\s+')).first;
    final wanted = {_normalize(title), _normalize(short)};

    final hits = <String>{};
    for (final query in {title, short}) {
      final search = await _dio.get(
        'https://$lang.wikipedia.org/w/api.php',
        queryParameters: {
          'action': 'query',
          'list': 'search',
          'srsearch': '$query ${words.first}',
          'srlimit': '5',
          'format': 'json',
        },
        options: Options(responseType: ResponseType.plain),
      );
      hits.addAll(
        ((_json(search.data)?['query'] as Map?)?['search'] as List?)
                ?.whereType<Map>()
                .map((hit) => hit['title'] as String?)
                .whereType<String>() ??
            const [],
      );
    }

    final candidates = hits.where((hit) {
      final name = _normalize(hit.replaceAll(RegExp(r'\s*\([^)]*\)'), ''));
      return wanted.contains(name);
    });

    final platformName = PlatformNames.getDisplayName(platform).toLowerCase();
    String? fallback;
    for (final candidate in candidates) {
      final extract = await _intro(candidate, lang);
      if (extract == null) continue;
      final lower = extract.toLowerCase();
      if (!words.any(lower.contains)) continue;
      if (lower.contains(platformName)) return extract;
      fallback ??= extract;
    }
    return fallback;
  }

  Future<String?> _intro(String page, String lang) async {
    final res = await _dio.get(
      'https://$lang.wikipedia.org/w/api.php',
      queryParameters: {
        'action': 'query',
        'prop': 'extracts',
        'exintro': '1',
        'explaintext': '1',
        'redirects': '1',
        'titles': page,
        'format': 'json',
      },
      options: Options(responseType: ResponseType.plain),
    );
    final pages = ((_json(res.data)?['query'] as Map?)?['pages'] as Map?)
            ?.values
            .whereType<Map>() ??
        const [];
    for (final p in pages) {
      final text = (p['extract'] as String?)?.trim();
      if (text != null && text.isNotEmpty) return text;
    }
    return null;
  }

  static Map<String, dynamic>? _json(Object? data) {
    if (data is Map<String, dynamic>) return data;
    if (data is String) {
      try {
        final decoded = jsonDecode(data);
        return decoded is Map<String, dynamic> ? decoded : null;
      } catch (_) {}
    }
    return null;
  }

  /// Lower-case letters and digits only, so "Rayman 2: The Great Escape"
  /// and "Rayman 2 - The Great Escape" compare equal.
  static String _normalize(String s) => s
      .toLowerCase()
      .replaceAll(RegExp(r'[éèêë]'), 'e')
      .replaceAll(RegExp(r'[àâä]'), 'a')
      .replaceAll(RegExp(r'[^a-z0-9]'), '');
}
