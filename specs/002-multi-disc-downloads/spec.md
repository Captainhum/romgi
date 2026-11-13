# Feature Specification: Clear Multi-Disc Downloads

**Feature Branch**: `002-multi-disc-downloads`
**Created**: 2026-11-13
**Status**: Draft
**Input**: User description: "The 'Download all discs' action is confusing: it picks the source silently and doesn't say what will happen. Replace it with a clear flow that explains what it does, lets the user choose the source per disc, and produces a launcher-friendly result: discs hidden in `.hidden/` and one `.m3u` so frontends like iiSU show a single game. Also remind the user about the full set when they download a single disc of a multi-disc game."

## User Scenarios & Testing *(mandatory)*

### User Story 1 - Download a full multi-disc game with a clear confirmation (Priority: P1)

On the detail page of a multi-disc game, the user sees an obvious "Download full game (N discs)"
action with a short explanation. Tapping it opens a confirmation sheet listing every disc with
the source that will be used and its size, the total size, the destination folder, and a preview
of the files that will be created. The user can change the source of each disc, then confirms.

**Why this priority**: It fixes the core complaint: today the button downloads from an
unknown source with no explanation.

**Independent Test**: Open Metal Gear Solid (PlayStation), tap the full-game action, check that
the sheet lists Disc 1 and Disc 2 with source and size, change one source, confirm, and verify
both discs are queued from the chosen sources.

**Acceptance Scenarios**:

1. **Given** a game known to have 2 discs, **When** the user opens its detail page, **Then** a
   "Download full game (2 discs)" action is visible with an explanation of what it does.
2. **Given** the user taps it, **When** the sheet opens, **Then** each disc shows its pre-selected
   source (the one the app would have picked automatically), its size, and the total size and
   destination are displayed.
3. **Given** a disc has several available sources, **When** the user picks another one, **Then**
   the size and total update and that source is used for the download.
4. **Given** a disc has no available source, **When** the sheet opens, **Then** that disc is
   flagged as unavailable and the user is told the playlist will be incomplete; confirming still
   queues the available discs.
5. **Given** the user cancels the sheet, **Then** nothing is queued.

---

### User Story 2 - One game, one entry in my frontend (Priority: P1)

With the "single entry in launchers" option enabled in the sheet, once every disc has finished
downloading, the disc files are moved into a hidden subfolder of the platform folder and a
playlist file is created beside them, so frontends show one game instead of one entry per disc.

**Why this priority**: It is the outcome the user actually wants on their handheld; without it
the frontend shows the playlist plus every disc.

**Independent Test**: Download a 2-disc game with the option on; the platform folder then
contains only `<Game>.m3u` for that game, discs are in `.hidden/`, and the frontend lists the
game once and can switch discs in the emulator.

**Acceptance Scenarios**:

1. **Given** the option is on and all discs complete, **When** the playlist is created, **Then**
   all files of every disc (e.g. cue + bin tracks, or an extracted folder) are in
   `<platform>/.hidden/`, and `<platform>/<Game>.m3u` lists the discs in order with relative
   paths.
2. **Given** the option is off, **When** all discs complete, **Then** the current behavior applies
   (playlist beside the discs, nothing moved).
3. **Given** the files were moved, **When** the user opens the Library or Downloads screens,
   **Then** the game is still shown as downloaded and its files can still be located.
4. **Given** a move fails (e.g. storage error), **Then** no disc is lost, files already moved are
   still referenced by the playlist or moved back, and the user sees an error.

---

### User Story 3 - Reminder when downloading a single disc (Priority: P2)

When the user downloads only one disc of a multi-disc game, the app offers to download the full
game instead.

**Why this priority**: It prevents the most common mistake (downloading disc 2 only, or
downloading discs one by one and getting no playlist), but the user can still proceed with one
disc.

**Independent Test**: On "Driver 2 (Disc 2)", tap the normal download action; a prompt offers
"Download full game (2 discs)" or "Only this disc".

**Acceptance Scenarios**:

1. **Given** the entry belongs to a multi-disc set, **When** the user starts a single-disc
   download, **Then** a prompt offers the full game or this disc only.
2. **Given** the user chooses the full game, **Then** the confirmation sheet from Story 1 opens.
3. **Given** the user chooses this disc only, **Then** the download proceeds as today.
4. **Given** the user ticks "don't ask again", **Then** the prompt is no longer shown (and can be
   re-enabled in Settings).

---

### User Story 4 - Tidy up multi-disc games already downloaded (Priority: P3)

For multi-disc games whose discs were all downloaded separately, the user can trigger the same
organization (hidden folder + playlist) from the Library, without re-downloading.

