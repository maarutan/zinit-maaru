#!/bin/zsh

# Определение переменных
HOME_DIR="$HOME"
BACKUP_DIR="$HOME_DIR/zsh.bak"

# Создание каталога для бэкапов, если его нет
if [ ! -d "$BACKUP_DIR" ]; then
    mkdir -p "$BACKUP_DIR"
    echo "Создан каталог для бэкапов: $BACKUP_DIR"
fi

# Перемещение необходимых файлов в домашний каталог
for FILE in "$HOME/.zshrc" "$HOME/.p10k.zsh" "$HOME/.zsh"; do
    BASENAME=$(basename "$FILE")
    TARGET_FILE="$HOME_DIR/$BASENAME"
    if [ -e "$TARGET_FILE" ]; then
        # Если файл уже существует, переименовываем в .bak и переносим
        mv "$TARGET_FILE" "$BACKUP_DIR/${BASENAME}.bak"
        echo "Перемещен в бэкап: $TARGET_FILE -> $BACKUP_DIR/${BASENAME}.bak"
    fi
    # Перемещаем файл в домашний каталог
    if [ -e "$FILE" ]; then
        mv "$FILE" "$HOME_DIR"
        echo "Файл перемещен: $FILE -> $HOME_DIR"
    fi

done

# Проверка наличия Zinit
if command -v zinit > /dev/null 2>&1; then
    echo "Zinit уже установлен. Обновляем .zshrc..."
    source "$HOME_DIR/.zshrc"
else
    echo "Zinit не найден. Устанавливаем..."
    git clone https://github.com/maarutan/zinit.zsh-maaru "$HOME_DIR/zinit.zsh-maaru"
    cd "$HOME_DIR/zinit.zsh-maaru" || exit
    ./install.sh
    cd "$HOME_DIR" || exit
    echo "Zinit установлен. Обновляем .zshrc..."
    source "$HOME_DIR/.zshrc"
fi

# Проверка и обновление Zsh
if command -v zsh > /dev/null 2>&1; then
    echo "Zsh уже установлен. Обновляем..."
    source "$HOME_DIR/.zshrc"
else
    echo "Zsh не найден. Устанавливаем..."
    if [ -x "$(command -v apt-get)" ]; then
        sudo apt-get update && sudo apt-get install zsh -y
    elif [ -x "$(command -v brew)" ]; then
        brew install zsh
    else
        echo "Пакетный менеджер не найден. Установите Zsh вручную."
        exit 1
    fi
    echo "Zsh установлен. Обновляем..."
    source "$HOME_DIR/.zshrc"
fi
