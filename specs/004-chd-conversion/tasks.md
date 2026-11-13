# Tasks: On-Device CHD Conversion

- [x] T001 Spike: vendor MAME 0.289 CHD core + codecs into packages/chd_native, build hook
- [x] T002 C API `romgi_chd_create_cd` / `romgi_chd_verify` / `romgi_free_bytes`, Dart bindings on an isolate with progress + cancel
- [x] T003 Package tests incl. `chdman verify`; parity with chdman on a real game (Mac + Thor)
- [x] T004 [US1] ChdConverter (source detection, output naming, space check, verify-then-delete, serial queue) + tests
- [x] T005 [US1] Settings `chdEnabled` (off) and per-platform opt-out for CD platforms
- [x] T006 [US2] `DownloadStatus.converting`, progress, cancel button, notification, foreground service
- [x] T007 [US2] Recovery of conversions interrupted by an app kill
- [x] T008 [US3] Convert before the multi-disc playlist so `.hidden/` holds CHDs; note in the sheet
- [x] T009 [US4] Library "Convert to CHD" action
- [ ] T010 [US4] "Convert all" for a platform in the Library
- [x] T011 Strings EN/FR
- [x] T012 On-device end-to-end: download a PS1 game with conversion on, check the frontend
