# Implementation Plan: App Translation

**Branch**: `003-app-translation` | **Date**: 2026-11-13 | **Spec**: [spec.md](spec.md)
**Input**: Feature specification from `specs/003-app-translation/spec.md`

## Summary

Adopt Flutter's official `gen-l10n` (ARB files) with English as the template and French as the
first translation. Every user-facing string in screens, widgets, `main.dart`, download status
texts, notifications and generic error messages moves to `lib/l10n/app_en.arb` with a
description for translators. Settings gains a language picker (System default / English /
Français) stored in `SettingsState`, applied to `MaterialApp.locale` and to the metadata language
from feature 001. Non-widget code (notifications, background service) resolves strings through
`lookupAppLocalizations` for the active locale. A test fails the build when hard-coded UI text
appears in screens/widgets. The README explains how to translate via Weblate.

## Technical Context

**Language/Version**: Dart ^3.10.1, Flutter 3.38.7
**Primary Dependencies**: `flutter_localizations` (SDK), `intl` (version pinned by Flutter),
existing Riverpod/shared_preferences
**Storage**: `shared_preferences` key for the language preference
**Testing**: `flutter test` — ARB completeness test, hard-coded string guard, widget smoke test
in French
**Target Platform**: Android (AYN Thor reference, dual screen)
**Project Type**: mobile app (Flutter)
**Performance Goals**: language switch applies instantly (no restart)
**Constraints**: no behavior change in English; catalog data (titles, platforms, regions) never
translated
**Scale/Scope**: ~450 strings across ~30 files; 2 locales

## Constitution Check

| Principle | Check | Status |
|---|---|---|
| I. Our App, Upstream-Aware | Touches most UI files; accepted per v2.0.0 (own app). String-only edits keep upstream merges mechanical | ✅ |
| II. Opt-In and Non-Destructive | No file operations; English unchanged; language follows device by default | ✅ |
| III. Launcher-Ready Output | N/A | ➖ |
| IV. Tested Logic, Green CI | ARB key parity test, hard-coded string guard, FR smoke test; analyze/test/build green | ✅ |
| V. Open to Contributors | This feature implements it: gen-l10n, new language = new ARB, Weblate + README | ✅ |
| VI. Device-Aware Native Work | N/A | ➖ |

## Project Structure

```text
l10n.yaml                              # gen-l10n config (arb dir, template, output in lib/l10n)
lib/l10n/
├── app_en.arb                         # template, with @descriptions
├── app_fr.arb                         # French
├── app_localizations*.dart            # generated, committed
└── l10n.dart                          # context.l10n extension + l10nFor(locale) for non-UI code
lib/main.dart                          # delegates, supportedLocales, locale from settings
lib/providers/settings_provider.dart   # appLanguage (null = system)
lib/providers/metadata_provider.dart   # metadata language follows appLanguage
lib/screens/*.dart, lib/widgets/*.dart # strings → context.l10n
lib/models/download_task.dart          # statusText(AppLocalizations)
lib/services/notification_service.dart # localized channel names / titles
lib/utils/error_utils.dart             # localized generic network errors
test/l10n/
├── arb_parity_test.dart               # every locale has the template's keys/placeholders
└── no_hardcoded_text_test.dart        # guard on lib/screens + lib/widgets
README.md                              # "Translate romgi" section
```

**Structure Decision**: generated localization code lives in `lib/l10n/` (non-synthetic
output, the current Flutter default) and is committed so CI and contributors need no extra step.

## Complexity Tracking

| Violation | Why Needed | Simpler Alternative Rejected Because |
|---|---|---|
| Edits to nearly every upstream UI file | Required to make every string translatable | Wrapping only some screens leaves the app half-English |
