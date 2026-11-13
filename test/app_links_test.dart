import 'package:flutter_test/flutter_test.dart';
import 'package:romgi/services/app_links.dart';

AppLink? _parse(String link) => parseAppLink(Uri.parse(link));

void main() {
  test('game links carry the slug', () {
    final link = _parse('romgi://game/metal-gear-solid-france-disc-1');
    expect(link, isA<GameLink>());
    expect((link as GameLink).slug, 'metal-gear-solid-france-disc-1');
  });

  test('search links carry the text and optional platform', () {
    final link = _parse('romgi://search?q=Final%20Fantasy&platform=ps1');
    expect((link as SearchLink).query, 'Final Fantasy');
    expect(link.platform, 'ps1');
    expect((_parse('romgi://search?q=zelda') as SearchLink).platform, isNull);
  });

  test('tab links', () {
    expect((_parse('romgi://downloads') as TabLink).tab, 'downloads');
    expect((_parse('romgi://library') as TabLink).tab, 'library');
  });

  test('anything else is ignored', () {
    expect(_parse('https://game/x'), isNull);
    expect(_parse('romgi://game'), isNull);
    expect(_parse('romgi://game/a/b'), isNull);
    expect(_parse('romgi://search'), isNull);
    expect(_parse('romgi://settings'), isNull);
  });
}
