# Feature Specification: App Translation

**Feature Branch**: `003-app-translation`
**Created**: 2026-11-13
**Status**: Draft
**Input**: User description: "Translate the whole app, French first, and give people who want another language a simple way to contribute a translation without touching code."

## User Scenarios & Testing *(mandatory)*

### User Story 1 - Use the app in French (Priority: P1)

A French-speaking user opens the app on a device set to French. Every screen — Browse, Downloads,
Library, Settings, detail pages, dialogs, notifications and error messages — is in French.

**Why this priority**: It is the immediate need of the project owner and the base every other
language builds on.

**Independent Test**: Set the device to French, walk through every screen and the main flows
(search, download, pause/resume, library, settings, Internet Archive login, metadata accounts) and
find no English text except proper nouns and data coming from the catalog.

**Acceptance Scenarios**:

1. **Given** the device is in French, **When** the user opens any screen, **Then** all interface
   text is in French.
2. **Given** the device is in a language the app doesn't support, **When** the app starts,
   **Then** it is displayed in English.
3. **Given** text with numbers (e.g. "3 discs", "2 downloads queued"), **When** displayed in
   French, **Then** plural forms are correct ("1 disque", "3 disques").
4. **Given** download notifications, **When** shown, **Then** they are in the app's language.

---

### User Story 2 - Choose the app language in Settings (Priority: P2)

A user whose device is in one language can choose another language for the app in Settings, or
leave it on "System default".

**Why this priority**: Common on handhelds bought abroad or set to English; not required for the
French-device case.

**Independent Test**: With the device in English, choose "Français" in Settings: the app switches
to French immediately and stays French after a restart.

**Acceptance Scenarios**:

1. **Given** Settings, **When** the user picks a language, **Then** the app switches immediately
   without restart and keeps the choice across restarts.
2. **Given** "System default" is selected, **Then** the app follows the device language.
3. **Given** a language is chosen in the app, **Then** game descriptions (feature 001) follow
   that language too.

---

### User Story 3 - Contribute a new language without coding (Priority: P2)

Someone who wants the app in Spanish follows a link from the README to a web translation
platform, translates the texts in their browser, and the language appears in a later release
without any developer writing code.

**Why this priority**: It is how the app gets more languages over time with no work from us.

**Independent Test**: Add a new language file containing a handful of translated strings; the
language becomes selectable and untranslated strings fall back to English, with no code change.

**Acceptance Scenarios**:

1. **Given** a new language file is added, **When** the app is built, **Then** the language is
   available and selectable, with no code change.
2. **Given** a language is partially translated, **When** displayed, **Then** missing strings
   show in English, never as keys or blanks.
3. **Given** the README, **When** a contributor reads it, **Then** it explains how to translate
   via the web platform and how to request a new language.
4. **Given** a translator works on the platform, **Then** each string comes with context (where it
   appears, what placeholders mean).

---

### Edge Cases

- Longer French strings must not break layouts on small or dual screens (AYN Thor bottom screen,
  phones in portrait): text wraps or truncates gracefully.
- Text that must not be translated stays as-is: platform and console names, region codes, file
  names and extensions, URLs, catalog game titles, source names.
- Error messages coming from servers (e.g. ScreenScraper, Internet Archive) are shown as received,
  inside a translated sentence.
- Sizes, dates and numbers follow the language's conventions (e.g. "1,4 Go" in French).
- Right-to-left languages are not targeted now but must not be blocked by the approach.

## Requirements *(mandatory)*

### Functional Requirements

- **FR-001**: All user-facing interface text MUST come from translation files; no hard-coded
  interface text remains in screens, widgets, dialogs, snackbars or notifications.
- **FR-002**: The app MUST ship English (reference) and French, complete.
- **FR-003**: The app MUST follow the device language by default and fall back to English for
  unsupported languages.
- **FR-004**: Settings MUST offer a language choice (System default + every shipped language),
  applied immediately and persisted.
- **FR-005**: Plurals and placeholders MUST be supported so each language can phrase counts
  correctly.
- **FR-006**: Adding a language MUST only require adding a translation file.
- **FR-007**: Missing translations MUST fall back to English.
- **FR-008**: Every translatable string MUST have a description giving context to translators.
- **FR-009**: The project MUST be connected to a free web translation platform for open-source
  projects, and the README MUST explain how to contribute.
- **FR-010**: Sizes, numbers and dates shown to the user MUST be formatted for the active
  language.

### Key Entities

- **Translation file**: one per language, containing every interface string by key, with
  descriptions in the reference file.
- **Language preference**: "System default" or a specific language, stored in settings.

## Success Criteria *(mandatory)*

### Measurable Outcomes

- **SC-001**: 100% of interface strings are translatable; a check run in CI fails if new
  hard-coded interface text is added.
- **SC-002**: French translation is 100% complete at release.
- **SC-003**: A walkthrough of every screen in French on the AYN Thor shows no layout breakage.
- **SC-004**: A contributor can add a language without writing code, in under 10 minutes of
  setup on the translation platform.

## Assumptions

- The translation platform is Weblate (free hosting for open-source projects, supports the
  format natively); Crowdin is the fallback.
- French is translated by the project owner with assistance; no professional translation.
- Catalog data (game titles, platform names, regions) is not translated.
- Text introduced by features 001, 002 and 004 uses the same system; whichever lands first sets
  up the base.
