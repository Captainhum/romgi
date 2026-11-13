import 'dart:io';

import 'package:flutter_test/flutter_test.dart';

/// Proper nouns and symbols that are the same in every language.
const _allowed = {
  'Internet Archive',
  'RetroAchievements',
  'OK',
};

final _uiLiteral = RegExp(
  r"""(?:Text\(\s*|(?:label|title|tooltip|hintText|labelText|helperText|content|notificationTitle|channelName):\s*)'([A-Z][^']*)'""",
);

void main() {
  test('screens and widgets have no hard-coded interface text', () {
    final files = [
      File('lib/main.dart'),
      ...Directory('lib/screens').listSync(recursive: true).whereType<File>(),
      ...Directory('lib/widgets').listSync(recursive: true).whereType<File>(),
    ].where((f) => f.path.endsWith('.dart'));

    final offenders = <String>[];
    for (final file in files) {
      final source = file.readAsStringSync();
      for (final match in _uiLiteral.allMatches(source)) {
        final text = match.group(1)!;
        if (_allowed.contains(text)) continue;
        final line = '\n'.allMatches(source.substring(0, match.start)).length;
        offenders.add('${file.path}:${line + 1} "$text"');
      }
    }
    expect(offenders, isEmpty, reason: 'Move these strings to lib/l10n/app_en.arb');
  });
}
