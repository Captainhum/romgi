import 'dart:io';

import 'package:chd_native/chd_native.dart';
import 'package:test/test.dart';

/// Builds a tiny two-track disc (data + audio) as bin/cue.
String _writeDisc(Directory dir) {
  const frame = 2352;
  final data = File('${dir.path}/game (Track 1).bin');
  final audio = File('${dir.path}/game (Track 2).bin');
  data.writeAsBytesSync(List.generate(frame * 300, (i) => (i * 7) & 0xff));
  audio.writeAsBytesSync(List.generate(frame * 150, (i) => (i * 13) & 0xff));
  final cue = File('${dir.path}/game.cue')
    ..writeAsStringSync(
      'FILE "game (Track 1).bin" BINARY\n'
      '  TRACK 01 MODE2/2352\n'
      '    INDEX 01 00:00:00\n'
      'FILE "game (Track 2).bin" BINARY\n'
      '  TRACK 02 AUDIO\n'
      '    INDEX 00 00:00:00\n'
      '    INDEX 01 00:02:00\n',
    );
  return cue.path;
}

void main() {
  late Directory dir;

  setUp(() => dir = Directory.systemTemp.createTempSync('chd_native_test'));
  tearDown(() => dir.deleteSync(recursive: true));

  test('creates a CHD that verifies', () async {
    final cue = _writeDisc(dir);
    final out = '${dir.path}/game.chd';
    final progress = <double>[];

    final status = await createCdChd(cue, out, onProgress: progress.add);

    expect(status, ChdStatus.ok);
    expect(File(out).existsSync(), isTrue);
    expect(progress.last, 1.0);
    expect(await verifyChd(out), ChdStatus.ok);
  });

  test('matches desktop chdman verify when available', () async {
    final chdman = Process.runSync('which', ['chdman']);
    if (chdman.exitCode != 0) {
      markTestSkipped('chdman not installed');
      return;
    }
    final out = '${dir.path}/game.chd';
    expect(await createCdChd(_writeDisc(dir), out), ChdStatus.ok);
    final result = Process.runSync('chdman', ['verify', '-i', out]);
    expect(result.exitCode, 0, reason: '${result.stdout}${result.stderr}');
  });

  test('a missing cue reports bad input and writes nothing', () async {
    final out = '${dir.path}/none.chd';
    expect(await createCdChd('${dir.path}/none.cue', out), ChdStatus.badInput);
    expect(File(out).existsSync(), isFalse);
  });

  test('a corrupted CHD fails verification', () async {
    final out = '${dir.path}/game.chd';
    expect(await createCdChd(_writeDisc(dir), out), ChdStatus.ok);
    final bytes = File(out).readAsBytesSync();
    for (var i = bytes.length - 2000; i < bytes.length - 1000; i++) {
      bytes[i] ^= 0xff;
    }
    File(out).writeAsBytesSync(bytes);
    expect(await verifyChd(out), isNot(ChdStatus.ok));
  });

  test('cancelling removes the partial output', () async {
    final out = '${dir.path}/game.chd';
    final token = ChdCancelToken()..cancel();
    expect(
      await createCdChd(_writeDisc(dir), out, cancelToken: token),
      ChdStatus.cancelled,
    );
    expect(File(out).existsSync(), isFalse);
  });
}
