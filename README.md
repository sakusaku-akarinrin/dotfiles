# ✉️ Akane Sakurai · Dotfiles

Gentle. Professional. Organized.

Two themes for Niri + Waybar + Fuzzel + Alacritty + screen locker — switch with a single cp command.

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

# Audio (volume keys, mute, media controls)
sudo dnf install wireplumber playerctl

# Brightness (laptop backlight keys)
sudo dnf install brightnessctl
```

### Screen locker — pick one (or both)

#### swaylock-effects (blur, vignette, clock, fade-in)

Build from source — the jirutka fork uses `ext-session-lock-v1` (Niri's protocol).
The Fedora COPR packages the older mortie fork which requires `wlr-input-inhibitor` (wlroots-only).

```bash
sudo dnf install meson gcc wayland-devel pam-devel cairo-devel \
  libxkbcommon-devel gdk-pixbuf2-devel scdoc git
git clone https://github.com/jirutka/swaylock-effects
cd swaylock-effects
meson setup build
ninja -C build
sudo ninja -C build install
# PAM config installs to /usr/local by default — copy to where Linux reads it:
sudo cp /usr/local/etc/pam.d/swaylock /etc/pam.d/swaylock
```

#### gtklock (GNOME-style interactive lock screen)

```bash
sudo dnf copr enable wef/gtklock
sudo dnf install gtklock
# Same PAM fix as swaylock:
sudo cp /usr/local/etc/pam.d/gtklock /etc/pam.d/gtklock
```

Optional modules (user avatar + power buttons):
```bash
git clone https://github.com/jovanlanik/gtklock-userinfo-module
cd gtklock-userinfo-module && make && sudo make install
git clone https://github.com/jovanlanik/gtklock-powerbar-module
cd gtklock-powerbar-module && make && sudo make install
# Then uncomment the modules= line in config.ini
```

### Fonts

```bash
# Nerd Font (for waybar icons — 🌸 💌  etc.)
sudo dnf install jetbrains-mono-nf-fonts

# Adwaita Mono (for alacritty, swaylock — ships with GNOME)
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

# Screen locker — pick one (or both):
cp $THEME/swaylock/config ~/.config/swaylock/config
# mkdir -p ~/.config/gtklock
# cp $THEME/gtklock/config.ini ~/.config/gtklock/config.ini
# cp $THEME/gtklock/style.css ~/.config/gtklock/style.css

# Reload
niri msg action quit-and-replace
pkill -SIGUSR2 waybar
```

## Lock screen

Super+Alt+L triggers your chosen locker. Both are configured in the Niri keybinds —
comment/uncomment to switch:

```kdl
// Lock screen — pick one:
Super+Alt+L { spawn "swaylock"; }
// Super+Alt+L { spawn "gtklock"; }
```

### swaylock-effects

| Effect | Sakura Season | Violet Evergarden |
|---|---|---|
| Screenshot bg | ✅ | ✅ |
| Blur | `7x5` (soft) | `10x5` (deeper) |
| Vignette | `0.4:0.4` | `0.5:0.5` |
| Clock | ✅ | ✅ |
| Fade-in | `0.2s` | `0.3s` |
| Grace | 2s | 2s |

### gtklock

| Feature | Sakura Season | Violet Evergarden |
|---|---|---|
| Interactive input | ✅ | ✅ |
| Clock | ✅ (large, themed) | ✅ (large, themed) |
| Idle auto-hide | ✅ (5s) | ✅ (5s) |
| Wrong p/w feedback | ✅ (red glow) | ✅ (red glow) |
| CSS styling | ✅ | ✅ |
| User avatar module | optional | optional |
| Power bar module | optional | optional |
