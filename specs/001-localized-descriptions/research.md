# Research: Localized Game Descriptions

## 1. Where the language is chosen today

- **Finding**: `lib/services/metadata/screenscraper_provider.dart` `_synopsis()` picks
  `e['langue'] == 'en'`, else the first entry. The `jeuRecherche.php` response already contains
  every synopsis language (`synopsis: [{langue, text}, …]`).
- **Decision**: select in Dart from the existing response; no change to the request.
- **Rationale**: zero extra network calls (SC-004), no API quota impact.
- **Alternatives considered**: a ScreenScraper "language" query parameter — unnecessary since all
  languages are returned, and it would not help the fallback chain.

## 2. Language source

- **Decision**: a Riverpod `metadataLanguageProvider` returning the base language code of
  `PlatformDispatcher.instance.locale` (`fr_CA` → `fr`), lower-cased.
- **Rationale**: one place to change when feature 003 adds an in-app language setting (it will
  watch the setting and fall back to the device locale). `PlatformDispatcher` works without a
  `BuildContext`.
- **Alternatives considered**: `Platform.localeName` (string parsing, less reliable); reading
  `Localizations.localeOf(context)` in the widget (couples the service call to the widget tree,
  and the app has no localization delegates yet).
- **Reactivity**: `gameMetadataProvider` is `autoDispose.family`, so it is rebuilt each time a
  detail page opens; Android restarts the activity on a system language change. Reopening a game
  therefore uses the new language (SC-002) without a locale observer.

## 3. Cache isolation

- **Finding**: cache key is `'${platform}|${title.toLowerCase()}'`; TTLs differ for hits/misses.
- **Decision**: key becomes `'${platform}|${title.toLowerCase()}|$language'`.
- **Rationale**: satisfies FR-004 with no schema change; old keys are simply never read again and
  age out. Screenshots are re-fetched once per language, which is acceptable (one request).
- **Alternatives considered**: caching all synopses and selecting at read time — better reuse,
  but changes the cached payload format and `GameMetadata` model; not worth it for this scope.

## 4. Fallback rules

- **Decision**: requested language → `en` → first entry with non-blank text; blank texts are
  skipped at every step.
- **Rationale**: matches spec acceptance scenarios 1–3 and FR-002/FR-003.
- ScreenScraper language codes are ISO 639-1 lower-case (`fr`, `en`, `de`, `es`, `it`, `pt`…),
  matching Flutter's `languageCode`.
