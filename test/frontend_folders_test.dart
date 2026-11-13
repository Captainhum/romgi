import 'package:flutter_test/flutter_test.dart';
import 'package:romgi/utils/frontend_folders.dart';
import 'package:romgi/utils/platform_names.dart';

void main() {
  test('ES-DE names for the common platforms', () {
    expect(platformFolderName('ps1', esde: true), 'psx');
    expect(platformFolderName('3ds', esde: true), 'n3ds');
    expect(platformFolderName('sms', esde: true), 'mastersystem');
    expect(platformFolderName('vita', esde: true), 'psvita');
  });

  test('romgi ids when the layout is off or the platform unknown', () {
    expect(platformFolderName('ps1', esde: false), 'ps1');
    expect(platformFolderName('brand-new', esde: true), 'brand-new');
  });

  test('every platform romgi names has an ES-DE folder', () {
    final missing = PlatformNames.knownIds
        .where((id) => !esdeFolderNames.containsKey(id))
        .toList();
    expect(missing, isEmpty);
  });
}
