import 'dart:io';
import 'dart:math';

import 'package:chd_native/chd_native.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:integration_test/integration_test.dart';
import 'package:path_provider/path_provider.dart';

/// Runs the native CHD encoder on the device: a ~300 MB data + audio disc
/// is converted, verified and timed.
void main() {
  IntegrationTestWidgetsFlutterBinding.ensureInitialized();

  testWidgets('converts and verifies a disc on device', (tester) async {
    await tester.runAsync(() async {
      final dir = Directory(
        '${(await getTemporaryDirectory()).path}/chd_device_test',
      )..createSync(recursive: true);
      const frame = 2352;
      final random = Random(1);
      // Compressible "game data": repeating blocks with some noise.
      final block = List.generate(frame * 64, (i) => (i * 31 + i ~/ 977) & 0xff);
      final data = File('${dir.path}/disc (Track 1).bin').openSync(
        mode: FileMode.write,
      );
      for (var i = 0; i < 2000; i++) {
        block[random.nextInt(block.length)] = random.nextInt(256);
        data.writeFromSync(block);
      }
      data.closeSync();
      File('${dir.path}/disc (Track 2).bin').writeAsBytesSync(
        List.generate(frame * 3000, (i) => (sin(i / 20) * 120).toInt() & 0xff),
      );
      final cue = File('${dir.path}/disc.cue')
        ..writeAsStringSync(
          'FILE "disc (Track 1).bin" BINARY\n  TRACK 01 MODE2/2352\n'
          '    INDEX 01 00:00:00\n'
          'FILE "disc (Track 2).bin" BINARY\n  TRACK 02 AUDIO\n'
          '    INDEX 01 00:00:00\n',
        );
      final out = '${dir.path}/disc.chd';
      final input = File('${dir.path}/disc (Track 1).bin').lengthSync() +
          File('${dir.path}/disc (Track 2).bin').lengthSync();

      final sw = Stopwatch()..start();
      final status = await createCdChd(cue.path, out);
      final createTime = sw.elapsed;
      sw.reset();
      final verified = await verifyChd(out);
      final verifyTime = sw.elapsed;

      final size = File(out).lengthSync();
      // ignore: avoid_print
      print('CHD_DEVICE_RESULT input=${input ~/ 1048576}MB '
          'output=${size ~/ 1048576}MB create=${createTime.inSeconds}s '
          'verify=${verifyTime.inSeconds}s status=$status verified=$verified');
      dir.deleteSync(recursive: true);

      expect(status, ChdStatus.ok);
      expect(verified, ChdStatus.ok);
    });
  });
}
