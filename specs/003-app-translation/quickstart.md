# Quickstart: App Translation

## Automated checks

```sh
flutter gen-l10n
flutter analyze
flutter test
flutter build apk --debug
```

## Add a language (contributors)

1. Copy `lib/l10n/app_en.arb` to `lib/l10n/app_<code>.arb` (e.g. `app_es.arb`), set
   `"@@locale": "<code>"`, translate the values (not the `@` entries).
2. Run `flutter gen-l10n`. The language appears automatically in Settings.
   Or translate on Weblate (link in README) — no local setup needed.

## On-device validation (AYN Thor)

1. Install the debug APK (`adb install -r build/app/outputs/flutter-apk/app-debug.apk`).
2. Device in French: walk Browse, a game page, Downloads, Library, Settings, dialogs → French.
3. Settings → Language → English: app switches immediately; restart → still English.
4. Language → System default: back to French.
5. Start a download: notification texts are in the app language.
6. Check the bottom screen and narrow layouts for overflowing French text.
