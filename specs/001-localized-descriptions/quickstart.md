# Quickstart: Localized Game Descriptions

## Automated checks

```sh
flutter pub get
flutter analyze
flutter test test/metadata
flutter build apk --debug
```

## On-device validation (AYN Thor)

1. Install the debug APK: `adb install -r build/app/outputs/flutter-apk/app-debug.apk`.
2. Settings → enable game metadata and log in to ScreenScraper.
3. Device language **Français**: open *Metal Gear Solid* (PlayStation) → description in French.
4. Open a game with no French synopsis (an obscure Japan-only title) → English description.
5. Switch the device to **English**, reopen *Metal Gear Solid* → English description.
6. Switch back to **Français**, reopen → French again (cache is per language).
7. Check screenshots still appear on all of the above.
