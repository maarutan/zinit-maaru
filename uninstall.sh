#!/bin/bash

# Define paths
ZINIT_HOME="${XDG_DATA_HOME:-$HOME/.local/share}/zinit/zinit.git"
SAVE_DIR="$HOME/zsh-save"

# Remove specific files
remove_file() {
    local dest=$1
    
    if [ -e "$dest" ]; then
        echo "File $dest found. Do you want to save it to $SAVE_DIR before removal? (y/n)"
        read -n 1 response
        echo # Move to a new line after input
        if [[ "$response" == "y" || "$response" == "Y" ]]; then
            if [ ! -d "$SAVE_DIR" ]; then
                mkdir -p "$SAVE_DIR"
                echo "Created directory to save old configs: $SAVE_DIR"
            fi
            mv "$dest" "$SAVE_DIR/$(basename $dest)"
            echo "Saved $dest to $SAVE_DIR."
        elif [[ "$response" == "n" || "$response" == "N" ]]; then
            echo "Skipped saving $dest."
        else
            echo "Invalid input. Skipping save for $dest."
        fi
        rm -rf "$dest"
        echo "Removed $dest."
    else
        echo "File $dest not found. Skipping..."
    fi
}

# Remove files
remove_file "$HOME/.zshrc"
remove_file "$HOME/.p10k.zsh"
remove_file "$HOME/.zsh"

# Remove Zinit installation
if [ -d "$ZINIT_HOME" ]; then
    echo "Zinit found. Removing..."
    rm -rf "$ZINIT_HOME"
    echo "Zinit removed."
else
    echo "Zinit is not installed."
fi

# Completion message
echo "Uninstallation completed."
