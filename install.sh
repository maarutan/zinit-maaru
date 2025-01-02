#!/bin/zsh

# Определение переменных
HOME_DIR="$HOME"
BACKUP_DIR="$HOME_DIR/zsh.bak"
REPO_DIR="$HOME_DIR/zinit.zsh-maaru"
REPO_URL="https://github.com/maarutan/zinit.zsh-maaru"

# Создание каталога для бэкапов, если его нет
if [ ! -d "$BACKUP_DIR" ]; then
    mkdir -p "$BACKUP_DIR"
    echo "Создан каталог для бэкапов: $BACKUP_DIR"
fi

# Клонирование репозитория
if [ -d "$REPO_DIR" ]; then
    echo "Репозиторий уже клонирован: $REPO_DIR"
else
    git clone "$REPO_URL" "$REPO_DIR"
    echo "Клонирован репозиторий: $REPO_DIR"
fi

# Перемещение файлов из репозитория в домашний каталог
for FILE in "$REPO_DIR/.zshrc" "$REPO_DIR/.p10k.zsh" "$REPO_DIR/.zsh"; do
    BASENAME=$(basename "$FILE")
    TARGET_FILE="$HOME_DIR/$BASENAME"
    if [ -e "$TARGET_FILE" ]; then
        # Если файл уже существует, переименовываем в .bak и переносим
        mv "$TARGET_FILE" "$BACKUP_DIR/${BASENAME}.bak"
        echo "Перемещен в бэкап: $TARGET_FILE -> $BACKUP_DIR/${BASENAME}.bak"
    fi
    # Копируем файл из репозитория в домашний каталог
    if [ -e "$FILE" ]; then
        cp "$FILE" "$HOME_DIR"
        echo "Файл скопирован: $FILE -> $HOME_DIR"
    fi

done

# Установка Zinit
if command -v zinit > /dev/null 2>&1; then
    echo "Zinit уже установлен. Обновляем .zshrc..."
    source "$HOME_DIR/.zshrc"
else
    echo "Zinit не найден. Устанавливаем..."
    cd "$REPO_DIR" || exit
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
    Элиф  [  -х   " $(command -v brew) "  ]; then
        brew install zsh 
     еще 
        эхо  "Пакетный менеджер не найден. Установите Zsh вручную."
        выход   1 
    фи 
    эхо  "Zsh установлен. Обновляем..."
    источник   " $HOME_DIR/.zshrc"
fi
