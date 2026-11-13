# Implementation Plan: Localized Game Descriptions

**Branch**: `001-localized-descriptions` | **Date**: 2026-11-13 | **Spec**: [spec.md](spec.md)
**Input**: Feature specification from `specs/001-localized-descriptions/spec.md`

## Summary

ScreenScraper already returns synopses in every available language in one response, but
`ScreenScraperProvider._synopsis` hard-codes `'en'`. We pass a language code down from the
metadata Riverpod provider to `GameMetadataService.getMetadata` and to each
`GameMetadataProvider.fetch`, select the synopsis as *requested language → English → first
non-empty*, and add the language to the metadata cache key so cached text never leaks across
languages. The language comes from the device locale today; feature 003 will swap in the in-app
language setting through the same single provider.

## Technical Context

**Language/Version**: Dart ^3.10.1, Flutter 3.38.7
**Primary Dependencies**: flutter_riverpod 2.x, dio, sqflite (all existing; no new dependency)
**Storage**: existing `game_metadata_cache` SQLite table (key → payload, fetchedAt, noMatch)
**Testing**: `flutter test` (existing `test/metadata/*` suites with stubbed Dio)
**Target Platform**: Android (reference device AYN Thor, Android 13)
**Project Type**: mobile app (Flutter)
**Performance Goals**: no extra network request vs today (all languages arrive in one response)
**Constraints**: English-device behavior unchanged; no schema migration
**Scale/Scope**: 3 source files changed, 2 test files extended, ~1 new small provider

## Constitution Check

*GATE: Must pass before Phase 0 research. Re-check after Phase 1 design.*

| Principle | Check | Status |
|---|---|---|
| I. Our App, Upstream-Aware | Changes confined to metadata files; follows Riverpod/service conventions | ✅ |
| II. Opt-In and Non-Destructive | No file operations; English devices unchanged; metadata stays opt-in as today | ✅ |
| III. Launcher-Ready Output | Not applicable (no files produced) | ➖ |
| IV. Tested Logic, Green CI | Selection + cache-key logic unit-tested; analyze/test/build must pass; device check on Thor | ✅ |
| V. Open to Contributors | No new UI text; language source centralized for feature 003 | ✅ |
| VI. Device-Aware Native Work | No native work | ➖ |

Post-design re-check: unchanged, all gates pass.

## Project Structure

### Documentation (this feature)

```text
specs/001-localized-descriptions/
├── plan.md
├── research.md
├── data-model.md
├── quickstart.md
└── tasks.md             # created by /speckit-tasks
```

No `contracts/`: the feature exposes no interface to users or other systems beyond the existing
detail page.

### Source Code (repository root)

```text
lib/
├── providers/
│   └── metadata_provider.dart          # pass language into getMetadata; add metadataLanguageProvider
├── services/
│   ├── game_metadata_service.dart      # getMetadata(entry, language); cache key includes language
│   └── metadata/
│       ├── metadata_provider.dart      # fetch(..., language) on the abstract provider
│       ├── screenscraper_provider.dart # pickSynopsis(entries, language) with fallbacks
│       └── steamgriddb_provider.dart   # accept & ignore language
test/
└── metadata/
    ├── screenscraper_provider_test.dart   # selection cases
    └── game_metadata_service_test.dart    # per-language cache keys
```

**Structure Decision**: existing Flutter single-project layout; no new directories.

## Complexity Tracking

No constitution violations.
