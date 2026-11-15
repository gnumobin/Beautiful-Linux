#!/bin/bash

####### Variables ####### 

# packages
packages=(
    fastfetch
    ttf-nerd-fonts-symbols
)
# Script Route
SCRIPT_DIR="$(cd -- "$(dirname -- "${BASH_SOURCE[0]}")" && pwd)"
# Fastfetch variables
FASTFETCH_CONFIG_DIR="$HOME/.config/fastfetch"
FASTFETCH_SOURCE_DIR="$SCRIPT_DIR/fastfetch"
# GTK4 Themes variables
GTK4_THEME_CONFIG_DIR="$HOME/.config/gtk-4.0"
GTK4_THEME_SOURCE_DIR="$SCRIPT_DIR/gtk4-theme"

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