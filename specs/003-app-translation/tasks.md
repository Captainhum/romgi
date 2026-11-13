# Tasks: App Translation

**Input**: Design documents from `specs/003-app-translation/`
**Prerequisites**: plan.md, spec.md, research.md, data-model.md, quickstart.md

**Tests**: required (constitution IV/V): ARB parity, hard-coded text guard.

## Format: `[ID] [P?] [Story] Description`

## Phase 1: Setup

- [x] T001 Add `flutter_localizations` (sdk) and `intl` to pubspec.yaml, set `flutter: generate: true`
- [x] T002 Create l10n.yaml (arb-dir lib/l10n, template app_en.arb, output-dir lib/l10n, nullable-getter false)
- [x] T003 Create lib/l10n/app_en.arb and lib/l10n/app_fr.arb with navigation strings, run `flutter gen-l10n`
- [x] T004 Create lib/l10n/l10n.dart: `BuildContext.l10n` extension and `l10nFor(Locale)` helper

## Phase 2: Foundational

- [x] T005 Wire `localizationsDelegates`, `supportedLocales` and `locale` in lib/main.dart
- [x] T006 [P] Add ARB parity test in test/l10n/arb_parity_test.dart
- [x] T007 [P] Add hard-coded UI text guard in test/l10n/no_hardcoded_text_test.dart (starts with an allowlist of not-yet-migrated files, emptied by the end of Phase 3)

## Phase 3: User Story 1 - Use the app in French (Priority: P1) 🎯 MVP

- [x] T008 [US1] Migrate lib/main.dart (navigation, permission dialog, update snackbar)
- [x] T009 [P] [US1] Migrate lib/screens/browse_screen.dart and lib/widgets/filter_bottom_sheet.dart
- [x] T010 [P] [US1] Migrate lib/screens/entry_detail_screen.dart
- [x] T011 [P] [US1] Migrate lib/screens/downloads_screen.dart and `DownloadTask.statusText` in lib/models/download_task.dart
- [x] T012 [P] [US1] Migrate lib/screens/library_screen.dart
- [x] T013 [P] [US1] Migrate lib/screens/settings_screen.dart
- [x] T014 [P] [US1] Migrate lib/screens/sources_screen.dart, database_setup_screen.dart, internet_archive_login_screen.dart
- [x] T015 [P] [US1] Migrate remaining widgets in lib/widgets/ (error_view, rom_list_tile, …)
- [x] T016 [US1] Localize generic network errors in lib/utils/error_utils.dart
- [x] T017 [US1] Localize notification channels and titles in lib/services/notification_service.dart and the foreground service title in lib/services/download_service.dart
- [x] T018 [US1] Complete app_fr.arb for every key; plurals for counts
- [x] T019 [US1] Empty the guard allowlist; analyze + tests green

## Phase 4: User Story 2 - Choose the app language in Settings (Priority: P2)

- [x] T020 [US2] Add `appLanguage` to SettingsState + persistence in lib/providers/settings_provider.dart
- [x] T021 [US2] Add Language tile (System default / English / Français) in lib/screens/settings_screen.dart
- [x] T022 [US2] Feed the chosen locale to `MaterialApp.locale` and to non-UI code (notifications)
- [x] T023 [US2] When feature 001 is merged: make `metadataLanguageProvider` follow `appLanguage`

## Phase 5: User Story 3 - Contribute a new language without coding (Priority: P2)

- [x] T024 [US3] README "Translate romgi" section (Weblate link placeholder + manual ARB steps)
- [x] T025 [US3] Verify a partial ARB falls back to English (parity test covers missing keys)

## Phase 6: Polish

- [x] T026 Build debug APK and install on the AYN Thor
- [x] T027 Run the on-device walkthrough in quickstart.md (French layout check on both screens)
