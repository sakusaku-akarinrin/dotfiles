# ✉️ Akane Sakurai · Dotfiles

Gentle. Professional. Organized.

Two themes for Niri + Waybar + Fuzzel + Alacritty + Swaylock — switch with a single cp command.

## What's inside

```
dotfiles/
├── sakura-season/          🌸 Cherry blossom pink — soft & warm
│   ├── niri/config.kdl
│   ├── waybar/config, style.css, lang.sh
│   ├── fuzzel/fuzzel.ini
│   ├── alacritty/
│   │   ├── alacritty.toml
│   │   └── themes/sakura-season.toml
│   └── swaylock/config
│
└── violet-evergarden/      ✉️ Violet iris blue — quiet & dignified
    ├── niri/config.kdl
    ├── waybar/config, style.css, lang.sh
    ├── fuzzel/fuzzel.ini
    ├── alacritty/
    │   ├── alacritty.toml
    │   └── themes/violet-evergarden.toml
    └── swaylock/config
```

## Themes

### 🌸 Sakura Season (桜の季節)

Soft, warm, and inviting. Cherry blossom pink meets lavender grey.

| Element | Color |
|---|---|
| Accent | `#f0a0b0` (cherry blossom pink) |
| Border | `#d4a8b8` (pale rose) |
| Urgent | `#d44a5a` (madder red — 茜) |
| Inactive | `#7b7b9e` (soft lavender) |

### ✉️ Violet Evergarden (ヴァイオレット・エヴァーガーデン)

Quiet, dignified, and precise. Violet iris meets golden brass.

| Element | Color |
|---|---|
| Accent | `#8888cc` (violet iris — her eyes) |
| Golden | `#d4b06a` (brass typewriter keys) |
| Urgent | `#c04858` (crimson wax seal) |
| Inactive | `#5a6088` (navy uniform blue) |
| Positive | `#5a9e7a` (emerald brooch) |

## Dependencies

### Core (required)

```bash
# Wayland compositor + tools
sudo dnf install niri waybar fuzzel alacritty

# Screen locker — swaylock-effects (blur, vignette, clock, fade-in)
sudo dnf copr enable eddsalkield/swaylock-effects
sudo dnf install swaylock-effects

# Audio (volume keys, mute, media controls)
sudo dnf install wireplumber playerctl

# Brightness (laptop backlight keys)
sudo dnf install brightnessctl
```

### Fonts

```bash
# Nerd Font (for waybar icons — 🌸 💌  etc.)
# Download from https://www.nerdfonts.com or:
sudo dnf install jetbrains-mono-nf-fonts

# Adwaita Mono (for alacritty, swaylock — ships with GNOME)
# Already installed if you had GNOME. Verify:
fc-list | grep Adwaita
```

### Optional

```bash
# Wallpaper
sudo dnf install swaybg

# Notifications
sudo dnf install mako

# Clipboard history
sudo dnf install cliphist

# GUI audio mixer (on-click from waybar)
sudo dnf install pavucontrol

# Network editor (on-click from waybar)
sudo dnf install nm-connection-editor

# Icon theme (fuzzel app icons)
sudo dnf install papirus-icon-theme
```

## Installation

```bash
git clone git@github.com:sakusaku-akarinrin/dotfiles.git
cd dotfiles

# Pick your theme (e.g. violet-evergarden)
THEME=violet-evergarden

# Niri
cp $THEME/niri/config.kdl ~/.config/niri/config.kdl

# Waybar
cp $THEME/waybar/config ~/.config/waybar/config
cp $THEME/waybar/style.css ~/.config/waybar/style.css
cp $THEME/waybar/lang.sh ~/.config/waybar/lang.sh
chmod +x ~/.config/waybar/lang.sh

# Fuzzel (app launcher)
cp $THEME/fuzzel/fuzzel.ini ~/.config/fuzzel/fuzzel.ini

# Alacritty (terminal)
cp $THEME/alacritty/alacritty.toml ~/.config/alacritty/alacritty.toml
mkdir -p ~/.config/alacritty/themes
cp $THEME/alacritty/themes/*.toml ~/.config/alacritty/themes/

# Swaylock (screen locker)
cp $THEME/swaylock/config ~/.config/swaylock/config

# Reload
niri msg action quit-and-replace  # or just restart Niri
pkill -SIGUSR2 waybar
```

## Lock screen

Super+Alt+L triggers **swaylock-effects** with these effects per theme:

| Effect | Sakura Season | Violet Evergarden |
|---|---|---|
| Screenshot bg | ✅ | ✅ |
| Blur | `7x5` (soft) | `10x5` (deeper) |
| Vignette | `0.4:0.4` | `0.5:0.5` |
| Clock | ✅ | ✅ |
| Fade-in | `0.2s` | `0.3s` |
| Grace | 2s | 2s |

The niri keybind is already in each theme's config:

```kdl
Super+Alt+L { spawn "swaylock"; }
```

Swaylock-effects is a drop-in replacement — same binary name, same config format, just with extra effect flags.
