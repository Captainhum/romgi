# Quickstart: Clear Multi-Disc Downloads

```sh
flutter analyze && flutter test && flutter build apk --debug
adb install -r build/app/outputs/flutter-apk/app-debug.apk
```

On the AYN Thor (PSX folder on SD card):
1. Open *Metal Gear Solid (France) (Disc 1)* → "Télécharger le jeu complet (2 disques)".
2. Sheet lists Disc 1 / Disc 2 with source and size; change a source; keep "Une seule entrée"
   checked; confirm.
3. After both complete: `psx/Metal Gear Solid (France).m3u`, discs in `psx/.hidden/`.
4. iiSU shows one entry; RetroArch/DuckStation swaps discs.
5. On a single disc page, the download button offers the full game.
6. Library: on a set downloaded disc by disc, "Créer la playlist" produces the same layout.
