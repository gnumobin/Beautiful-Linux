#!/bin/bash

####### Variables ####### 

# packages
packages=(
    fastfetch
    ttf-nerd-fonts-symbols
)
# Script Route
SCRIPT_DIR="$(cd -- "$(dirname -- "${BASH_SOURCE[0]}")" && pwd)"
# fastfetch variables
FASTFETCH_CONFIG_DIR="$HOME/.config/fastfetch"
FASTFETCH_SOURCE_DIR="$SCRIPT_DIR/fastfetch"

####### Install Pkg's ####### 
echo "Installing packages..."
sudo pacman -S --needed "${packages[@]}"
echo "All packages installed!"

####### Setup Configs ####### 

# Check if fastfetch config directory exists
if [ ! -d "$FASTFETCH_CONFIG_DIR" ]; then
    mkdir -p "$FASTFETCH_CONFIG_DIR"
    echo "Fastfetch config directory created!"
fi

# Copy configuration files
cp -r "$FASTFETCH_SOURCE_DIR/." "$FASTFETCH_CONFIG_DIR"
echo "Fastfetch configuration installed!"