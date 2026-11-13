# chd_native

On-device CHD creation and verification for romgi, using MAME's CHD library
(MAME 0.289). `createCdChd` produces the same file as `chdman createcd`
(byte-identical, default codecs `cdlz,cdzl,cdfl`) and `verifyChd` checks a
CHD like `chdman verify`.

The native code is built by `hook/build.dart` (Dart build hooks), for
Android and for the host so `dart test` works on a desktop.

```dart
final status = await createCdChd(
  'Game.cue',
  'Game.chd',
  onProgress: (p) => print('${(p * 100).round()}%'),
);
```

## Third-party code

| Path | Origin | License |
|---|---|---|
| `third_party/mame/src` | MAME 0.289 CHD core (`src/lib/util`, `src/osd`) | BSD-3-Clause (see `third_party/mame/COPYING`) |
| `third_party/mame/3rdparty/zlib` | zlib | zlib |
| `third_party/mame/3rdparty/lzma` | LZMA SDK | public domain |
| `third_party/mame/3rdparty/flac` | libFLAC | BSD-3-Clause (`COPYING.Xiph`) |
| `third_party/mame/3rdparty/zstd` | Zstandard | BSD-3-Clause |
| `third_party/mame/3rdparty/utf8proc` | utf8proc | MIT |
| `src/chd_shim.*`, `src/cd_shim.cpp`, `src/minimal_osd.cpp`, `src/shim_guard.h` | [libchdman-rs](https://github.com/danifunker/libchdman-rs) | BSD-3-Clause (`third_party/LICENSE.libchdman-rs`) |

`src/romgi_chd.cpp` follows chdman's `createcd`/`verify` (MAME
`src/tools/chdman.cpp`, BSD-3-Clause, Aaron Giles).