**Why this priority**: Useful for existing collections, but not needed for new downloads.

**Independent Test**: With Disc 1 and Disc 2 of a game downloaded separately, use "Create
playlist" on the game in the Library and check the resulting layout.

**Acceptance Scenarios**:

1. **Given** every disc of a set is downloaded, **When** the user chooses "Create playlist" in the
   Library, **Then** the same layout as Story 2 is produced.
2. **Given** some discs are missing, **Then** the action is unavailable and the missing discs are
   named.

---

### Edge Cases

- A disc is downloaded as an archive and extracted into a folder: the whole folder moves, and the
  playlist points to the playable file inside (cue preferred).
- A bin/cue disc sits directly in the platform folder: the cue and every file it references move
  together.
- A file with the same name already exists in `.hidden/`: identical content is reused, otherwise
  the move is skipped and reported, never overwritten.
- A playlist with the same name already exists: it is replaced only if it was created by the app
  for the same group; otherwise the user is warned.
- Downloads of one group are paused, fail, or are cancelled: no playlist and no move until every
  disc is completed; retrying a failed disc later completes the process.
- The user deletes one disc of an organized game from the Library: the playlist is removed or
  marked incomplete, and the remaining discs stay where they are.
- Platform folder on an SD card: same behavior as internal storage.
- Platforms other than PlayStation that use multi-disc sets (Saturn, Sega CD, Dreamcast, PS2…):
  same behavior, since grouping comes from the catalog.

## Requirements *(mandatory)*

### Functional Requirements

- **FR-001**: The detail page of a multi-disc game MUST show a clearly labelled "download full
  game (N discs)" action with a one-sentence explanation and access to more details.
- **FR-002**: Triggering it MUST open a confirmation sheet showing, per disc: label, selected
  source, size, availability; plus total size, destination folder and a preview of the resulting
  files.
- **FR-003**: The pre-selected source for each disc MUST be the one the app picks automatically
  today; the user MUST be able to choose any other available source per disc.
- **FR-004**: The sheet MUST offer a "single entry in launchers" option; the user's last choice
  MUST be remembered for the next time.
- **FR-005**: With the option on, after all discs complete, the app MUST move every file of each
  disc into `<platform>/.hidden/` and write `<platform>/<Game>.m3u` with relative, forward-slash
  paths, LF line endings, ordered by disc number.
- **FR-006**: With the option off, the app MUST behave exactly as today.
- **FR-007**: The app MUST keep its own records (Downloads, Library) pointing to the files' new
  location after a move.
- **FR-008**: No file MUST be deleted or overwritten by the organization step; on any failure the
  app MUST leave every disc usable and report the error.
- **FR-009**: Starting a single-disc download of a multi-disc entry MUST offer the full game, with
  a "don't ask again" choice that can be reverted in Settings.
- **FR-010**: The Library MUST offer to organize a multi-disc game whose discs are all present
  but were downloaded separately.
- **FR-011**: All new user-facing text MUST be translatable (no hard-coded text), per the
  constitution.
- **FR-012**: The process MUST be idempotent: running it again on an already organized game
  changes nothing.

### Key Entities

- **Disc set**: a game made of several disc entries in the catalog, with a canonical title (no
  disc tag) and ordered members.
- **Disc selection**: per disc, the chosen source, its size and availability, as shown in the
  sheet.
- **Organized game**: the resulting layout — playlist in the platform folder, disc files in
  `.hidden/` — and the link between the playlist and the app's download records.

## Success Criteria *(mandatory)*

### Measurable Outcomes

- **SC-001**: Before confirming, the user can see for 100% of discs which source and size will be
  used.
- **SC-002**: After downloading a multi-disc game with the option on, the frontend (iiSU) shows
  exactly one entry for that game.
- **SC-003**: The emulator can switch between all discs of the game from that single entry.
- **SC-004**: A first-time user understands what the full-game action does from the sheet alone
  (validated by the project owner on device).
- **SC-005**: Zero data loss across failure cases tested (move error, name conflict,
  cancelled download).

## Assumptions

- Multi-disc sets come from the existing catalog grouping; games the catalog doesn't group are out
  of scope.
- The `.hidden/` subfolder is ignored by the targeted frontends (iiSU, ES-DE, Daijishō) and the
  emulators resolve playlist-relative paths (RetroArch, DuckStation), as verified on the AYN Thor.
- CHD conversion is out of scope (feature 004); the sheet is designed so a "Convert to CHD"
  option can be added later.
- The option's initial default (before the user ever chooses) is ON, because the action is
  explicit and the sheet explains the result; this is a deliberate exception to "off by default"
  in constitution principle II, recorded for the plan's Constitution Check.
