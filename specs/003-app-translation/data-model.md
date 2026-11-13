# Data Model: App Translation

## Translation file (ARB)

- `lib/l10n/app_en.arb` — template: `"key": "English text"` plus `"@key": {"description": …,
  "placeholders": {…}}` for every key.
- `lib/l10n/app_<code>.arb` — `"@@locale": "<code>"` and translated values only.
- Keys: lowerCamelCase, prefixed by area (`browse…`, `downloads…`, `library…`, `settings…`,
  `detail…`, `common…`, `error…`, `notification…`).
- Plurals use ICU: `"{count, plural, =1{1 disc} other{{count} discs}}"`.

## Language preference

| Field | Type | Values |
|---|---|---|
| `appLanguage` | `String?` | `null` = system default, else a supported language code |

Persisted under shared_preferences key `app_language`. Unsupported stored values fall back to
system default.
