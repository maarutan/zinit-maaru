#!/bin/bash

# Define paths
SRC_DIR="$HOME/zinit.zsh-maaru"
SAVE_DIR="$HOME/zsh-save"

# Create directory for saving old configs if necessary
if [ ! -d "$SAVE_DIR" ]; then
    mkdir -p "$SAVE_DIR"
    echo "Created directory to save old configs: $SAVE_DIR"
fi

# Files to move
FILES_TO_MOVE=(
    "$SRC_DIR/.zshrc:$HOME/.zshrc"
    "$SRC_DIR/.p10k.zsh:$HOME/.p10k.zsh"
    "$SRC_DIR/.zsh:$HOME/.zsh"
)

# Move files dynamically
for file_pair in "${FILES_TO_MOVE[@]}"; do
    src="${file_pair%%:*}"  # Source
    dest="${file_pair##*:}"  # Destination

    if [ -e "$dest" ]; then
        echo "File $dest already exists. Do you want to save it to $SAVE_DIR? (y/n, default: y)"
        read -t 5 -n 1 response
        response=${response:-y}

        if [[ "$response" == "y" ]]; then
            mv "$dest" "$SAVE_DIR/$(basename $dest)"
            echo "Saved $dest to $SAVE_DIR."
        else
            echo "Skipped saving $dest."
        fi
    fi

    if [ -e "$src" ]; then
        mv "$src" "$dest"
        echo "Successfully moved: $src -> $dest"
    else
        echo "Source file not found: $src. Skipping..."
    fi
    echo
done

# Check for Zinit installation
ZINIT_HOME="${XDG_DATA_HOME:-$HOME/.local/share}/zinit/zinit.git"
if [ ! -f "$ZINIT_HOME/zinit.zsh" ]; then
    echo "Zinit is not installed. Installing Zinit..."
    mkdir -p "$(dirname $ZINIT_HOME)"
    git clone https://github.com/zdharma-continuum/zinit.git "$ZINIT_HOME"
    echo "Zinit installation completed."
else
    echo "Zinit is already installed."
fi

# Source .zshrc to load configuration dynamically
if [ -f "$HOME/.zshrc" ]; then
    echo "Sourcing $HOME/.zshrc to apply changes..."
    sleep 2
    source "$HOME/.zshrc"
else
    echo "No .zshrc file found to source. Please check the operation."
fi

# Completion message
echo "All operations completed."
