# Tasks: Localized Game Descriptions

**Input**: Design documents from `specs/001-localized-descriptions/`
**Prerequisites**: plan.md, spec.md, research.md, data-model.md, quickstart.md

**Tests**: required by constitution principle IV for pure logic (synopsis selection, cache key).

## Format: `[ID] [P?] [Story] Description`

## Phase 1: Setup

- [ ] T001 Verify toolchain: `flutter pub get`, `flutter analyze` and `flutter test` pass on the untouched branch (baseline)

## Phase 2: Foundational (Blocking Prerequisites)

- [ ] T002 Add an optional `String language = 'en'` named parameter to `GameMetadataProvider.fetch` in lib/services/metadata/metadata_provider.dart
- [ ] T003 [P] Accept and ignore `language` in `SteamGridDbProvider.fetch` in lib/services/metadata/steamgriddb_provider.dart
- [ ] T004 Add `metadataLanguageProvider` (base language code of `PlatformDispatcher.instance.locale`, lower-case, default `en`) in lib/providers/metadata_provider.dart

**Checkpoint**: code compiles, behavior unchanged.

## Phase 3: User Story 1 - Read a game description in my language (Priority: P1) 🎯 MVP

**Goal**: the detail page shows the synopsis in the device language, with English then any-language fallback.

**Independent Test**: French device, open Metal Gear Solid (PlayStation) → French description.

### Tests for User Story 1

- [ ] T005 [P] [US1] Add selection tests in test/metadata/screenscraper_provider_test.dart: requested language wins; falls back to `en`; falls back to first non-blank; blank texts skipped; default `en` keeps current behavior (adapt the existing "english over french" test)

### Implementation for User Story 1

- [ ] T006 [US1] Replace `_synopsis(jeu)` with `@visibleForTesting static String? pickSynopsis(List<Map> entries, String language)` and use `language` from `fetch` in lib/services/metadata/screenscraper_provider.dart
- [ ] T007 [US1] Add `required String language` to `GameMetadataService.getMetadata` and pass it to every `provider.fetch` call in lib/services/game_metadata_service.dart
- [ ] T008 [US1] Read `metadataLanguageProvider` in `gameMetadataProvider` and pass it to `getMetadata` in lib/providers/metadata_provider.dart

**Checkpoint**: US1 tests pass; French synopsis shown on device.

## Phase 4: User Story 2 - Language change takes effect without manual cleanup (Priority: P2)

**Goal**: cached descriptions are per language.

**Independent Test**: open a game in English, switch device to French, reopen → French.

### Tests for User Story 2

- [ ] T009 [P] [US2] Add tests in test/metadata/game_metadata_service_test.dart: same game fetched in `en` then `fr` produces two cache entries and two provider calls; same language twice hits the cache; update existing tests to pass `language`

### Implementation for User Story 2

- [ ] T010 [US2] Include the language in the cache key (`'<platform>|<title>|<language>'`) in lib/services/game_metadata_service.dart

**Checkpoint**: US2 tests pass.

## Phase 5: Polish & Cross-Cutting Concerns

- [ ] T011 Run `flutter analyze` and the full `flutter test` suite
- [ ] T012 Build the debug APK (`flutter build apk --debug`)
- [ ] T013 Run the on-device validation in specs/001-localized-descriptions/quickstart.md on the AYN Thor

## Dependencies & Execution Order

- T001 → T002 → (T003, T004 in parallel) → US1 → US2 → Polish.
- T005 can be written before T006 (tests first, expected to fail).
- US2 depends on T007 (language reaches the service).

## Implementation Strategy

Deliver US1 first (MVP: French descriptions for uncached games), then US2 (cache per language),
then validate on device. Each phase ends with a commit.
