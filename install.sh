#!/bin/bash
set -e
trap 'echo -e "\nInstallation cancelled by user!"; exit 130' INT

####### Variables ####### 

# packages
packages=(
    # fastfetch
    # ttf-nerd-fonts-symbols
    # git
    ttf-jetbrains-mono
)
# Script Route
SCRIPT_DIR="$(cd -- "$(dirname -- "${BASH_SOURCE[0]}")" && pwd)"
# Fastfetch variables
FASTFETCH_CONFIG_DIR="$HOME/.config/fastfetch"
FASTFETCH_SOURCE_DIR="$SCRIPT_DIR/fastfetch"
# GTK4 Themes variables
GTK4_THEME_CONFIG_DIR="$HOME/.config/gtk-4.0"
GTK4_THEME_SOURCE_DIR="$SCRIPT_DIR/gtk4-theme"
# Reversal Icon Theme Variables
REVERSAL_REPO="https://github.com/yeyushengfan258/Reversal-icon-theme.git"
REVERSAL_THEME_NAME="Reversal-purple"

####### Install Pkg's ####### 
echo "Installing packages..."
sudo pacman -S --needed "${packages[@]}"
echo "All packages installed!"

####### Setup Configs: Fastfetch ####### 

# Check if fastfetch config directory exists
if [ ! -d "$FASTFETCH_CONFIG_DIR" ]; then
    mkdir -p "$FASTFETCH_CONFIG_DIR"
    echo "Fastfetch config directory created!"
fi

# Copy configuration files
cp -r "$FASTFETCH_SOURCE_DIR/." "$FASTFETCH_CONFIG_DIR"
echo "Fastfetch configuration installed!"

####### Setup Configs: GTK4 Theme ####### 
if [ ! -d "$GTK4_THEME_CONFIG_DIR" ]; then
    mkdir -p "$GTK4_THEME_CONFIG_DIR"
    echo "GTK4 Theme config directory created!"
fi

# Copy configuration files
cp -r "$GTK4_THEME_SOURCE_DIR/." "$GTK4_THEME_CONFIG_DIR"
echo "GTK4 Theme installed!"


####### Install Reversal Icon Theme #######

echo "Checking Reversal Icon Theme..."

ICON_THEME_DIR="$HOME/.local/share/icons/$REVERSAL_THEME_NAME"

if [[ -d "$ICON_THEME_DIR" ]]; then
    echo "Reversal Purple is already installed."
else
    echo "Installing Reversal Icon Theme..."

    REVERSAL_TMP_DIR="$(mktemp -d)"
    trap 'rm -rf "$REVERSAL_TMP_DIR"' EXIT

    git clone --depth 1 "$REVERSAL_REPO" "$REVERSAL_TMP_DIR/Reversal"
    bash "$REVERSAL_TMP_DIR/Reversal/install.sh" -t purple
fi

if [[ "$(gsettings get org.gnome.desktop.interface icon-theme)" != "'$REVERSAL_THEME_NAME'" ]]; then
    gsettings set org.gnome.desktop.interface icon-theme "$REVERSAL_THEME_NAME"
    echo "Reversal Purple activated!"
else
    echo "Reversal Purple is already active. Skipping..."
fi

####### Setup Terminal Font #######

if [[ "$(gsettings get org.gnome.Console custom-font)" == "'JetBrains Mono 11'" ]] && \
   [[ "$(gsettings get org.gnome.Console use-system-font)" == "false" ]]; then
    echo "Terminal font is already configured. Skipping..."
else
    gsettings set org.gnome.Console use-system-font false
    gsettings set org.gnome.Console custom-font "JetBrains Mono 11"
fi

####### Setup GNOME Accent Color #######

if [[ "$(gsettings get org.gnome.desktop.interface accent-color)" == "'purple'" ]]; then
    echo "Purple accent color is already active. Skipping..."
else
    gsettings set org.gnome.desktop.interface accent-color 'purple'
    echo "Purple accent color applied!"
fi