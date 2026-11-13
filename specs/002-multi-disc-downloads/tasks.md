# Tasks: Clear Multi-Disc Downloads

**Input**: Design documents from `specs/002-multi-disc-downloads/`

## Format: `[ID] [P?] [Story] Description`

## Phase 1: Foundational

- [ ] T001 Add `groupHidden` to DownloadTask (field, copyWith, toMap/fromMap) in lib/models/download_task.dart
- [ ] T002 DB v9 migration + `group_hidden` in create table, `updateDownloadGroup` hidden flag, `updateDownloadFilePath` in lib/services/database_service.dart
- [ ] T003 [P] Settings `discHideDefault` (true) and `discSetPrompt` (true) with setters in lib/providers/settings_provider.dart

## Phase 2: User Story 2 - One game, one entry (P1)

- [ ] T004 [P] [US2] Tests for DiscOrganizer in test/disc_organizer_test.dart: cue + tracks, extracted folder, single file, conflict aborts without moving, identical file reused, rollback, idempotent rerun
- [ ] T005 [US2] Implement DiscOrganizer in lib/services/disc_organizer.dart
- [ ] T006 [US2] PlaylistWriter: organize hidden groups before writing; update task file paths; tests in test/playlist_writer_test.dart
- [ ] T007 [US2] Wire organizer + path updates in DownloadService constructor

## Phase 3: User Story 1 - Clear confirmation (P1)

- [ ] T008 [US1] `addDiscGroup` accepts per-disc link overrides and `hidden` flag in lib/services/download_service.dart and lib/providers/download_provider.dart
- [ ] T009 [US1] DiscGroupSheet in lib/widgets/disc_group_sheet.dart (per-disc source picker, sizes, total, destination, preview, checkbox remembered)
- [ ] T010 [US1] Replace the disc card action in lib/screens/entry_detail_screen.dart with a clear "Download full game" button opening the sheet
- [ ] T011 [US1] Strings EN/FR in lib/l10n

## Phase 4: User Story 3 - Single-disc reminder (P2)

- [ ] T012 [US3] Prompt "full game / only this disc / don't ask again" before a single-disc download in lib/screens/entry_detail_screen.dart
- [ ] T013 [US3] Settings switch to re-enable the prompt in lib/screens/settings_screen.dart

## Phase 5: User Story 4 - Tidy existing sets (P3)

- [ ] T014 [US4] `organizeExistingGroup(slug)` in DownloadService (find group, map completed members, backfill, organize, playlist)
- [ ] T015 [US4] Library item menu "Create playlist" when the item belongs to a complete set in lib/screens/library_screen.dart

## Phase 6: Polish

- [ ] T016 analyze + full test suite green
- [ ] T017 Build, install on AYN Thor, run quickstart.md
