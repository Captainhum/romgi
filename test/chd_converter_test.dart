import 'dart:io';

import 'package:chd_native/chd_native.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:path/path.dart' as p;
import 'package:romgi/services/chd_converter.dart';

const _frame = 2352;

/// Writes a small data + audio bin/cue disc into [dir] named [name].
String _disc(Directory dir, String name) {
  File(p.join(dir.path, '$name (Track 1).bin'))
      .writeAsBytesSync(List.generate(_frame * 200, (i) => (i * 7) & 0xff));
  File(p.join(dir.path, '$name (Track 2).bin'))
      .writeAsBytesSync(List.generate(_frame * 100, (i) => (i * 13) & 0xff));
  return (File(p.join(dir.path, '$name.cue'))
        ..writeAsStringSync(
          'FILE "$name (Track 1).bin" BINARY\n  TRACK 01 MODE2/2352\n'
          '    INDEX 01 00:00:00\n'
          'FILE "$name (Track 2).bin" BINARY\n  TRACK 02 AUDIO\n'
          '    INDEX 01 00:00:00\n',
        ))
      .path;
}

void main() {
  late Directory dir;

  setUp(() => dir = Directory.systemTemp.createTempSync('romgi_chd_test'));
  tearDown(() => dir.deleteSync(recursive: true));

  test('converts a cue with its tracks and removes the originals', () async {
    final cue = _disc(dir, 'Game');
    File(p.join(dir.path, 'Other.bin')).writeAsStringSync('keep me');
    final progress = <double>[];

    final chd = await ChdConverter().convert(cue, onProgress: progress.add);

    expect(chd, p.join(dir.path, 'Game.chd'));
    expect(await verifyChd(chd), ChdStatus.ok);
    expect(File(cue).existsSync(), isFalse);
    expect(File(p.join(dir.path, 'Game (Track 1).bin')).existsSync(), isFalse);
    expect(File(p.join(dir.path, 'Other.bin')).existsSync(), isTrue);
    expect(progress.last, 1.0);
  });

  test('converts an extraction folder into a CHD beside it', () async {
    final folder = Directory(p.join(dir.path, 'Game (Disc 1)'))..createSync();
    _disc(folder, 'Game (Disc 1)');
    File(p.join(folder.path, 'readme.txt')).writeAsStringSync('x');

    final chd = await ChdConverter().convert(folder.path);

    expect(chd, p.join(dir.path, 'Game (Disc 1).chd'));
    expect(folder.existsSync(), isFalse);
  });

  test('cartridge ROMs and missing paths are not convertible', () async {
    final rom = File(p.join(dir.path, 'game.sfc'))..writeAsStringSync('rom');
    await expectLater(
      ChdConverter().convert(rom.path),
      throwsA(isA<ChdConversionException>().having(
          (e) => e.error, 'error', ChdConversionError.notConvertible)),
    );
    expect(rom.existsSync(), isTrue);
  });

  test('an existing CHD is never overwritten', () async {
    final cue = _disc(dir, 'Game');
    File(p.join(dir.path, 'Game.chd')).writeAsStringSync('mine');

    await expectLater(
      ChdConverter().convert(cue),
      throwsA(isA<ChdConversionException>().having(
          (e) => e.error, 'error', ChdConversionError.alreadyExists)),
    );
    expect(File(p.join(dir.path, 'Game.chd')).readAsStringSync(), 'mine');
    expect(File(cue).existsSync(), isTrue);
  });

  test('not enough space keeps everything', () async {
    final cue = _disc(dir, 'Game');
    await expectLater(
      ChdConverter(freeSpace: (_) => 10).convert(cue),
      throwsA(isA<ChdConversionException>().having(
          (e) => e.error, 'error', ChdConversionError.noSpace)),
    );
    expect(File(cue).existsSync(), isTrue);
  });

  test('a failed verification keeps the originals and drops the CHD',
      () async {
    final cue = _disc(dir, 'Game');
    final converter = ChdConverter(
      verify: (chd, {onProgress, cancelToken}) async => ChdStatus.corrupt,
    );
    await expectLater(
      converter.convert(cue),
      throwsA(isA<ChdConversionException>().having(
          (e) => e.error, 'error', ChdConversionError.verifyFailed)),
    );
    expect(File(cue).existsSync(), isTrue);
    expect(File(p.join(dir.path, 'Game.chd')).existsSync(), isFalse);
  });

  test('cancelling keeps the originals', () async {
    final cue = _disc(dir, 'Game');
    await expectLater(
      ChdConverter().convert(cue, cancelToken: ChdCancelToken()..cancel()),
      throwsA(isA<ChdConversionException>().having(
          (e) => e.error, 'error', ChdConversionError.cancelled)),
    );
    expect(File(cue).existsSync(), isTrue);
  });

  test('conversions run one at a time', () async {
    final running = <String>[];
    var overlap = false;
    final converter = ChdConverter(
      create: (input, output, {onProgress, cancelToken}) async {
        if (running.isNotEmpty) overlap = true;
        running.add(input);
        await Future<void>.delayed(const Duration(milliseconds: 20));
        File(output).writeAsStringSync('chd');
        running.remove(input);
        return ChdStatus.ok;
      },
      verify: (chd, {onProgress, cancelToken}) async => ChdStatus.ok,
    );
    await Future.wait([
      converter.convert(_disc(dir, 'A')),
      converter.convert(_disc(dir, 'B')),
    ]);
    expect(overlap, isFalse);
  });

  test('parses GDI track files', () {
    expect(
      ChdConverter.gdiTrackFiles(
        '3\n1 0 4 2352 track01.bin 0\n2 600 0 2352 "track 02.raw" 0\n'
        '3 45000 4 2352 track03.bin 0\n',
      ),
      ['track01.bin', 'track 02.raw', 'track03.bin'],
    );
  });
}
