#!/bin/bash

# Define paths
SRC_DIR="$HOME/zinit.zsh-maaru"
SAVE_DIR="$HOME/zsh-save"
ZINIT_HOME="${XDG_DATA_HOME:-$HOME/.local/share}/zinit/zinit.git"

# Create directory for saving old configs if necessary
if [ ! -d "$SAVE_DIR" ]; then
    mkdir -p "$SAVE_DIR"
    echo "Created directory to save old configs: $SAVE_DIR"
fi

# Move specific files
move_file() {
    local src=$1
    local dest=$2
    
    if [ -e "$dest" ]; then
        echo "File $dest already exists. Do you want to save it to $SAVE_DIR? (y/n)"
        read -n 1 response
        echo # Move to a new line after input
        if [[ "$response" == "y" || "$response" == "Y" ]]; then
            mv "$dest" "$SAVE_DIR/$(basename $dest)"
            echo "Saved $dest to $SAVE_DIR."
        elif [[ "$response" == "n" || "$response" == "N" ]]; then
            echo "Skipped saving $dest."
        else
            echo "Invalid input. Skipping save for $dest."
        fi
    fi

    if [ -e "$src" ]; then
        mv "$src" "$dest"
        echo "Moved $src to $dest."
    else
        echo "Source file $src not found. Skipping..."
    fi
}

# Move files
move_file "$SRC_DIR/.zshrc" "$HOME/.zshrc"
move_file "$SRC_DIR/.p10k.zsh" "$HOME/.p10k.zsh"
move_file "$SRC_DIR/.zsh" "$HOME/.zsh"

# Check for Zinit installation
if [ ! -f "$ZINIT_HOME/zinit.zsh" ]; then
    echo "Zinit is not installed. Installing Zinit..."
    mkdir -p "$(dirname $ZINIT_HOME)"
    git clone https://github.com/zdharma-continuum/zinit.git "$ZINIT_HOME"
    echo "Zinit installation completed."
else
    echo "Zinit is already installed."
fi

# Completion message
echo "All operations completed."
