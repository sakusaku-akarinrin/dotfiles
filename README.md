# 🌸 Akane Sakurai · Dotfiles

Gentle. Professional. Organized.

## What's inside

```
dotfiles/
├── niri/
│   └── config.kdl       # Niri window manager — scrollable-tiling
└── waybar/
    ├── config            # Waybar module layout
    ├── style.css         # Sakura Season theme
    └── lang.sh           # Keyboard layout indicator for Niri
```

## Theme — Sakura Season (桜の季節)

| Element | Color |
|---|---|
| Accent | `#f0a0b0` (cherry blossom pink) |
| Border | `#d4a8b8` (pale rose) |
| Urgent | `#d44a5a` (madder red — 茜) |
| Inactive | `#7b7b9e` (soft lavender) |

## Installation

```bash
git clone git@github.com:sakusaku-akarinrin/dotfiles.git
cd dotfiles

# Niri
cp niri/config.kdl ~/.config/niri/config.kdl

# Waybar
cp waybar/config ~/.config/waybar/config
cp waybar/style.css ~/.config/waybar/style.css
cp waybar/lang.sh ~/.config/waybar/lang.sh
chmod +x ~/.config/waybar/lang.sh

# Reload
niri msg action quit-and-replace  # or just restart Niri
pkill -SIGUSR2 waybar
```

## Niri keybind needed

```kdl
Mod+Space {
    spawn-sh "niri msg action switch-layout next; pkill -SIGRTMIN+1 waybar";
}
```
