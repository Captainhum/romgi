# Research: Clear Multi-Disc Downloads

## 1. What to move
- Extracted multi-file archives land in `<platform>/<archive name>/` → move the folder.
- Single extracted files and direct downloads land in `<platform>/<file>` → move the file; for a
  `.cue`, also move every file named in its `FILE "..."` lines (resolved next to the cue).
- **Decision**: `DiscOrganizer.filesFor(path)` returns the entities to move; directories move as a
  whole.

## 2. Safety
- **Decision**: `File.rename`/`Directory.rename` within the platform folder (same volume, atomic,
  no copy). Before any move, check every target is free; if one exists with identical size it is
  reused, otherwise abort with a conflict error and move nothing. On a failure mid-way, moved
  entities are renamed back.
- `.m3u` relative paths come from `PlaylistWriter.resolvePlaylistEntry` (already relative to the
  platform dir), so paths become `.hidden/...` automatically.

## 3. Where the flag lives
- **Decision**: per task `group_hidden` column (DB v9), set at enqueue. Survives restarts and
  lets a later retry of a failed disc still organize the set.
- Alternative: global setting read at completion — rejected, the user's choice in the sheet must
  apply to that game only.

## 4. Sources per disc
- `LinkResolver.rank(entry.links, prefs)` already orders a disc's links; the sheet shows them
  in that order with the first pre-selected, size from `DownloadLink.sizeStr`.

## 5. Existing separately downloaded discs (Library)
- Find the entry group of a completed item (`romDb.getEntryGroup(slug)`), map members to
  completed downloads by slug, backfill group fields, then run the same organizer + playlist.
