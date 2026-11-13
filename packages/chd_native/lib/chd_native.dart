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
      (progress, cancel) {
        final cue = cuePath.toNativeUtf8();
        final chd = chdPath.toNativeUtf8();
        try {
          return _createCd(cue, chd, progress, cancel);
        } finally {
          malloc.free(cue);
          malloc.free(chd);
        }
      },
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
      (progress, cancel) {
        final chd = chdPath.toNativeUtf8();
        try {
          return _verify(chd, progress, cancel);
        } finally {
          malloc.free(chd);
        }
      },
      onProgress,
      cancelToken,
    );

/// Runs [job] on an isolate with native progress/cancel cells that this
/// isolate polls and sets.
Future<ChdStatus> _run(
  int Function(Pointer<Double> progress, Pointer<Int32> cancel) job,
  void Function(double progress)? onProgress,
  ChdCancelToken? cancelToken,
) async {
  final progress = calloc<Double>();
  final cancel = calloc<Int32>();
  cancelToken?._flag = cancel;
  if (cancelToken?.isCancelled ?? false) cancel.value = 1;

  final progressAddress = progress.address;
  final cancelAddress = cancel.address;
  final timer = onProgress == null
      ? null
      : Timer.periodic(
          const Duration(milliseconds: 250),
          (_) => onProgress(progress.value),
        );
  try {
    final code = await Isolate.run(
      () => job(
        Pointer<Double>.fromAddress(progressAddress),
        Pointer<Int32>.fromAddress(cancelAddress),
      ),
    );
    onProgress?.call(progress.value);
    return _status(code);
  } finally {
    timer?.cancel();
    cancelToken?._flag = null;
    calloc.free(progress);
    calloc.free(cancel);
  }
}
