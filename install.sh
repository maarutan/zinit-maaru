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

# Move files with user confirmation
for file_pair in "${FILES_TO_MOVE[@]}"; do
    src="${file_pair%%:*}"  # Source
    dest="${file_pair##*:}"  # Destination

    if [ -e "$dest" ]; then
        while true; do
            echo "File $dest already exists. Do you want to save it to $SAVE_DIR? (y/n)"
            read -n 1 response
            echo
            case "$response" in
                y|Y)
                    mv "$dest" "$SAVE_DIR/$(basename $dest)"
                    echo "Saved $dest to $SAVE_DIR."
                    break
                    ;;
                n|N)
                    echo "Skipped saving $dest."
                    break
                    ;;
                *)
                    эхо  "Please enter y or n."
                    ;;
            выходной 
        сделанный 
    фи 

    если  [ -e "$src" ]; then
        mv   "  $src  "   "  $dest  " 
        эхо   "Успешно перемещено: $src -> $dest"
    else 
        echo   "Исходный файл не найден: $src. Skipping..."
    Fi 
    echo 
сделанный 

# Проверьте установку Zinit 
ZINIT_HOME="${XDG_DATA_HOME:-$HOME/.local/share}/zinit/zinit.git"
если  [ ! -f "$ZINIT_HOME/zinit.zsh" ]; then
    эхо   "Зинит не установлен. Установка Зинита..." 
    mkdir   -p   " $(dirname  $ZINIT_HOME )"
    мерзавец  clone https://github.com/zdharma-continuum/zinit.git  " $ZINIT_HOME"
    echo   «Установка Зинита завершена». 
еще 
    echo   "Зинит уже установлен." 
фи 

# Исходный файл .zshrc для динамической загрузки конфигурации 
если  [  -f  "$HOME/.zshrc" ]; then
    echo   "Использование  $HOME  /.zshrc для применения изменений..." 
    спать   2 
    источник   "  $HOME  /.zshrc" 
еще 
    echo   «Исходный файл .zshrc не найден. Проверьте работу». 
фи 

# Сообщение о завершении 
echo   «Все операции завершены». 
