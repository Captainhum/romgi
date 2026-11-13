# Implementation Plan: On-Device CHD Conversion

**Branch**: `004-chd-conversion` | **Date**: 2026-11-13 | **Spec**: [spec.md](spec.md)

## Summary

Embed MAME 0.289's CHD library (BSD-3) and its codecs in a local FFI package,
`packages/chd_native`, compiled by Dart build hooks (Flutter 3.38) for Android and
the host. `createCdChd` reproduces `chdman createcd` byte for byte (default codecs
cdlz/cdzl/cdfl) and `verifyChd` reproduces `chdman verify`. A Dart `ChdConverter`
finds the disc descriptor of a download (CUE, GDI, ISO; file or extraction folder),
checks free space, converts on a background isolate, verifies, and only then deletes
the originals. `DownloadService` runs it after each completed download of a CD
platform when enabled, with a new `converting` status, progress, cancel, crash
recovery, and before the multi-disc playlist (feature 002) so `.hidden/` gets CHDs.

## Technical Context

**Language/Version**: Dart ^3.10.1 / Flutter 3.38.7; C++20 + C for the native part
**Primary Dependencies**: MAME 0.289 `src/lib/util` CHD core, zlib, LZMA SDK, libFLAC,
zstd, utf8proc (vendored via libchdman-rs, all MIT-compatible); `hooks`,
`native_toolchain_c`, `code_assets`, `ffi`
**Storage**: settings `chd_enabled` (false) + `chd_disabled_platform_*`;
`DownloadStatus.converting` appended (status stored by index)
**Testing**: `dart test` in packages/chd_native (incl. `chdman verify` when installed),
`flutter test` (ChdConverter with the real encoder), integration tests on device
**Target Platform**: Android arm64 (AYN Thor); host build for tests
**Performance Goals**: ≤ 3 min per 650 MB disc on device — measured 20 s (WipEout)
**Constraints**: originals deleted only after a verified CHD; one conversion at a time

## Constitution Check

| Principle | Check | Status |
|---|---|---|
| I. Our App, Upstream-Aware | Isolated package + small hooks in the download service | ✅ |
| II. Opt-In and Non-Destructive | Off by default; verify-then-delete; failures keep originals | ✅ |
| III. Launcher-Ready Output | One `.chd` per disc; works with `.hidden/` + `.m3u` | ✅ |
| IV. Tested Logic, Green CI | Byte-identical to chdman on a real game (Mac and Thor) | ✅ |
| V. Open to Contributors | All new strings in ARB | ✅ |
| VI. Device-Aware Native Work | Background isolate, foreground service, free-space check, arm64 | ✅ |

Licensing: every vendored component is MIT-compatible (see packages/chd_native/README.md).

## Project Structure

```text
packages/chd_native/            # FFI package: hook/build.dart, src/ (C API + shims), third_party/mame
lib/services/chd_converter.dart # find source, space check, convert, verify, delete originals
lib/services/download_service.dart  # _maybeConvert after completion, cancel, crash recovery
lib/providers/settings_provider.dart  # chdEnabled, chdDisabledPlatforms
lib/screens/{settings,downloads,library}_screen.dart, lib/widgets/disc_group_sheet.dart
test/chd_converter_test.dart, integration_test/chd_*_test.dart
```

## Complexity Tracking

| Violation | Why Needed | Simpler Alternative Rejected Because |
|---|---|---|
| Vendored native C/C++ (~8.7 MB source) | Only way to match chdman's compression and output | Pure-Dart zlib-only encoder: larger files, no LZMA/FLAC |
