# Data Model: Localized Game Descriptions

## Synopsis (ScreenScraper response, read-only)

| Field | Type | Notes |
|---|---|---|
| `langue` | string | ISO 639-1 code, lower-case |
| `text` | string | may be empty/whitespace → treated as missing |

Selection: `pickSynopsis(entries, language)` returns the trimmed text of the first match in
order: `langue == language`, `langue == 'en'`, any entry; skipping blank texts. Returns null if
none.

## Metadata cache entry (existing table, new key format)

| Field | Change |
|---|---|
| `key` | `'<platform>|<clean title lower-case>|<language>'` (was without language) |
| `payload`, `fetchedAt`, `noMatch` | unchanged |

No migration: rows with the old key format are never read and expire with the existing TTLs.

## Language code

- Source: `metadataLanguageProvider` → base `languageCode` of the device locale, lower-case.
- Default when unavailable: `en`.
