#!/bin/bash

# Check for Zinit installation
ZINIT_HOME="${XDG_DATA_HOME:-$HOME/.local/share}/zinit/zinit.git"
if [ ! -f "$ZINIT_HOME/zinit.zsh" ]; then
    echo "Zinit is not installed. Installing Zinit..."
    mkdir -p "$(dirname $ZINIT_HOME)"
    git clone https://github.com/zdharma-continuum/zinit.git "$ZINIT_HOME"
else
    echo "Zinit is already installed."
fi

# Define paths
SRC_DIR="$HOME/zinit.zsh-maaru"
SAVE_DIR="$HOME/zsh-save"

# Files to move
FILES_TO_MOVE=(
    "$SRC_DIR/.zshrc:$HOME/.zshrc"
    "$SRC_DIR/.zsh:$HOME/.zsh"
    "$SRC_DIR/.p10k.zsh:$HOME/.p10k.zsh"
)

# Create directory for saving old configs
if [ ! -d "$SAVE_DIR" ]; then
    mkdir -p "$SAVE_DIR"
    echo "Created directory to save old configs: $SAVE_DIR"
fi

# Move files
for file_pair in "${FILES_TO_MOVE[@]}"; do
    src="${file_pair%%:*}"  # Source
    dest="${file_pair##*:}"  # Destination

    echo "Processing $src -> $dest"
    if [ -e "$dest" ]; then
        echo "File $dest already exists. Saving it to $SAVE_DIR."
        mv "$dest" "$SAVE_DIR/$(basename $dest)"
    fi

    if [ -e "$src" ]; then
        mv "$src" "$dest"
        echo "Successfully moved: $src -> $dest"
    else
        echo "File not found: $src"
    fi
    echo
done

# Completion message
source "$HOME/.zshrc"
echo "All operations completed."
