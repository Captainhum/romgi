# Implementation Plan: Clear Multi-Disc Downloads

**Branch**: `002-multi-disc-downloads` | **Date**: 2026-11-13 | **Spec**: [spec.md](spec.md)
**Input**: Feature specification from `specs/002-multi-disc-downloads/spec.md`

## Summary

Replace the silent "Download all discs" button with a confirmation bottom sheet that lists each
disc with a source picker (pre-selected by the existing `LinkResolver` ranking), sizes, total,
destination and a preview of the resulting files, plus a "single entry in launchers" checkbox
(default on, last choice remembered). Queued tasks carry a new `groupHidden` flag. When the last
disc of a hidden group completes, a new `DiscOrganizer` moves each disc's files into
`<platform>/.hidden/` (cue + referenced tracks, or the extracted folder), updates the task
records, then the existing `PlaylistWriter` writes the `.m3u` with `.hidden/...` paths. Moves are
renames inside the platform folder, never overwrite, and roll back on failure. Starting a
single-disc download of a set prompts for the full game (with "don't ask again", revertible in
Settings). The Library offers "Create playlist" for sets downloaded disc by disc.

## Technical Context

**Language/Version**: Dart ^3.10.1, Flutter 3.38.7
**Primary Dependencies**: existing Riverpod, sqflite, path, shared_preferences; gen-l10n (003)
**Storage**: `downloads` table gains `group_hidden INTEGER NOT NULL DEFAULT 0` (DB v9);
two settings keys (`disc_hide_default`, `disc_set_prompt`)
**Testing**: `flutter test` — DiscOrganizer on temp directories (cue parsing, folder moves,
conflicts, rollback, idempotency), PlaylistWriter with hidden layout, settings persistence
**Target Platform**: Android, AYN Thor (SD card)
**Project Type**: mobile app (Flutter)
**Performance Goals**: organizing is instant (same-volume renames)
**Constraints**: never delete/overwrite; option off = current behavior
**Scale/Scope**: 1 new service, 1 new widget, edits to download service/provider, detail and
library screens, settings

## Constitution Check

| Principle | Check | Status |
|---|---|---|
| I. Our App, Upstream-Aware | Organizer and sheet are new files; small hooks in existing ones | ✅ |
| II. Opt-In and Non-Destructive | Rename-only, no overwrite, rollback on failure; option default ON (see Complexity Tracking) | ⚠️ justified |
| III. Launcher-Ready Output | `.hidden/` + `<Title>.m3u`, relative forward-slash paths, LF; extends PlaylistWriter | ✅ |
| IV. Tested Logic, Green CI | Organizer and playlist tests on temp dirs; device test with MGS / Driver 2 | ✅ |
| V. Open to Contributors | All new strings in ARB (FR + EN) | ✅ |
| VI. Device-Aware Native Work | No native code | ➖ |

## Project Structure

```text
lib/services/disc_organizer.dart        # NEW: move disc files into .hidden/, rollback, cue parsing
lib/services/playlist_writer.dart       # organize first when the group is hidden
lib/services/download_service.dart      # addDiscGroup(overrides, hide), organizeExistingGroup
lib/services/database_service.dart      # v9 migration, group_hidden column, updateDownloadPath
lib/models/download_task.dart           # groupHidden field
lib/providers/settings_provider.dart    # discHideDefault, discSetPrompt
lib/providers/download_provider.dart    # pass-through methods
lib/widgets/disc_group_sheet.dart       # NEW: confirmation sheet
lib/screens/entry_detail_screen.dart    # new full-game card + single-disc prompt
lib/screens/library_screen.dart         # "Create playlist" action on grouped items
lib/screens/settings_screen.dart        # "Ask for the full game" switch
lib/l10n/app_en.arb, app_fr.arb         # new strings
test/disc_organizer_test.dart           # NEW
test/playlist_writer_test.dart          # hidden layout cases
```

## Complexity Tracking

| Violation | Why Needed | Simpler Alternative Rejected Because |
|---|---|---|
| "Single entry in launchers" defaults to ON | The action is explicit and the sheet shows the resulting files; confirmed by the project owner (2026-11-13) | Default OFF reproduces today's cluttered frontend for most users |
