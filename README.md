# Xbox 360 Blades Sounds

A [Millennium](https://docs.steambrew.app/) plugin that installs Xbox 360 sound effects for the [Xbox 360 Blades theme](https://github.com/Blade04208/xbox360-blades).

## Build

Requires Node.js 22+ and Millennium 3.4.0+.

```sh
npm ci
npm run build
```

## Installation

1. Fully exit Steam.
2. Copy `dist/x360-blades-sounds.star` into Millennium's plugin directory: `$XDG_DATA_HOME/millennium/plugins/` (normally `~/.local/share/millennium/plugins/`) on Linux, or `<Steam>/millennium/plugins/` on Windows.
3. Start Steam, enable **Xbox 360 Blades Sounds** in Millennium, and restart Steam so its backend installs the sounds.

The plugin copies its bundled WAV files into `<Steam>/steamui/sounds/`.

## Credits

Original sound plugin by **tameranian**.
