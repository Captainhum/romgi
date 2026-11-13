import 'dart:io';

import 'package:flutter_test/flutter_test.dart';
import 'package:path/path.dart' as p;
import 'package:romgi/services/disc_organizer.dart';

void main() {
  late Directory platformDir;
  final organizer = DiscOrganizer();

  setUp(() {
    platformDir = Directory.systemTemp.createTempSync('romgi_disc_test');
  });

  tearDown(() => platformDir.deleteSync(recursive: true));

  File write(String name, [String content = 'x']) =>
      File(p.join(platformDir.path, name))
        ..createSync(recursive: true)
        ..writeAsStringSync(content);

  String hidden(String name) =>
      p.join(platformDir.path, DiscOrganizer.hiddenDirName, name);

  test('parses quoted and unquoted cue FILE lines', () {
    expect(
      DiscOrganizer.cueTrackFiles(
        'FILE "Game (Track 1).bin" BINARY\n'
        '  TRACK 01 MODE2/2352\n'
        'file track2.bin BINARY\n',
      ),
      ['Game (Track 1).bin', 'track2.bin'],
    );
  });

  test('moves a cue sheet with its tracks', () async {
    final cue = write(
      'Game (Disc 1).cue',
      'FILE "Game (Disc 1) (Track 1).bin" BINARY\n'
          'FILE "Game (Disc 1) (Track 2).bin" BINARY\n',
    );
    write('Game (Disc 1) (Track 1).bin');
    write('Game (Disc 1) (Track 2).bin');
    write('Other Game.bin');

    final moved = await organizer.hide([cue.path], platformDir);

    expect(moved[cue.path], hidden('Game (Disc 1).cue'));
    expect(File(hidden('Game (Disc 1) (Track 1).bin')).existsSync(), isTrue);
    expect(File(hidden('Game (Disc 1) (Track 2).bin')).existsSync(), isTrue);
    expect(cue.existsSync(), isFalse);
    expect(File(p.join(platformDir.path, 'Other Game.bin')).existsSync(),
        isTrue);
  });

  test('moves extraction folders and single files', () async {
    final folder = Directory(p.join(platformDir.path, 'Game (Disc 1)'))
      ..createSync();
    File(p.join(folder.path, 'Game (Disc 1).cue')).writeAsStringSync('');
    final chd = write('Game (Disc 2).chd');

    final moved = await organizer.hide([folder.path, chd.path], platformDir);

    expect(moved[folder.path], hidden('Game (Disc 1)'));
    expect(moved[chd.path], hidden('Game (Disc 2).chd'));
    expect(File(hidden('Game (Disc 1)/Game (Disc 1).cue')).existsSync(),
        isTrue);
  });

  test('a name conflict moves nothing and overwrites nothing', () async {
    final disc1 = write('Game (Disc 1).chd', 'new 1');
    final disc2 = write('Game (Disc 2).chd', 'new 2');
    File(hidden('Game (Disc 2).chd'))
      ..createSync(recursive: true)
      ..writeAsStringSync('old');

    await expectLater(
      organizer.hide([disc1.path, disc2.path], platformDir),
      throwsA(isA<DiscOrganizeException>()),
    );
    expect(disc1.existsSync(), isTrue);
    expect(disc2.existsSync(), isTrue);
    expect(File(hidden('Game (Disc 2).chd')).readAsStringSync(), 'old');
  });

  test('a missing disc fails before moving anything', () async {
    final disc1 = write('Game (Disc 1).chd');

    await expectLater(
      organizer.hide(
        [disc1.path, p.join(platformDir.path, 'gone.chd')],
        platformDir,
      ),
      throwsA(isA<DiscOrganizeException>()),
    );
    expect(disc1.existsSync(), isTrue);
  });

  test('running again on hidden discs changes nothing', () async {
    final disc = write('Game (Disc 1).chd');
    final first = await organizer.hide([disc.path], platformDir);
    final again = await organizer.hide([first[disc.path]!], platformDir);

    expect(again[first[disc.path]!], first[disc.path]);
    expect(File(first[disc.path]!).existsSync(), isTrue);
  });
}
