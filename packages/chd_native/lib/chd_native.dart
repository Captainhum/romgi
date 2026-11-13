/// Creates and verifies CHD disc images on the device with MAME's CHD
/// library (MAME 0.289), producing the same files as `chdman createcd`.
library;

import 'dart:async';
import 'dart:ffi';
import 'dart:isolate';

import 'package:ffi/ffi.dart';

enum ChdStatus { ok, badInput, outputFailed, compressFailed, cancelled, corrupt, internal }

ChdStatus _status(int code) =>
    code >= 0 && code < ChdStatus.values.length
        ? ChdStatus.values[code]
        : ChdStatus.internal;

@Native<Int32 Function(Pointer<Utf8>, Pointer<Utf8>, Pointer<Double>, Pointer<Int32>)>(
  symbol: 'romgi_chd_create_cd',
)
external int _createCd(
  Pointer<Utf8> cuePath,
  Pointer<Utf8> chdPath,
  Pointer<Double> progress,
  Pointer<Int32> cancel,
);

@Native<Int32 Function(Pointer<Utf8>, Pointer<Double>, Pointer<Int32>)>(
  symbol: 'romgi_chd_verify',
)
external int _verify(
  Pointer<Utf8> chdPath,
  Pointer<Double> progress,
  Pointer<Int32> cancel,
);

@Native<Int64 Function(Pointer<Utf8>)>(symbol: 'romgi_free_bytes')
external int _freeBytes(Pointer<Utf8> path);

/// Free bytes on the volume holding [path], or null when unknown.
int? freeBytes(String path) {
  final native = path.toNativeUtf8();
  try {
    final bytes = _freeBytes(native);
    return bytes < 0 ? null : bytes;
  } finally {
    malloc.free(native);
  }
}

/// Lets the caller stop a running [createCdChd] or [verifyChd].
class ChdCancelToken {
  Pointer<Int32>? _flag;
  bool _cancelled = false;

  bool get isCancelled => _cancelled;

  void cancel() {
    _cancelled = true;
    _flag?.value = 1;
  }
}

/// Converts the disc described by [cuePath] (CUE, TOC, GDI or ISO) into a
/// CHD at [chdPath] on a background isolate. A failed or cancelled
/// conversion leaves no output file.
Future<ChdStatus> createCdChd(
  String cuePath,
  String chdPath, {
  void Function(double progress)? onProgress,
  ChdCancelToken? cancelToken,
}) =>
    _run(
      (progress, cancel) => _spawnCreate(cuePath, chdPath, progress, cancel),
      onProgress,
      cancelToken,
    );

/// Reads the whole CHD at [chdPath] and checks its SHA-1s, like
/// `chdman verify`.
Future<ChdStatus> verifyChd(
  String chdPath, {
  void Function(double progress)? onProgress,
  ChdCancelToken? cancelToken,
}) =>
    _run(
      (progress, cancel) => _spawnVerify(chdPath, progress, cancel),
      onProgress,
      cancelToken,
    );

// The isolate closures below are built in functions whose only locals are
// strings and addresses: a closure sends its whole enclosing context, so
// building it next to the caller's callbacks would try to send those too.

Future<int> _spawnCreate(String cue, String chd, int progress, int cancel) =>
    Isolate.run(() {
      final cuePtr = cue.toNativeUtf8();
      final chdPtr = chd.toNativeUtf8();
      try {
        return _createCd(
          cuePtr,
          chdPtr,
          Pointer<Double>.fromAddress(progress),
          Pointer<Int32>.fromAddress(cancel),
        );
      } finally {
        malloc.free(cuePtr);
        malloc.free(chdPtr);
      }
    });

Future<int> _spawnVerify(String chd, int progress, int cancel) =>
    Isolate.run(() {
      final chdPtr = chd.toNativeUtf8();
      try {
        return _verify(
          chdPtr,
          Pointer<Double>.fromAddress(progress),
          Pointer<Int32>.fromAddress(cancel),
        );
      } finally {
        malloc.free(chdPtr);
      }
    });

/// Runs [job] (given the addresses of native progress/cancel cells) and
/// polls the progress cell from this isolate.
Future<ChdStatus> _run(
  Future<int> Function(int progressAddress, int cancelAddress) job,
  void Function(double progress)? onProgress,
  ChdCancelToken? cancelToken,
) async {
  final progress = calloc<Double>();
  final cancel = calloc<Int32>();
  cancelToken?._flag = cancel;
  if (cancelToken?.isCancelled ?? false) cancel.value = 1;

  final timer = onProgress == null
      ? null
      : Timer.periodic(
          const Duration(milliseconds: 250),
          (_) => onProgress(progress.value),
        );
  try {
    final code = await job(progress.address, cancel.address);
    onProgress?.call(progress.value);
    return _status(code);
  } finally {
    timer?.cancel();
    cancelToken?._flag = null;
    calloc.free(progress);
    calloc.free(cancel);
  }
}
