# Research: On-Device CHD Conversion

- **CHDBOY**: GPL-2.0 — incompatible with the MIT constitution. Not reused.
- **MAME chdman / CHD core**: `chdman.cpp`, `chd.cpp`, `chdcodec.cpp`, `cdrom.cpp`,
  `huffman.cpp`, `flac.cpp` are BSD-3-Clause. Usable.
- **libchdman-rs** (BSD-3): vendored MAME 0.289 subset + C shims (incl. a port of
  chdman's `chd_cd_compressor`); used as the source of the vendored tree and shims, not
  as a Rust dependency (single maintainer, no Android target, would add Rust).
- **chd-rs**: read-only. **Pure Dart**: no maintained LZMA/FLAC encoders.
- **Build**: Flutter 3.38 build hooks + `native_toolchain_c` compile the C/C++ without
  Gradle/CMake. Android needs `-lc++abi -lm` with `c++_static`.
- **Spike results**: WipEout (697 MB, 12 audio tracks) → 427,006,514-byte CHD with the
  same SHA-1 as `chdman createcd` on macOS (10 s) and on the AYN Thor (20 s + 9 s verify).
