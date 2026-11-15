#!/bin/bash
set -e
trap 'echo -e "\nInstallation cancelled by user!"; exit 130' INT

####### Variables ####### 

# packages
packages=(
    fastfetch
    ttf-nerd-fonts-symbols
    git
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

echo "Installing Reversal Icon Theme..."

# Create temporary directory
REVERSAL_TMP_DIR="$(mktemp -d)"

# Cleanup temporary files on exit
trap 'rm -rf "$REVERSAL_TMP_DIR"' EXIT

# Clone repository
git clone --depth 1 "$REVERSAL_REPO" "$REVERSAL_TMP_DIR/Reversal"

# Install purple variant
bash "$REVERSAL_TMP_DIR/Reversal/install.sh" -t purple

# Apply icon theme to GNOME
gsettings set org.gnome.desktop.interface icon-theme "$REVERSAL_THEME_NAME"

echo "Reversal Purple Icon Theme installed!"