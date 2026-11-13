<!--
Sync Impact Report
- Version change: 1.0.0 → 2.0.0 (MAJOR: Principle I redefined)
- Modified principles: I. Upstream-Friendly Fork → I. Our App, Upstream-Aware;
  V. Device-Aware Native Work renumbered to VI
- Added principles: V. Open to Contributors (gen-l10n, translation platform, documented APIs)
- Modified sections: Development Workflow (branches from main, upstream merged in, ROADMAP.md)
- Templates: plan/spec/tasks templates unchanged (generic Constitution Check gate)
- Follow-up TODOs: none
-->

# Romgi Constitution

## Core Principles

### I. Our App, Upstream-Aware

This repository started as a fork of caprado/romgi and is now developed as its own app. Upstream
remains a valuable source (weekly ROM database updates, fixes), so we keep merging it.

- `upstream/main` is merged regularly; new behavior lives in new, self-contained files where
  practical so these merges stay cheap.
- Code follows the existing conventions: Riverpod providers, services under `lib/services/`,
  native code exposed through Pigeon (`pigeons/`), `flutter_lints` rules.
- The original MIT copyright notice is kept, and the README credits caprado/romgi.
- Upstream adoption is welcome but never a constraint: features are not shrunk or delayed to
  fit upstream preferences.
- Commits use Conventional Commits (`feat:`, `fix:`, `chore:`…), in English, and carry no
  AI-tool attribution.

Rationale: reusing upstream's database and download engine is worth far more than a rewrite;
owning the product lets us ship the features we want.

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

### V. Open to Contributors

- Every user-facing string goes through Flutter `gen-l10n` (ARB files under `lib/l10n/`);
  no hard-coded UI text in new or modified code. English is the template locale.
- Adding a language MUST require only a new ARB file — no code change — so it can be done from
  a web translation platform (Weblate) by non-developers.
- Features meant for other apps (intents, deep links, any future API) MUST be documented in
  `docs/` with examples, and treated as a stable contract once released.

Rationale: translations and integrations come from other people; the easier we make it for
them, the more the app improves without us.

### VI. Device-Aware Native Work

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
- One feature branch per spec, created from `main`, merged back into `main` when validated on
  device; pushed to `origin` (github.com/Captainhum/romgi).
- `upstream/main` is merged into `main` regularly to pick up database updates and fixes.
- Upstream may be offered any feature as a pull request; their decision does not block us.
- Long-term ideas live in `ROADMAP.md`.

## Governance

This constitution overrides other practices for this fork. Plans MUST pass its Constitution
Check; any violation is documented in the plan's Complexity Tracking table with the reason and
the simpler alternative that was rejected.

Amendments are made by editing this file with a version bump: MAJOR when a principle is removed
or redefined, MINOR when a principle or section is added or materially expanded, PATCH for
wording fixes. The Sync Impact Report at the top is updated on each amendment.

**Version**: 2.0.0 | **Ratified**: 2026-11-13 | **Last Amended**: 2026-11-13
