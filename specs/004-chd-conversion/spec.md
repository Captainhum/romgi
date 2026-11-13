# Feature Specification: On-Device CHD Conversion

**Feature Branch**: `004-chd-conversion`
**Created**: 2026-11-13
**Status**: Draft
**Input**: User description: "After a disc-based game is downloaded, convert it to a single CHD file directly on the handheld, so there is one compact file per disc instead of bin/cue tracks — no PC needed. Works together with the multi-disc playlist feature."

## User Scenarios & Testing *(mandatory)*

### User Story 1 - Downloaded disc games become one CHD file (Priority: P1)

A user enables CHD conversion for PlayStation. They download a game delivered as bin/cue with
several tracks. After download (and extraction, if it was an archive), the app converts it to one
`.chd` file, verifies it, and removes the original files. The Library shows the game as
downloaded, now as a single file about half the size.

**Why this priority**: It is the core value: one file per disc, less storage, no PC step.

**Independent Test**: With conversion on for PlayStation, download WipEout (12 audio tracks):
the platform folder ends up with a single `WipEout (Europe).chd` that plays in the emulator.

**Acceptance Scenarios**:

1. **Given** conversion is on for the platform, **When** a bin/cue download completes, **Then**
   a `.chd` with the same base name replaces the bin/cue files after successful verification.
2. **Given** an ISO or GDI download, **When** it completes, **Then** it is converted the same way.
3. **Given** a format that cannot be converted (already CHD, PBP, cartridge ROM), **Then** it is
   left untouched.
4. **Given** conversion is off (default), **Then** downloads behave exactly as today.
5. **Given** the converted game, **When** launched in the emulator, **Then** it runs as the
   original did.

---

### User Story 2 - See conversion progress and keep control (Priority: P1)

While a game is converting, the Downloads screen shows a "Converting" state with progress, and
the user can cancel it. Conversion continues if the app goes to the background.

**Why this priority**: Converting takes time; without feedback users think the app is stuck or
kill it mid-way.

**Independent Test**: Start a download with conversion on, watch the "Converting… x%" state,
switch apps and come back; then cancel a second conversion and check the original files remain.

**Acceptance Scenarios**:

1. **Given** a conversion is running, **Then** the item shows a converting state with progress
   percentage.
2. **Given** the user cancels, **Then** the partial CHD is removed, the original files remain and
   the game counts as downloaded (unconverted).
3. **Given** the app is in the background, **Then** conversion continues and a notification
   reports progress and completion.
4. **Given** several downloads finish together, **Then** conversions run one at a time and the
   others show as waiting.

---

### User Story 3 - Multi-disc games end up as CHD discs behind one playlist (Priority: P2)

With conversion on and the "single entry in launchers" option of feature 002, a multi-disc game
ends up as one `.m3u` in the platform folder and one `.chd` per disc in `.hidden/`.

**Why this priority**: It completes the target layout for the project owner's setup, but depends
on feature 002.

**Independent Test**: Download Metal Gear Solid (2 discs) with both options on: the platform
folder has `Metal Gear Solid (France).m3u`; `.hidden/` has two `.chd`; the playlist references
the `.chd` files.

**Acceptance Scenarios**:

1. **Given** both options are on, **When** all discs are downloaded and converted, **Then** the
   playlist lists the CHD files in disc order.
2. **Given** one disc fails to convert, **Then** the playlist references that disc's original
   files, and the user is informed.

---

### User Story 4 - Convert games already on the device (Priority: P3)

The user can convert games already present in the Library (downloaded before the option was
enabled) individually or for a whole platform.

**Why this priority**: Valuable for existing collections like the owner's PSX folder, but new
downloads come first.

**Independent Test**: From the Library, choose "Convert to CHD" on a bin/cue game, or "Convert
all" for PlayStation, and check the results and the queue.

**Acceptance Scenarios**:

1. **Given** an unconverted disc game in the Library, **When** the user picks "Convert to CHD",
   **Then** it is queued and converted like a fresh download.
2. **Given** "Convert all" for a platform, **Then** every convertible game is queued, already
   converted ones are skipped.

---

### Edge Cases

- Not enough free space for the CHD next to the originals: conversion does not start, the user
  is told how much space is needed, originals stay.
- Cue sheet referencing missing or misnamed track files: conversion is skipped with a clear
  error; originals stay.
- Battery low or device sleeps: conversion survives screen-off; if the app is killed, the partial
  file is cleaned up at next start and the game is re-queued or left unconverted.
- Disc image inside an extracted folder with extra files (readme, artwork): only the disc image
  files are replaced; extra files are kept or removed according to the existing extraction
  behavior.
- SD card storage: same behavior as internal storage.
- Very large images (DVD-based platforms, 4+ GB): supported, with progress.
- A `.chd` with the same name already exists: no overwrite; the game is reported as already
  converted.

## Requirements *(mandatory)*

### Functional Requirements

- **FR-001**: Settings MUST offer CHD conversion, off by default, enabled globally and per
  platform (same pattern as automatic archive extraction).
- **FR-002**: The app MUST convert BIN/CUE (single and multi-track), ISO and GDI disc images to
  CHD on the device, without any external app or PC.
- **FR-003**: Output MUST be standard CHD (version 5) readable by common emulators (RetroArch
  cores, DuckStation, PCSX2, Flycast) and by desktop `chdman`.
- **FR-004**: Each produced CHD MUST be verified before any original file is removed.
- **FR-005**: Originals MUST be removed only after successful verification; on any failure or
  cancellation, originals MUST remain and partial output MUST be removed.
- **FR-006**: Free space MUST be checked before starting.
- **FR-007**: Conversion MUST show progress, be cancellable, continue in the background, and run
  one at a time.
- **FR-008**: App records (Downloads, Library) MUST point to the CHD after conversion.
- **FR-009**: Conversion MUST integrate with feature 002: CHD files are what get moved to
  `.hidden/` and referenced by the playlist.
- **FR-010**: Users MUST be able to convert existing Library games, individually or per
  platform.
- **FR-011**: All new interface text MUST be translatable.
- **FR-012**: Any third-party code used for conversion MUST have an MIT-compatible license.

### Key Entities

- **Conversion job**: source files, target CHD, status (waiting, converting, verifying, done,
  failed, cancelled), progress, error.
- **Conversion setting**: global on/off plus per-platform opt-outs.

## Success Criteria *(mandatory)*

### Measurable Outcomes

- **SC-001**: 100% of CHD files produced pass desktop `chdman verify`, and their extracted
  contents match the original tracks.
- **SC-002**: Converted games from the test set (Silent Hill, WipEout, MediEvil, Metal Gear
  Solid 2-disc) all boot and play in the emulator on the AYN Thor.
- **SC-003**: Average size reduction on the test set is at least 40%.
- **SC-004**: A ~650 MB PlayStation disc converts in under 3 minutes on the AYN Thor.
- **SC-005**: Zero original files lost across all failure tests (cancel, out of space, killed
  app, bad cue).

## Assumptions

- The encoder runs natively on the device; reusing an existing open-source Android CHD encoder
  (e.g. CHDBOY) or porting parts of MAME's CHD code is decided in the plan, subject to the
  MIT-compatibility rule.
- Target ABI is arm64-v8a first.
- Compression defaults match `chdman createcd` defaults for CD images, so results are comparable
  with desktop tools.
- Decompression/extraction from CHD back to bin/cue is out of scope.
