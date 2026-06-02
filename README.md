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
│   ├── alacritty/alacritty.toml
│   └── swaylock/config
│
└── violet-evergarden/      ✉️ Violet iris blue — quiet & dignified
    ├── niri/config.kdl
    ├── waybar/config, style.css, lang.sh
    ├── fuzzel/fuzzel.ini
    ├── alacritty/alacritty.toml
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

# Swaylock (screen locker)
cp $THEME/swaylock/config ~/.config/swaylock/config

# Reload
niri msg action quit-and-replace  # or just restart Niri
pkill -SIGUSR2 waybar
```

## Niri keybind needed

Add this to your Niri config so the keyboard layout indicator updates on switch:

```kdl
Mod+Space {
    spawn-sh "niri msg action switch-layout next; pkill -SIGRTMIN+1 waybar";
}
```
