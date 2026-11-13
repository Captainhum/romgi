import 'package:code_assets/code_assets.dart';
import 'package:hooks/hooks.dart';
import 'package:logging/logging.dart';
import 'package:native_toolchain_c/native_toolchain_c.dart';

/// Builds MAME's CHD library (third_party/mame, MAME 0.289) with its bundled
/// codecs, and the romgi entry points in src/romgi_chd.cpp.
void main(List<String> args) async {
  await build(args, (input, output) async {
    if (!input.config.buildCodeAssets) return;

    final logger = Logger('')
      ..level = Level.INFO
      // ignore: avoid_print
      ..onRecord.listen((record) => print(record.message));
    final code = input.config.code;
    final os = code.targetOS;
    final arch = code.targetArchitecture;

    const mame = 'third_party/mame';
    const tp = '$mame/3rdparty';

    Future<void> staticLib(
      String name,
      List<String> sources, {
      List<String> includes = const [],
      Map<String, String?> defines = const {},
    }) => CBuilder.library(
      name: name,
      sources: sources,
      includes: includes,
      defines: defines,
      linkModePreference: LinkModePreference.static,
      flags: ['-w'],
    ).run(input: input, output: output, logger: logger);

    await staticLib('chd_zlib', [
      for (final f in [
        'adler32', 'compress', 'crc32', 'deflate', 'inffast', 'inflate',
        'inftrees', 'trees', 'uncompr', 'zutil',
      ])
        '$tp/zlib/$f.c',
    ]);

    await staticLib(
      'chd_lzma',
      [
        for (final f in [
          'LzmaDec', 'LzmaEnc', 'Lzma2Dec', 'Lzma2Enc', '7zCrc', '7zCrcOpt',
          'CpuArch', 'LzFind', 'Alloc',
        ])
          '$tp/lzma/C/$f.c',
      ],
      includes: ['$tp/lzma/C'],
      defines: {'Z7_ST': null},
    );

    await staticLib(
      'chd_zstd',
      [
        for (final f in [
          'common/debug', 'common/xxhash', 'common/pool',
          'common/entropy_common', 'common/error_private',
          'common/fse_decompress', 'common/threading', 'common/zstd_common',
          'decompress/zstd_decompress_block', 'decompress/zstd_decompress',
          'decompress/zstd_ddict', 'decompress/huf_decompress',
          'compress/zstd_lazy', 'compress/zstd_compress_superblock',
          'compress/zstdmt_compress', 'compress/fse_compress',
          'compress/zstd_compress_literals', 'compress/zstd_compress_sequences',
          'compress/zstd_fast', 'compress/zstd_compress', 'compress/zstd_opt',
          'compress/zstd_double_fast', 'compress/zstd_ldm', 'compress/hist',
          'compress/huf_compress',
        ])
          '$tp/zstd/lib/$f.c',
      ],
      includes: ['$tp/zstd/lib', '$tp/zstd/lib/common'],
      defines: {'ZSTD_DISABLE_ASM': null},
    );

    await staticLib(
      'chd_utf8proc',
      ['$tp/utf8proc/utf8proc.c'],
      includes: ['$tp/utf8proc'],
    );

    await staticLib(
      'chd_flac',
      [
        for (final f in [
          'bitmath', 'bitreader', 'bitwriter', 'cpu', 'crc', 'fixed', 'float',
          'format', 'lpc', 'md5', 'memory', 'metadata_iterators',
          'metadata_object', 'stream_decoder', 'stream_encoder',
          'stream_encoder_framing', 'window',
        ])
          '$tp/flac/src/libFLAC/$f.c',
        if (arch == Architecture.arm64) '$tp/flac/src/libFLAC/lpc_intrin_neon.c',
      ],
      includes: ['$tp/flac/include', '$tp/flac/src/libFLAC/include'],
      defines: {
        'HAVE_CONFIG_H': null,
        'FLAC__HAS_OGG': '0',
        'HAVE_LROUND': '1',
        'HAVE_INTTYPES_H': '1',
        'HAVE_STDBOOL_H': '1',
        'HAVE_STDINT_H': '1',
        'HAVE_STDIO_H': '1',
        'HAVE_STDLIB_H': '1',
        'HAVE_STRING_H': '1',
        'SIZE_T_MAX': 'UINT64_MAX',
        if (arch != Architecture.arm64) 'FLAC__NO_ASM': null,
      },
    );

    await CBuilder.library(
      name: input.packageName,
      assetName: 'chd_native.dart',
      language: Language.cpp,
      std: 'c++20',
      cppLinkStdLib: os == OS.android ? 'c++_static' : null,
      sources: [
        for (final f in [
          'chd', 'chdcodec', 'hashing', 'ioprocs', 'md5', 'flac', 'huffman',
          'avhuff', 'cdrom', 'strformat', 'corestr', 'unicode', 'bitmap',
          'palette', 'corefile', 'vecstream', 'path',
        ])
          '$mame/src/lib/util/$f.cpp',
        '$mame/src/osd/strconv.cpp',
        'src/minimal_osd.cpp',
        'src/chd_shim.cpp',
        'src/cd_shim.cpp',
        'src/romgi_chd.cpp',
      ],
      includes: [
        'src',
        '$mame/src/lib/util',
        '$mame/src/osd',
        tp,
        '$tp/zlib',
        '$tp/flac/include',
        '$tp/lzma/C',
        '$tp/zstd/lib',
        '$tp/utf8proc',
      ],
      defines: {
        'LSB_FIRST': null,
        'CRLF': '2',
        'SDLMAME_UNIX': null,
        if (os == OS.macOS) ...{'SDLMAME_MACOSX': null, 'SDLMAME_DARWIN': null}
        else 'SDLMAME_LINUX': null,
        'FLAC__NO_DLL': null,
      },
      flags: [
        '-w', '-fexceptions', '-frtti',
        // c++_static doesn't pull in the ABI library (typeinfo, exceptions)
        if (os == OS.android) ...['-lc++abi', '-lm'],
      ],
      libraries: [
        'chd_flac', 'chd_zstd', 'chd_lzma', 'chd_zlib', 'chd_utf8proc',
      ],
      libraryDirectories: ['.'],
    ).run(input: input, output: output, logger: logger);
  });
}
