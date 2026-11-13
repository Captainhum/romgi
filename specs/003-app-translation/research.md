# Research: App Translation

## 1. Localization system

- **Decision**: Flutter `gen-l10n` with ARB files.
- **Rationale**: official, no third-party runtime dependency, ICU plurals/placeholders,
  type-safe getters, natively supported by Weblate ("ARB file" format).
- **Alternatives**: `easy_localization` (stringly-typed keys, extra dependency), `slang`
  (typed but extra generator and dependency). Automatic extractors (`intl_cli`,
  `string_extractor_intl`) rejected: they mis-handle interpolated strings and non-UI literals;
  strings are migrated by hand, screen by screen.

## 2. Strings outside widgets

- **Decision**: `l10nFor(Locale)` wraps generated `lookupAppLocalizations`; the active locale
  is resolved from the language setting (or device locale) by a Riverpod provider and passed to
  notification/background code.
- `DownloadTask.statusText` becomes `statusText(AppLocalizations l10n)`.
- Error messages produced by remote services (debrid, ScreenScraper, Internet Archive) that are
  stored in download records stay as received; generic network errors in `error_utils.dart` are
  localized at display time.

## 3. Language preference

- **Decision**: `SettingsState.appLanguage` (`String?`, null = system), persisted in
  `shared_preferences`, exposed as a list tile in Settings > Appearance.
- `MaterialApp.locale` = chosen locale or null (system). `metadataLanguageProvider` (feature 001)
  reads the same setting first.

## 4. Guarding against regressions

- **Decision**: a unit test scans `lib/screens` and `lib/widgets` for string literals passed to
  `Text(`, `label:`, `title:`, `tooltip:`, `hintText:`, `labelText:` that start with a capital
  letter; an allowlist covers proper nouns (ScreenScraper, Internet Archive, TorBox…).
- **Decision**: an ARB parity test checks every `app_*.arb` only uses keys and placeholders
  defined in `app_en.arb`.

## 5. Community translation

- **Decision**: Weblate (hosted.weblate.org, libre plan for open source), component format
  "ARB file", file mask `lib/l10n/app_*.arb`, template `lib/l10n/app_en.arb`. Weblate commits
  translations back through pull requests.
- **Manual step (project owner)**: create the Weblate project with the GitHub account; cannot
  be automated from this repository.
