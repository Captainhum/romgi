import 'package:flutter/services.dart';

/// What a `romgi://` link asks the app to show. See docs/integration.md.
sealed class AppLink {
  const AppLink();
}

/// `romgi://game/<slug>` — a game page.
class GameLink extends AppLink {
  const GameLink(this.slug);
  final String slug;
}

/// `romgi://search?q=<text>&platform=<id>` — Browse with a search.
class SearchLink extends AppLink {
  const SearchLink(this.query, {this.platform});
  final String query;
  final String? platform;
}

/// `romgi://downloads` or `romgi://library` — a tab.
class TabLink extends AppLink {
  const TabLink(this.tab);
  final String tab;
}

/// Parses a `romgi://` link, or returns null for anything else.
AppLink? parseAppLink(Uri uri) {
  if (uri.scheme != 'romgi') return null;
  final segments = uri.pathSegments.where((s) => s.isNotEmpty).toList();
  switch (uri.host) {
    case 'game':
      return segments.length == 1 ? GameLink(segments.single) : null;
    case 'search':
      final query = uri.queryParameters['q']?.trim() ?? '';
      final platform = uri.queryParameters['platform']?.trim();
      if (query.isEmpty && (platform == null || platform.isEmpty)) return null;
      return SearchLink(
        query,
        platform: platform == null || platform.isEmpty ? null : platform,
      );
    case 'downloads':
    case 'library':
      return TabLink(uri.host);
  }
  return null;
}

/// Receives `romgi://` links from Android: the one that launched the app
/// and the ones that arrive while it runs.
class AppLinkReceiver {
  static const _channel = MethodChannel('com.caprado.romgi/links');

  /// Calls [onLink] for the launch link (if any) and every later link.
  static Future<void> listen(void Function(AppLink link) onLink) async {
    _channel.setMethodCallHandler((call) async {
      if (call.method == 'onLink' && call.arguments is String) {
        final link = parseAppLink(Uri.parse(call.arguments as String));
        if (link != null) onLink(link);
      }
    });
    final initial = await _channel.invokeMethod<String>('getInitialLink');
    if (initial != null) {
      final link = parseAppLink(Uri.parse(initial));
      if (link != null) onLink(link);
    }
  }
}
