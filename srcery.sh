#!/usr/bin/env bash
set -euo pipefail

# Srcery palette (16-color)
# Source: srcery color scheme (https://github.com/srcery-colors)
BG="#1C1B19"
FG="#FCE8C3"
CURSOR="#FBB829"

C0="#1C1B19"  # black
C1="#EF2F27"  # red
C2="#519F50"  # green
C3="#FBB829"  # yellow
C4="#2C78BF"  # blue
C5="#E02C6D"  # magenta
C6="#0AAEB3"  # cyan
C7="#BAA67F"  # white
C8="#918175"  # bright black
C9="#F75341"  # bright red
C10="#98BC37" # bright green
C11="#FED06E" # bright yellow
C12="#68A8E4" # bright blue
C13="#FF5C8F" # bright magenta
C14="#2BE4D0" # bright cyan
C15="#FCE8C3" # bright white

usage() {
  cat <<EOF
apply-srcery.sh — Apply the Srcery terminal color scheme to common Linux terminals.

USAGE:
  ./apply-srcery.sh [targets...]

Examples:
  ./apply-srcery.sh              # apply to all supported terminals
  ./apply-srcery.sh alacritty    # only Alacritty
  ./apply-srcery.sh kitty foot   # apply to Kitty and foot

Supported targets:
  alacritty
  kitty
  wezterm
  xresources
  foot
  gnome-terminal
  all (default)

Notes:
- Existing configs are backed up with a .bak-<timestamp> suffix.
- GNOME Terminal requires gsettings/dconf and is applied to a new profile named "Srcery".
- After running, restart your terminal for changes to take effect.
EOF
}
