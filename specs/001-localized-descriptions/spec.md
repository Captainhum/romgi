# Feature Specification: Localized Game Descriptions

**Feature Branch**: `001-localized-descriptions`
**Created**: 2026-11-13
**Status**: Draft
**Input**: User description: "Show game descriptions (fetched from ScreenScraper when game metadata is enabled) in the device language — French for a French device — instead of always English, falling back to English when no translation exists."

## User Scenarios & Testing *(mandatory)*

### User Story 1 - Read a game description in my language (Priority: P1)

A French-speaking user has connected their ScreenScraper account and enabled game metadata. When
they open a game's detail page, the description is shown in French if ScreenScraper has a French
synopsis for that game.

**Why this priority**: It is the whole point of the feature: today the description is always
English even though the source has French text available.

**Independent Test**: With the device language set to French and metadata enabled, open the
detail page of a well-known game (e.g. Metal Gear Solid on PlayStation) and check that the
description is in French.

**Acceptance Scenarios**:

1. **Given** the device language is French and the game has a French synopsis, **When** the user
   opens the game's detail page, **Then** the French synopsis is displayed.
2. **Given** the device language is French and the game has no French synopsis but has an English
   one, **When** the user opens the detail page, **Then** the English synopsis is displayed.
3. **Given** the game has neither a synopsis in the device language nor in English, **When** the
   user opens the detail page, **Then** the first available synopsis is displayed (current
   behavior).
4. **Given** the device language is English, **When** the user opens any detail page, **Then** the
   behavior is identical to today.

---

### User Story 2 - Language change takes effect without manual cleanup (Priority: P2)

A user who already browsed games (descriptions cached in English) switches the device language to
French. The next time they open one of those games, the description follows the new language,
without having to clear app data.

**Why this priority**: Without it, users who already used the app would keep seeing English for
every game they had already opened, making the feature look broken.

**Independent Test**: Open a game with the device in English, switch the device to French,
reopen the same game: the description is now French.

**Acceptance Scenarios**:

1. **Given** a game's description was previously fetched in English, **When** the device
   language changes to French and the user reopens that game, **Then** the French description is
   shown.
2. **Given** the user switches back to English, **When** they reopen the game, **Then** the
   English description is shown again.

---

### Edge Cases

- Device language with a regional variant (e.g. `fr_CA`, `fr_BE`) uses the base language (`fr`).
- Device language not offered by ScreenScraper (e.g. a language with no synopses at all) falls
  back to English, then to the first available synopsis.
- Synopsis present in the device language but empty or whitespace-only is treated as missing.
- Metadata disabled or no ScreenScraper account: nothing changes, no description is shown, as
  today.
- ScreenScraper quota exceeded or network error: same error handling as today; a stale cached
  description in another language is not shown as if it were the requested language.

## Requirements *(mandatory)*

### Functional Requirements

- **FR-001**: The app MUST pick the game synopsis matching the device's language, using its base
  language code (e.g. `fr` for `fr_FR`).
- **FR-002**: When no synopsis exists in the device language, the app MUST fall back to English,
  then to the first available synopsis.
- **FR-003**: Empty or whitespace-only synopses MUST be treated as missing during selection.
- **FR-004**: Cached descriptions MUST be kept per language, so a language change never displays a
  description cached for another language.
- **FR-005**: Behavior for English-language devices MUST remain unchanged.
- **FR-006**: Screenshots and other non-text metadata MUST be unaffected.

### Key Entities

- **Synopsis**: a game description text tagged with a language code; a game can have zero or
  more, at most one per language.
- **Cached metadata**: a stored metadata result for a game, now identified by platform, title and
  language.

## Success Criteria *(mandatory)*

### Measurable Outcomes

- **SC-001**: On a French device, for games that have a French synopsis on ScreenScraper, 100% of
  detail pages show the French text.
- **SC-002**: After a device language change, the first reopening of a previously viewed game
  shows the description in the new language.
- **SC-003**: No regression for English devices: the same description is shown as before the
  change for a sample of at least 10 games.
- **SC-004**: Opening a detail page is not noticeably slower than before (no extra network request
  compared to today for an uncached game).

## Assumptions

- The language followed is the device (system) language. An in-app language setting will come
  with the app translation feature (roadmap item 3) and will then drive this choice too.
- ScreenScraper is the only metadata source providing descriptions; SteamGridDB only provides
  images and is out of scope.
- ScreenScraper returns all available synopsis languages in one response, so selecting another
  language needs no extra request.
- Game titles in the catalog stay as they are (No-Intro style names); translating titles is out
  of scope.
- Existing cached entries may be left to expire or be ignored; no migration of old cache content
  is required as long as FR-004 holds.
