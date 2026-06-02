# ✉️ Akane Sakurai · Dotfiles

Gentle. Professional. Organized.

Two themes for Niri + Waybar + Fuzzel + Alacritty + gtklock — switch with a single cp command.

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
│   ├── swaylock/config
│   └── gtklock/config.ini, style.css
│
└── violet-evergarden/      ✉️ Violet iris blue — quiet & dignified
    ├── niri/config.kdl
    ├── waybar/config, style.css, lang.sh
    ├── fuzzel/fuzzel.ini
    ├── alacritty/
    │   ├── alacritty.toml
    │   └── themes/violet-evergarden.toml
    ├── swaylock/config
    └── gtklock/config.ini, style.css
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

# Screen locker (pick one or both)
sudo dnf install gtklock gtklock-userinfo-module gtklock-powerbar-module
sudo dnf install swaylock

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

# Adwaita Mono (for alacritty, gtklock — ships with GNOME)
# Already installed if you had GNOME. Verify:
fc-list | grep Adwaita
```

### Optional

```bash
# Wallpaper (swaybg or hyprpaper)
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

# Swaylock (minimal screen locker)
cp $THEME/swaylock/config ~/.config/swaylock/config

# gtklock (GNOME-style interactive screen locker)
mkdir -p ~/.config/gtklock
cp $THEME/gtklock/config.ini ~/.config/gtklock/config.ini
cp $THEME/gtklock/style.css ~/.config/gtklock/style.css

# Reload
niri msg action quit-and-replace  # or just restart Niri
pkill -SIGUSR2 waybar
```

## gtklock features

- **Dynamic idle hide** — after 5 seconds, the input form fades away leaving only a large clock. Press any key or move the mouse to bring it back.
- **User avatar + name** — shows your GNOME user info via `userinfo-module`.
- **Power bar** — shutdown, reboot, and suspend buttons via `powerbar-module`.
- **Wrong password feedback** — input border and clock turn theme-red for visual confirmation.
- **Per-monitor styling** — use `window#eDP-1` / `window#HDMI-A-1` selectors for different wallpapers per output.

## Niri keybind needed

```kdl
Mod+Space {
    spawn-sh "niri msg action switch-layout next; pkill -SIGRTMIN+1 waybar";
}

# Lock screen (choose one):
Super+Alt+L { spawn "gtklock"; }      # GNOME-style interactive
# Super+Alt+L { spawn "swaylock"; }   # minimal / lightweight
```
