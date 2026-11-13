# Roadmap

Ideas and planned work for this fork of [caprado/romgi](https://github.com/caprado/romgi).
Items move into a Spec Kit spec (`specs/`) when work starts.

## Done

All four planned features shipped (see `specs/001`–`004`):

1. ✅ **Localized game descriptions** — fetch ScreenScraper synopses in the device language,
   falling back to English.
2. ✅ **Clear multi-disc downloads** — a confirmation sheet explaining what "download all discs"
   does, with per-disc source choice, size, destination, and a launcher-friendly layout
   (discs in `.hidden/`, one `.m3u` beside them). Prompt to grab the full set when a single disc
   is downloaded.
3. ✅ **App translation** — move all UI text to Flutter `gen-l10n`, ship French, and open the
   project on Weblate (pending the project owner's account) so anyone can add a language without touching code.
4. ✅ **CHD conversion** — convert BIN/CUE, ISO and GDI to CHD on the device after download.

## Ideas

- ~~**Integration API**~~ — done: `romgi://` links, see docs/integration.md. Next: let a
  link pre-select a source and open the confirmation directly.
- ~~**Frontend folders**~~ — done: "Frontend folder names" setting puts each console in the
  ES-DE / iiSU folder (`psx`, `snes`…) under the chosen ROMs root.
- **Frontend refresh** — iiSU (1.2.0) exposes no intent or receiver to trigger a rescan, so
  the user still refreshes its library by hand. Revisit if iiSU or ES-DE add one.
- **Own app identity** — new name and application ID so it installs next to the official romgi,
  with credit to the original project kept in the README.
