import 'dart:convert';
import 'dart:io';

import 'package:flutter_test/flutter_test.dart';

Map<String, dynamic> _read(File file) =>
    jsonDecode(file.readAsStringSync()) as Map<String, dynamic>;

Set<String> _placeholders(String message) =>
    RegExp(r'\{(\w+)').allMatches(message).map((m) => m.group(1)!).toSet();

void main() {
  final dir = Directory('lib/l10n');
  final template = _read(File('lib/l10n/app_en.arb'));
  final keys = template.keys.where((k) => !k.startsWith('@')).toSet();
  final translations = dir
      .listSync()
      .whereType<File>()
      .where((f) => RegExp(r'app_\w+\.arb$').hasMatch(f.path))
      .where((f) => !f.path.endsWith('app_en.arb'));

  test('every template string has a description for translators', () {
    for (final key in keys) {
      final meta = template['@$key'] as Map<String, dynamic>?;
      expect(meta?['description'], isNotNull, reason: key);
    }
  });

  for (final file in translations) {
    group(file.uri.pathSegments.last, () {
      final arb = _read(file);

      test('only uses keys from the template', () {
        final extra = arb.keys
            .where((k) => !k.startsWith('@'))
            .toSet()
            .difference(keys);
        expect(extra, isEmpty);
      });

      test('keeps the template placeholders', () {
        for (final key in keys.intersection(arb.keys.toSet())) {
          final expected = _placeholders(template[key] as String)
              .where((p) => (template['@$key'] as Map?)?['placeholders']
                      ?.containsKey(p) ??
                  false);
          expect(
            _placeholders(arb[key] as String).containsAll(expected),
            isTrue,
            reason: key,
          );
        }
      });
    });
  }

  test('French is complete', () {
    final fr = _read(File('lib/l10n/app_fr.arb'));
    expect(keys.difference(fr.keys.toSet()), isEmpty);
  });
}
