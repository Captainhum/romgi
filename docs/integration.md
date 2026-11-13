# Opening romgi from other apps

Frontends, launchers, scripts or other apps can open romgi on a given screen with
`romgi://` links. They work from any Android app that can start an `ACTION_VIEW`
intent, from a browser link, and from `adb`.

| Link | Opens |
|---|---|
| `romgi://game/<slug>` | The page of a game. `<slug>` is the catalog id shown in the game page URL of the catalog (e.g. `metal-gear-solid-france-disc-1`). |
| `romgi://search?q=<text>` | Browse, searching for `<text>`. |
| `romgi://search?q=<text>&platform=<id>` | Same, limited to one platform (`ps1`, `saturn`, `snes`…). `q` may be empty when `platform` is set. |
| `romgi://downloads` | The Downloads tab. |
| `romgi://library` | The Library tab. |

Links never download anything by themselves: the user always confirms on the game
page. Unknown links are ignored.

## Examples

Android (Kotlin):

```kotlin
startActivity(Intent(Intent.ACTION_VIEW, Uri.parse("romgi://search?q=Chrono%20Cross&platform=ps1")))
```

adb:

```sh
adb shell am start -a android.intent.action.VIEW -d "romgi://game/metal-gear-solid-france-disc-1"
```

HTML (e.g. a web page opened on the device):

```html
<a href="romgi://search?q=Final%20Fantasy">Find it in romgi</a>
```

## Stability

These links are a public contract: existing links keep working across releases. New
link types may be added; changes are listed in the changelog.
