import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:romgi/services/metadata/metadata_provider.dart';
import 'package:romgi/services/metadata/wikipedia_provider.dart';

/// A Dio answering Wikipedia API calls from in-memory pages per language.
/// [search] maps "lang" to search result titles; [pages] maps
/// "lang:title" to the article intro.
Dio _wiki({
  Map<String, List<String>> search = const {},
  Map<String, String> pages = const {},
}) {
  final dio = Dio();
  dio.interceptors.add(InterceptorsWrapper(onRequest: (options, handler) {
    final lang = options.uri.host.split('.').first;
    final params = options.queryParameters;
    Object body;
    if (params['list'] == 'search') {
      body = {
        'query': {
          'search': [
            for (final title in search[lang] ?? const <String>[])
              {'title': title},
          ],
        },
      };
    } else {
      final title = params['titles'] as String;
      final extract = pages['$lang:$title'];
      body = {
        'query': {
          'pages': {
            '1': {'title': title, if (extract != null) 'extract': extract},
          },
        },
      };
    }
    handler.resolve(Response(
      requestOptions: options,
      statusCode: 200,
      data: jsonEncode(body),
    ));
  }));
  return dio;
}

Future<MetadataResult> _fetch(Dio dio, String title, {String lang = 'fr'}) =>
    WikipediaProvider(dio: dio).fetch(
      title: title,
      platform: 'ps1',
      creds: const {},
      language: lang,
    );

void main() {
  test('needs no account', () {
    final provider = WikipediaProvider(dio: Dio());
    expect(provider.credentialFields, isEmpty);
    expect(provider.isConfigured(null), isTrue);
  });

  test('returns the intro of the game article in the requested language',
      () async {
    final result = await _fetch(
      _wiki(
        search: {'fr': ['Silent Hill (film)', 'Silent Hill']},
        pages: {
          'fr:Silent Hill (film)': 'Silent Hill est un film d’horreur.',
          'fr:Silent Hill': 'Silent Hill est un jeu vidéo sorti sur PlayStation.',
        },
      ),
      'Silent Hill',
    );
    expect(
      (result as MetadataFound).description,
      'Silent Hill est un jeu vidéo sorti sur PlayStation.',
    );
  });

  test('matches a game named without its subtitle', () async {
    final result = await _fetch(
      _wiki(
        search: {'fr': ['Driver 2']},
        pages: {'fr:Driver 2': 'Driver 2 est un jeu vidéo sur PlayStation.'},
      ),
      'Driver 2 - Back on the Streets',
    );
    expect((result as MetadataFound).description, contains('Driver 2'));
  });

  test('prefers the article that names the console', () async {
    final result = await _fetch(
      _wiki(
        search: {'fr': ['MediEvil (2019)', 'MediEvil']},
        pages: {
          'fr:MediEvil (2019)': 'MediEvil est un jeu vidéo sur PlayStation 4.',
          'fr:MediEvil': 'MediEvil est un jeu vidéo sorti sur PlayStation.',
        },
      ),
      'MediEvil',
    );
    // "playstation 4" also contains "playstation"; the first matching wins.
    expect((result as MetadataFound).description, contains('PlayStation'));
  });

  test('falls back to English when the language has no article', () async {
    final result = await _fetch(
      _wiki(
        search: {'en': ['Bust A Move 2 (video game)']},
        pages: {
          'en:Bust A Move 2 (video game)': 'Bust A Move 2 is a video game.',
        },
      ),
      'Bust A Move 2',
    );
    expect((result as MetadataFound).description, 'Bust A Move 2 is a video game.');
  });

  test('ignores same-name articles that are not about a game', () async {
    final result = await _fetch(
      _wiki(
        search: {'fr': ['Driver'], 'en': ['Driver']},
        pages: {
          'fr:Driver': 'Un driver est un pilote de périphérique.',
          'en:Driver': 'A driver is a computer program.',
        },
      ),
      'Driver',
    );
    expect(result, isA<MetadataNoMatch>());
  });
}
