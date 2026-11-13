/// Folder names that ES-DE, iiSU, Daijishō and most Android frontends look
/// for under their ROMs directory, keyed by romgi platform id.
const Map<String, String> esdeFolderNames = {
  'nes': 'nes', 'famicom': 'famicom', 'fds': 'fds',
  'snes': 'snes', 'sfc': 'sfc',
  'n64': 'n64', 'ndd': 'n64dd',
  'gc': 'gc', 'wii': 'wii', 'wiiu': 'wiiu', 'switch': 'switch',
  'gb': 'gb', 'gbc': 'gbc', 'gba': 'gba', 'vb': 'virtualboy',
  'nds': 'nds', 'ds': 'nds', '3ds': 'n3ds', 'n3ds': 'n3ds',
  'min': 'pokemini',
  'ps1': 'psx', 'psx': 'psx', 'ps2': 'ps2', 'ps3': 'ps3', 'ps4': 'ps4',
  'psp': 'psp', 'psv': 'psvita', 'vita': 'psvita', 'psvita': 'psvita',
  'ps5': 'ps5',
  'xbox': 'xbox', 'x360': 'xbox360', 'xboxone': 'xboxone',
  'xboxsx': 'xboxseries',
  'sms': 'mastersystem', 'sg1000': 'sg-1000',
  'genesis': 'genesis', 'smd': 'genesis', 'megadrive': 'megadrive',
  'md': 'megadrive',
  'scd': 'segacd', 'segacd': 'segacd', '32x': 'sega32x',
  'saturn': 'saturn', 'sat': 'saturn',
  'dc': 'dreamcast', 'dreamcast': 'dreamcast',
  'gg': 'gamegear', 'gamegear': 'gamegear',
  '2600': 'atari2600', 'a26': 'atari2600', 'atari2600': 'atari2600',
  'a52': 'atari5200', 'atari5200': 'atari5200',
  'a78': 'atari7800', 'atari7800': 'atari7800',
  'jag': 'atarijaguar', 'jcd': 'atarijaguarcd', 'lynx': 'atarilynx',
  'pce': 'pcengine', 'tg16': 'tg16', 'tgcd': 'tg-cd', 'sgx': 'supergrafx',
  'pcfx': 'pcfx', 'pc98': 'pc98',
  'neogeo': 'neogeo', 'ng': 'neogeo', 'ngcd': 'neogeocd',
  'ngp': 'ngp', 'ngpc': 'ngpc',
  '3do': '3do', 'cdi': 'cdimono1',
  'cv': 'colecovision', 'intv': 'intellivision',
  'msx': 'msx', 'msx2': 'msx2',
  'wonderswan': 'wonderswan', 'ws': 'wonderswan', 'wsc': 'wonderswancolor',
  'pip': 'pippin',
  'amiga': 'amiga', 'fmt': 'fmtowns', 'c64': 'c64', 'dos': 'dos', 'pc': 'pc',
  'arcade': 'arcade', 'mame': 'mame', 'fbneo': 'fbneo',
};

/// The folder a platform's games go in: the ES-DE name when [esde] is set
/// and known, else romgi's own platform id.
String platformFolderName(String platform, {required bool esde}) =>
    esde ? esdeFolderNames[platform] ?? platform : platform;
