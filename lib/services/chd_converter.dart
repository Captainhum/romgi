import 'dart:async';
import 'dart:io';

import 'package:chd_native/chd_native.dart';
import 'package:path/path.dart' as p;

import 'disc_organizer.dart';

/// Why a conversion did not produce a CHD. The original files are always
/// left in place when one of these is reported.
enum ChdConversionError {
  notConvertible,
  alreadyExists,
  noSpace,
  badInput,
  failed,
  verifyFailed,
  cancelled,
}

class ChdConversionException implements Exception {
  ChdConversionException(this.error, [this.neededBytes]);

  final ChdConversionError error;

  /// Bytes the conversion needed, for [ChdConversionError.noSpace].
  final int? neededBytes;

  @override
  String toString() => 'ChdConversionException: ${error.name}';
}

/// Converts downloaded disc images (CUE/BIN, GDI, ISO) to a single CHD with
/// [createCdChd], verifies it, then removes the originals. Conversions run
/// one at a time.
class ChdConverter {
  ChdConverter({
    this.create = createCdChd,
    this.verify = verifyChd,
    this.freeSpace = freeBytes,
  });

  final Future<ChdStatus> Function(
    String input,
    String output, {
    void Function(double progress)? onProgress,
    ChdCancelToken? cancelToken,
  }) create;
  final Future<ChdStatus> Function(
    String chd, {
    void Function(double progress)? onProgress,
    ChdCancelToken? cancelToken,
  }) verify;
  final int? Function(String path) freeSpace;

  /// Platforms whose games ship on CDs that `createcd` handles.
  static const Set<String> cdPlatforms = {
    'ps1', 'psx', 'scd', 'segacd', 'saturn', 'sat', 'dc', 'dreamcast',
    'jcd', 'pcfx', 'tgcd', 'ngcd', '3do', 'cdi', 'fmt', 'pip',
  };

  /// Disc descriptors, in preference order.
  static const List<String> sourceExtensions = ['.cue', '.gdi', '.iso'];

  Future<void> _queue = Future.value();

  static bool supportsPlatform(String platform) =>
      cdPlatforms.contains(platform);

  /// The disc descriptor to convert for a download at [path] (a file, or a
  /// folder an archive was extracted to), or null when there is none.
  static Future<String?> findSource(String path) async {
    if (await File(path).exists()) {
      return sourceExtensions.contains(p.extension(path).toLowerCase())
          ? path
          : null;
    }
    if (!await Directory(path).exists()) return null;
    final files = await Directory(path)
        .list()
        .where((e) => e is File)
        .map((e) => e.path)
        .toList()
      ..sort();
    for (final ext in sourceExtensions) {
      for (final file in files) {
        if (p.extension(file).toLowerCase() == ext) return file;
      }
    }
    return null;
  }

  /// Where the CHD for a download at [path] goes: beside the file, or
  /// beside the extraction folder, named after it.
  static Future<String> outputFor(String path, String source) async {
    if (await Directory(path).exists()) return '$path.chd';
    return p.setExtension(source, '.chd');
  }

  /// Converts the download at [path] and returns the CHD path. Throws a
  /// [ChdConversionException] and leaves every original file in place on
  /// failure or cancellation.
  Future<String> convert(
    String path, {
    void Function(double progress)? onProgress,
    ChdCancelToken? cancelToken,
  }) {
    final run = _queue.then(
      (_) => _convert(path, onProgress, cancelToken),
    );
    _queue = run.then((_) {}, onError: (_) {});
    return run;
  }

  Future<String> _convert(
    String path,
    void Function(double progress)? onProgress,
    ChdCancelToken? cancelToken,
  ) async {
    if (cancelToken?.isCancelled ?? false) {
      throw ChdConversionException(ChdConversionError.cancelled);
    }
    final source = await findSource(path);
    if (source == null) {
      throw ChdConversionException(ChdConversionError.notConvertible);
    }
    final output = await outputFor(path, source);
    if (await File(output).exists()) {
      throw ChdConversionException(ChdConversionError.alreadyExists);
    }

    final originals = await _originals(path, source);
    final inputBytes = await _size(originals);
    final available = freeSpace(p.dirname(output));
    if (available != null && available < inputBytes) {
      throw ChdConversionException(ChdConversionError.noSpace, inputBytes);
    }

    // Compression is ~90% of the work, verification the rest.
    final status = await create(
      source,
      output,
      onProgress: onProgress == null ? null : (v) => onProgress(v * 0.9),
      cancelToken: cancelToken,
    );
    if (status != ChdStatus.ok) {
      await _deleteQuietly(output);
      throw ChdConversionException(switch (status) {
        ChdStatus.cancelled => ChdConversionError.cancelled,
        ChdStatus.badInput => ChdConversionError.badInput,
        _ => ChdConversionError.failed,
      });
    }

    final verified = await verify(
      output,
      onProgress:
          onProgress == null ? null : (v) => onProgress(0.9 + v * 0.1),
      cancelToken: cancelToken,
    );
    if (verified != ChdStatus.ok) {
      await _deleteQuietly(output);
      throw ChdConversionException(
        verified == ChdStatus.cancelled
            ? ChdConversionError.cancelled
            : ChdConversionError.verifyFailed,
      );
    }

    for (final entity in originals) {
      await entity.delete(recursive: true);
    }
    return output;
  }

  /// Everything the CHD replaces: the extraction folder, or the descriptor
  /// with the track files it references.
  Future<List<FileSystemEntity>> _originals(String path, String source) async {
    if (await Directory(path).exists()) return [Directory(path)];
    if (p.extension(source).toLowerCase() == '.gdi') {
      final dir = p.dirname(source);
      return [
        File(source),
        for (final name in gdiTrackFiles(await File(source).readAsString()))
          if (await File(p.join(dir, name)).exists()) File(p.join(dir, name)),
      ];
    }
    return DiscOrganizer.entitiesFor(source);
  }

  /// Track file names referenced by a GDI sheet
  /// (`<n> <lba> <type> <size> <file> <offset>` per line).
  static List<String> gdiTrackFiles(String gdi) {
    final names = <String>[];
    for (final line in gdi.split(RegExp(r'\r?\n')).skip(1)) {
      final match = RegExp(r'^\s*\d+\s+\d+\s+\d+\s+\d+\s+("([^"]+)"|(\S+))')
          .firstMatch(line);
      final name = match?.group(2) ?? match?.group(3);
      if (name != null && !names.contains(name)) names.add(name);
    }
    return names;
  }

  Future<int> _size(List<FileSystemEntity> entities) async {
    var total = 0;
    for (final entity in entities) {
      if (entity is File) {
        total += await entity.length();
      } else if (entity is Directory) {
        await for (final f in entity.list(recursive: true)) {
          if (f is File) total += await f.length();
        }
      }
    }
    return total;
  }

  Future<void> _deleteQuietly(String path) async {
    try {
      await File(path).delete();
    } catch (_) {}
  }
}
