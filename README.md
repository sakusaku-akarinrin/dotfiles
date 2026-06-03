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
│   ├── gtklock/config.ini, style.css
│   └── swaylock/config
│
└── violet-evergarden/      ✉️ Violet iris blue — quiet & dignified
    ├── niri/config.kdl
    ├── waybar/config, style.css, lang.sh
    ├── fuzzel/fuzzel.ini
    ├── alacritty/
    │   ├── alacritty.toml
    │   └── themes/violet-evergarden.toml
    ├── gtklock/config.ini, style.css
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

# Audio (volume keys, mute, media controls)
sudo dnf install wireplumber playerctl

# Brightness (laptop backlight keys)
sudo dnf install brightnessctl
```

### Screen locker — gtklock (GNOME-style interactive)

```bash
sudo dnf copr enable wef/gtklock
sudo dnf install gtklock
# PAM config may install to /usr/local — copy to where Linux reads it:
sudo cp /usr/local/etc/pam.d/gtklock /etc/pam.d/gtklock
```

Optional modules (user avatar + power buttons):

```bash
# Build dependencies
sudo dnf install meson gcc gtk3-devel accountsservice-devel git

# User info module (avatar + username)
git clone https://github.com/jovanlanik/gtklock-userinfo-module
cd gtklock-userinfo-module
meson setup build
ninja -C build
sudo ninja -C build install
cd ..

# Power bar module (shutdown, reboot, suspend)
git clone https://github.com/jovanlanik/gtklock-powerbar-module
cd gtklock-powerbar-module
meson setup build
ninja -C build
sudo ninja -C build install

### Alternative: swaylock-effects (blur, vignette, clock)

Build from source — the jirutka fork uses `ext-session-lock-v1` (Niri's protocol).

```bash
sudo dnf install meson gcc wayland-devel pam-devel cairo-devel \
  libxkbcommon-devel gdk-pixbuf2-devel scdoc git
git clone https://github.com/jirutka/swaylock-effects
cd swaylock-effects
meson setup build
ninja -C build
sudo ninja -C build install
sudo cp /usr/local/etc/pam.d/swaylock /etc/pam.d/swaylock
```

### Fonts

These dotfiles use **Adwaita Mono Nerd Font** — your familiar Adwaita Mono with full icon glyphs
for Starship, waybar, fuzzel, and everything that needs Nerd Font symbols.

```bash
# 1. Download the Nerd Font patched version
curl -L -o /tmp/AdwaitaMono.tar.xz \
  https://github.com/ryanoasis/nerd-fonts/releases/latest/download/AdwaitaMono.tar.xz

# 2. Install to your local font directory
mkdir -p ~/.local/share/fonts
tar -xf /tmp/AdwaitaMono.tar.xz -C ~/.local/share/fonts/

# 3. Refresh font cache
fc-cache -fv

# 4. Verify it's available
fc-list | grep -i "AdwaitaMono.*Nerd"
# Expected: AdwaitaMono Nerd Font:style=Regular
```

> **Font family name in config:** `"AdwaitaMono Nerd Font"`

### Optional

```bash
# Wallpaper (animated transitions)
sudo dnf install swww

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

# gtklock (screen locker)
mkdir -p ~/.config/gtklock
cp $THEME/gtklock/config.ini ~/.config/gtklock/config.ini
cp $THEME/gtklock/style.css ~/.config/gtklock/style.css

# Or swaylock instead:
# cp $THEME/swaylock/config ~/.config/swaylock/config

# Wallpaper — place your image here:
mkdir -p ~/.config/wallpaper
# cp ~/Pictures/Wallpapers/sakura.jpg ~/.config/wallpaper/wallpaper.png

# Reload
niri msg action quit-and-replace
pkill -SIGUSR2 waybar
```

## Lock screen

Super+Alt+L triggers your chosen locker. Both are configured in the Niri keybinds —
swap the comment to switch:

```kdl
// Lock screen — pick one:
Super+Alt+L { spawn "gtklock"; }
// Super+Alt+L { spawn "swaylock"; }
```

### gtklock (default)

GNOME-style interactive lock screen with full CSS theming.

| Feature | Sakura Season | Violet Evergarden |
|---|---|---|
| Large clock | ✅ (72px, pink glow) | ✅ (72px, violet glow) |
| Date display | ✅ (`%A, %B %d`) | ✅ (`%A, %B %d`) |
| Idle auto-hide | ✅ (5s, clock scales to 96px) | ✅ (5s, clock turns golden) |
| Wrong p/w feedback | ✅ (red flash, clock turns red) | ✅ (crimson flash, clock turns red) |
| Unlock button | ✅ (themed hover) | ✅ (golden hover) |
| User avatar module | ✅ | ✅ |
| Power bar module | ✅ | ✅ |

### swaylock-effects (alternative)

| Effect | Sakura Season | Violet Evergarden |
|---|---|---|
| Screenshot bg | ✅ | ✅ |
| Blur | `7x5` (soft) | `10x5` (deeper) |
| Vignette | `0.4:0.4` | `0.5:0.5` |
| Clock | ✅ | ✅ |
| Fade-in | `0.2s` | `0.3s` |
| Grace | 2s | 2s |
