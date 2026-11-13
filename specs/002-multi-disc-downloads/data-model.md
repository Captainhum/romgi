# Data Model: Clear Multi-Disc Downloads

## DownloadTask (existing) — new field
| Field | Column | Type | Notes |
|---|---|---|---|
| `groupHidden` | `group_hidden` | bool (INTEGER 0/1) | discs go to `.hidden/` once the set completes |

DB version 8 → 9: `ALTER TABLE downloads ADD COLUMN group_hidden INTEGER NOT NULL DEFAULT 0`.

## DiscSelection (UI only)
`{slug, label, index, links: List<ResolvedLink>, selected: DownloadLink?}` — `selected` null =
unavailable.

## Settings
| Key | Type | Default | Meaning |
|---|---|---|---|
| `disc_hide_default` | bool | true | last choice of the sheet checkbox |
| `disc_set_prompt` | bool | true | ask for the full game when downloading one disc |

## Organized layout
```
<platform>/<Group title>.m3u          # .hidden/<disc 1 entry>\n.hidden/<disc 2 entry>\n
<platform>/.hidden/<disc files or folders>
```
