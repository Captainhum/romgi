<!--
Sync Impact Report
- Version change: (template) → 1.0.0
- Principles defined:
  I. Upstream-Friendly Fork
  II. Opt-In and Non-Destructive
  III. Launcher-Ready Output
  IV. Tested Logic, Green CI
  V. Device-Aware Native Work
- Added sections: Technical Constraints, Development Workflow
- Removed sections: none
- Templates:
  ✅ .specify/templates/plan-template.md (generic "Constitution Check" gate reads from this file; no edit needed)
  ✅ .specify/templates/spec-template.md (no constitution-specific sections required)
  ✅ .specify/templates/tasks-template.md (test tasks already supported; Principle IV makes them mandatory for pure logic)
- Follow-up TODOs: none
-->

# Romgi Fork Constitution

## Core Principles

### I. Upstream-Friendly Fork

This repository is a fork of caprado/romgi. Every change MUST be shaped so the upstream author
can adopt it with a single pull request.

- New behavior lives in new, self-contained files (e.g. `lib/services/chd_*.dart`); edits to
  existing upstream files are limited to the hook points needed to call the new code.
- Code MUST follow upstream conventions: Riverpod providers, services under `lib/services/`,
  native code exposed through Pigeon (`pigeons/`) like `seven_zip` and `torrent`,
  `flutter_lints` rules.
- Feature branches start from `upstream/main`; fork-only tooling (Spec Kit files) never goes
  into a feature branch meant for upstream.
- Commits use Conventional Commits (`feat:`, `fix:`, `chore:`…), in English, and carry no
  AI-tool attribution.

Rationale: a small, isolated diff is the only kind an upstream maintainer will merge, and it
keeps rebasing on upstream updates cheap.

### II. Opt-In and Non-Destructive

- Each new post-download feature (CHD conversion, multi-disc organization) MUST be behind a
  setting that is **off by default**, and configurable per platform where it makes sense.
- Source files (BIN/CUE, ISO, GDI…) MUST NOT be deleted until the produced CHD has been
  verified (CHD integrity check passes and the file is fully written).
- Any failure (unsupported format, low storage, encoder error, cancellation) MUST leave the
  original files intact, keep the download marked as completed, and surface a readable error.
- Operations MUST be idempotent: re-running on an already converted/organized game is a no-op.

Rationale: users trust a downloader with large, slow-to-redownload files; losing a game to a
failed conversion is unacceptable.

### III. Launcher-Ready Output

The goal is one visible entry per game in frontends such as iiSU, ES-DE and Daijishō.

- Single-disc games: one `<Title>.chd` in the platform folder.
- Multi-disc games: disc files in `<platform>/.hidden/`, and one `<Title>.m3u` in the platform
  folder with relative, forward-slash paths (`.hidden/<Title> (Disc N).chd`), LF line endings,
  ordered by disc number. The title drops the `(Disc N)` tag and keeps region/language tags.
- No empty folders, temporary files or leftover extraction directories remain after success.
- The existing `PlaylistWriter` is extended, not duplicated.

Rationale: this layout is the de-facto standard that RetroArch, DuckStation and the common
Android frontends all understand without extra configuration.

### IV. Tested Logic, Green CI

- Pure logic (disc grouping, title/filename derivation, `.m3u` content, target layout,
  idempotency checks) MUST have unit tests under `test/`, written alongside the code.
- `flutter analyze` and `flutter test` MUST pass, and the Android debug build MUST succeed —
  the same checks as upstream's `pr-checks.yml`.
- The CHD encoder MUST be validated against desktop `chdman`: its output passes
  `chdman verify`, and decoded data matches the source tracks.
- Every feature is tested end-to-end on a real device (AYN Thor) with at least one
  single-disc multi-track game and one multi-disc game before it is considered done.

Rationale: file-manipulation bugs are silent and destructive; automated tests plus a real-device
pass are the minimum bar.

### V. Device-Aware Native Work

- Conversion runs off the UI isolate, inside the existing background/foreground download
  service, with progress reported in the Downloads screen and cancellation supported.
- Free space MUST be checked before converting (source + estimated CHD size).
- Native code targets `arm64-v8a` first; other ABIs are added only if they build at no extra
  cost.
- Storage access reuses romgi's existing permission model (all-files access / configured
  download paths), including SD-card paths.

Rationale: handhelds have limited battery and storage, and users keep using the device while
downloads run.

## Technical Constraints

- Stack pinned to upstream: Flutter 3.38.7, Dart `^3.10.1`, JDK 17, Kotlin for Android native
  code, Pigeon for Dart↔native bridges.
- Reference device: AYN Thor (Android 13, Snapdragon 8 Gen 2), ROMs on SD card.
- Licensing: the project is MIT. Any reused or ported code (CHD encoder, compression libraries)
  MUST have an MIT-compatible license (MIT, BSD, zlib, public domain…); GPL-only code is not
  allowed. The license of each third-party component is recorded next to it.
- Supported inputs for CHD conversion, in priority order: BIN/CUE (incl. multi-track), ISO,
  GDI. Other formats are passed through untouched.

## Development Workflow

- Spec Kit flow per feature: specify → (clarify) → plan → tasks → implement.
- One feature branch per spec, created from `upstream/main`, pushed to the fork
  (`origin`, github.com/Captainhum/romgi).
- `main` on the fork tracks `upstream/main` plus fork-only tooling; upstream updates are merged
  regularly.
- When a feature is complete and validated on device, an issue is opened upstream to propose it,
  then a pull request from the feature branch if the maintainer is interested.

## Governance

This constitution overrides other practices for this fork. Plans MUST pass its Constitution
Check; any violation is documented in the plan's Complexity Tracking table with the reason and
the simpler alternative that was rejected.

Amendments are made by editing this file with a version bump: MAJOR when a principle is removed
or redefined, MINOR when a principle or section is added or materially expanded, PATCH for
wording fixes. The Sync Impact Report at the top is updated on each amendment.

**Version**: 1.0.0 | **Ratified**: 2026-11-13 | **Last Amended**: 2026-11-13
