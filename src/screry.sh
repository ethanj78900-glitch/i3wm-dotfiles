#!/usr/bin/env bash

set -euo pipefail

# Detect Arch Linux
if ! grep -qi arch /etc/os-release; then
  echo "This Srcery color scheme install script only works on Arch Linux."
  exit 1
fi

SRCERY_DIR="$HOME/.srcery"
I3_CONFIG="$HOME/.config/i3/config"
ALACRITTY_CONFIG="$HOME/.config/alacritty/alacritty.yml"

function install_dependencies() {
    echo "Installing necessary dependencies..."
    sudo pacman -Sy --needed --noconfirm git make gcc ncurses
}

function clone_srcery() {
    if [[ -d "$SRCERY_DIR" ]]; then
        echo "Srcery repo found, updating..."
        git -C "$SRCERY_DIR" pull
    else
        echo "Cloning Srcery..."
        git clone https://github.com/srcery-colors/srcery-colors.git "$SRCERY_DIR"
    fi
}

function install_srcery_terminal() {
    echo "Installing Srcery terminal colors..."
    cd "$SRCERY_DIR/term-colors" || exit
    ./install.sh
    cd - || exit
}

function apply_i3_colors() {
    if [[ -f "$I3_CONFIG" ]]; then
        echo "Applying Srcery colors to i3 config..."
        # Backup i3 config
        cp "$I3_CONFIG" "${I3_CONFIG}.bak.$(date +%Y%m%d%H%M%S)"
        # Replace color-related lines with Srcery scheme (simple example)
        sed -i 's/^set \$bg .*/set $bg #1c1c1c/' "$I3_CONFIG"
        sed -i 's/^set \$fg .*/set $fg #c5c8c6/' "$I3_CONFIG"
    else
        echo "i3 config not found at $I3_CONFIG, skipping i3 color config."
    fi
}

function apply_alacritty_colors() {
    if [[ -f "$ALACRITTY_CONFIG" ]]; then
        echo "Applying Srcery colors to Alacritty..."
        cp "$ALACRITTY_CONFIG" "${ALACRITTY_CONFIG}.bak.$(date +%Y%m%d%H%M%S)"
        # Append srcery colors include or merge as needed
        # This depends on your alacritty.yml structure
        # For simplicity, let's just copy the srcery alacritty.yml if exists:
        if [[ -f "$SRCERY_DIR/alacritty.yml" ]]; then
            cp "$SRCERY_DIR/alacritty.yml" "$ALACRITTY_CONFIG"
            echo "Srcery Alacritty config applied."
        else
            echo "Srcery alacritty.yml not found; skipping."
        fi
    else
        echo "Alacritty config not found at $ALACRITTY_CONFIG; skipping."
    fi
}

echo "Installing Srcery color scheme on Arch Linux..."

install_dependencies
clone_srcery
install_srcery_terminal
apply_i3_colors
apply_alacritty_colors

echo "Srcery color scheme installation complete."

exit 0
