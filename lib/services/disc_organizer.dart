import 'dart:io';

import 'package:path/path.dart' as p;

/// Thrown when discs can't be hidden; nothing has been moved when it escapes.
class DiscOrganizeException implements Exception {
  DiscOrganizeException(this.message);

  final String message;

  @override
  String toString() => 'DiscOrganizeException: $message';
}

/// Moves the files of a multi-disc set into `<platform>/.hidden/` so
/// frontends only list the `.m3u` beside them.
///
/// Only renames inside the platform folder: nothing is copied, deleted or
/// overwritten, and a failure part-way puts already moved files back.
class DiscOrganizer {
  static const String hiddenDirName = '.hidden';

  /// Hides every disc in [discPaths] (a file or an extraction folder each)
  /// and returns the new location of each one, keyed by its old path.
  /// Paths already inside `.hidden/` are returned unchanged.
  Future<Map<String, String>> hide(
    List<String> discPaths,
    Directory platformDir,
  ) async {
    final hiddenDir = Directory(p.join(platformDir.path, hiddenDirName));
    final moves = <String, String>{};
    final result = <String, String>{};

    for (final discPath in discPaths) {
      if (p.isWithin(hiddenDir.path, discPath)) {
        result[discPath] = discPath;
        continue;
      }
      for (final entity in await entitiesFor(discPath)) {
        moves[entity.path] = p.join(hiddenDir.path, p.basename(entity.path));
      }
      result[discPath] = p.join(hiddenDir.path, p.basename(discPath));
    }

    for (final target in moves.values) {
      if (await FileSystemEntity.type(target) !=
          FileSystemEntityType.notFound) {
        throw DiscOrganizeException(
          '${p.basename(target)} already exists in $hiddenDirName',
        );
      }
    }
    if (moves.isEmpty) return result;

    await hiddenDir.create(recursive: true);
    final done = <String, String>{};
    try {
      for (final move in moves.entries) {
        await _rename(move.key, move.value);
        done[move.key] = move.value;
      }
    } catch (e) {
      for (final move in done.entries.toList().reversed) {
        try {
          await _rename(move.value, move.key);
        } catch (_) {}
      }
      throw DiscOrganizeException('could not move discs: $e');
    }
    return result;
  }

  /// What has to move for the disc at [path]: the folder itself, a cue
  /// sheet with every track it references, or the single file.
  static Future<List<FileSystemEntity>> entitiesFor(String path) async {
    if (await Directory(path).exists()) return [Directory(path)];
    final file = File(path);
    if (!await file.exists()) {
      throw DiscOrganizeException('${p.basename(path)} not found');
    }
    if (p.extension(path).toLowerCase() != '.cue') return [file];

    final entities = <FileSystemEntity>[file];
    final dir = p.dirname(path);
    for (final name in cueTrackFiles(await file.readAsString())) {
      final track = File(p.join(dir, name));
      if (await track.exists()) entities.add(track);
    }
    return entities;
  }

  /// File names referenced by `FILE "..." BINARY` lines of a cue sheet.
  static List<String> cueTrackFiles(String cue) {
    final names = <String>[];
    for (final match in RegExp(
      r'^\s*FILE\s+(?:"([^"]+)"|(\S+))',
      multiLine: true,
      caseSensitive: false,
    ).allMatches(cue)) {
      final name = p.basename(match.group(1) ?? match.group(2)!);
      if (!names.contains(name)) names.add(name);
    }
    return names;
  }

  Future<void> _rename(String from, String to) async {
    if (await Directory(from).exists()) {
      await Directory(from).rename(to);
    } else {
      await File(from).rename(to);
    }
  }
}
