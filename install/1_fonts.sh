#!/bin/bash

# Function to print information messages in green
function echo_info() {
    echo -e "\033[1;32m$1\033[0m"
}

# Function to print error messages in red
function echo_error() {
    echo -e "\033[1;31m$1\033[0m"
}

# Check if the fonts directory exists
FONT_DIR="$HOME/dots/fonts"
if [ ! -d "$FONT_DIR" ]; then
    echo_error "Fonts folder '$FONT_DIR' not found!"
    exit 1
fi

# Directory for system fonts
SYSTEM_FONT_DIR="$HOME/.local/share/fonts"

# Create the system font directory if it doesn't exist
if [ ! -d "$SYSTEM_FONT_DIR" ]; then
    echo_info "Creating directory for user fonts: $SYSTEM_FONT_DIR"
    mkdir -p "$SYSTEM_FONT_DIR"
fi

# Copy all fonts (ttf and otf) to the system font directory
echo_info "Copying fonts to directory: $SYSTEM_FONT_DIR"
cp "$FONT_DIR"/*.{ttf,otf} "$SYSTEM_FONT_DIR/"

# Update font cache
echo_info "Updating font cache..."
fc-cache -fv

# Notify the user that the fonts have been successfully installed
echo_info "Fonts have been successfully installed!"
