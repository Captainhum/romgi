import 'dart:io';

import 'package:chd_native/chd_native.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:integration_test/integration_test.dart';

/// Converts a real game pushed to the device. Run with
/// --dart-define=CHD_CUE=/sdcard/Download/chdtest/game.cue
void main() {
  IntegrationTestWidgetsFlutterBinding.ensureInitialized();
  const cue = String.fromEnvironment('CHD_CUE');

  testWidgets('converts a real game on device', (tester) async {
    if (cue.isEmpty) return;
    await tester.runAsync(() async {
      final out = cue.replaceAll(RegExp(r'\.cue$'), '.chd');
      final sw = Stopwatch()..start();
      final status = await createCdChd(cue, out);
      final create = sw.elapsed.inSeconds;
      sw.reset();
      final verified = await verifyChd(out);
      // ignore: avoid_print
      print('CHD_REAL_RESULT create=${create}s verify=${sw.elapsed.inSeconds}s '
          'size=${File(out).lengthSync()} status=$status verified=$verified');
      expect(status, ChdStatus.ok);
      expect(verified, ChdStatus.ok);
    });
  });
}
