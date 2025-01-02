#!/bin/bash

# Backup existing files if they exist
for file in "$HOME/.zshrc" "$HOME/.p10k.zsh" "$HOME/.zsh"; do
    if [ -e "$file" ]; then
        backup="$file.bak"
        echo "Backing up existing file $file to $backup"
        mv "$file" "$backup"
    fi
done

# Move new configuration files
mv $HOME/.zinit.zsh-maaru/.zshrc  $HOME/.zshrc
mv $HOME/.zinit.zsh-maaru/.p10k.zsh  $HOME/.p10k.zsh
mv $HOME/.zinit.zsh-maaru/.zsh/ $HOME/.zsh

sleep  2

# Check and install Zinit
if [ -d "$HOME/.zinit/bin" ]; then
    echo "Zinit is already installed on your system."
else
    echo "Zinit is not installed. Installing Zinit..."

    sh -c "$(curl -fsSL https://raw.githubusercontent.com/zdharma-continuum/zinit/main/doc/install.sh)"

    if [ $? -eq 0 ]; then
        echo "Zinit has been successfully installed."
    else
        echo "Failed to install Zinit. Please check your internet connection or permissions."
        exit 1
    fi
fi

source $HOME/.zshrc
