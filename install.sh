#!/bin/bash

# Colors for output
GREEN="\033[1;92m"   # Bright green
RED="\033[1;91m"     # Bright red
YELLOW="\033[1;93m"  # Bright yellow
BLUE="\033[1;94m"    # Bright blue
CYAN="\033[1;96m"    # Bright cyan
NC="\033[0m"         # No color

# Fancy banner
echo -e "${CYAN}==============================================${NC}"
echo -e "${CYAN}     🌟 ZSH Environment Installer 🌟         ${NC}"
echo -e "${CYAN}==============================================${NC}"

# Path to repository
REPO_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"

# List of required dependencies
REQUIRED_DEPENDENCIES=("zsh" "curl" "rsync" "git" "fzf" "diffutils")

# Check if pacman is available
if ! command -v pacman &> /dev/null; then
    echo -e "${RED}❌ This system is not running Arch Linux or pacman is unavailable. Skipping dependency installation.${NC}"
else
    echo -e "${BLUE}🔍 Checking for required dependencies...${NC}"
    MISSING_DEPENDENCIES=()
    for dep in "${REQUIRED_DEPENDENCIES[@]}"; do
        if ! pacman -Qi "$dep" &> /dev/null; then
            MISSING_DEPENDENCIES+=("$dep")
        fi
    done

    if [ "${#MISSING_DEPENDENCIES[@]}" -eq 0 ]; then
        echo -e "${GREEN}✔️  All dependencies are already installed.${NC}"
    else
        echo -e "${YELLOW}⚠️  Missing dependencies: ${MISSING_DEPENDENCIES[*]}.${NC}"
        if confirm "Would you like to install the missing dependencies?"; then
            sudo pacman -Syu --needed "${MISSING_DEPENDENCIES[@]}"
        else
            echo -e "${RED}⚠️  Missing dependencies will not be installed. Installation may fail.${NC}"
        fi
    fi
fi
echo -e "${YELLOW}⚠️  Note: Powerlevel10k works best with Nerd Fonts. You can install them manually from https://www.nerdfonts.com/.${NC}"

# Function to confirm user choice
confirm() {
    while true; do
        read -p "$1 [y/n]: " choice
        case "$choice" in
            y|Y ) return 0 ;;  # Yes
            n|N ) return 1 ;;  # No
            * ) echo "Please enter y or n." ;;
        esac
    done
}

# 1. Check and create necessary directories
echo -e "\n${BLUE}[1/5] Checking and creating necessary directories...${NC}"
mkdir -p "$HOME/.config/zsh/functions" "$HOME/.config/zsh/plugins"
echo -e "${GREEN}✔️  Directories are ready.${NC}"

# 2. Copy files from repository
echo -e "\n${BLUE}[2/5] Checking and copying files from repository...${NC}"

# Check and copy .zshrc
if cmp -s "$REPO_DIR/.zshrc" "$HOME/.zshrc"; then
    echo -e "${YELLOW}.zshrc is already up-to-date.${NC}"
else
    if confirm "Overwrite existing .zshrc?"; then
        cp "$REPO_DIR/.zshrc" "$HOME/.zshrc"
        echo -e "${GREEN}✔️  .zshrc updated successfully.${NC}"
    else
        echo -e "${RED}✖️  Skipping .zshrc update.${NC}"
    fi
fi

# Check and copy .p10k.zsh
if cmp -s "$REPO_DIR/.p10k.zsh" "$HOME/.p10k.zsh"; then
    echo -e "${YELLOW}.p10k.zsh is already up-to-date.${NC}"
else
    if confirm "Overwrite existing .p10k.zsh?"; then
        cp "$REPO_DIR/.p10k.zsh" "$HOME/.p10k.zsh"
        echo -e "${GREEN}✔️  .p10k.zsh updated successfully.${NC}"
    else
        echo -e "${RED}✖️  Skipping .p10k.zsh update.${NC}"
    fi
fi

# Sync .zsh directory
if confirm "Sync .zsh directory (existing files will be skipped)?"; then
    rsync -av --ignore-existing "$REPO_DIR/.config/zsh/" "$HOME/.config/zsh/" > /dev/null
    echo -e "${GREEN}✔️  .zsh contents synced successfully.${NC}"
else
    echo -e "${RED}✖️  Skipping .zsh sync.${NC}"
fi

# 3. Check and install Zinit
echo -e "\n${BLUE}[3/5] Checking for Zinit installation...${NC}"
if [ ! -d "$HOME/.local/share/zinit" ]; then
    echo -e "${YELLOW}Zinit not found. Installing...${NC}"
    yes n | bash -c "$(curl -fsSL https://git.io/zinit-install)"
    echo -e "${GREEN}✔️  Zinit installed successfully.${NC}"
else
    echo -e "${YELLOW}Zinit is already installed.${NC}"
    if confirm "Reinstall Zinit?"; then
        rm -rf "$HOME/.local/share/zinit"
        yes n | bash -c "$(curl -fsSL https://git.io/zinit-install)"
        echo -e "${GREEN}✔️  Zinit reinstalled successfully.${NC}"
    else
        echo -e "${RED}✖️  Skipping Zinit reinstallation.${NC}"
    fi
fi

# 4. Switch to Zsh
echo -e "\n${BLUE}[4/5] Switching to Zsh...${NC}"
clear
echo -e "${CYAN}==============================================${NC}"
echo -e "${CYAN}     🎉 Installation Completed! 🎉          ${NC}"
echo -e "${CYAN}==============================================${NC}"
echo -e "${GREEN}Your Zsh environment is ready. Switching now...${NC}"
clear
exec zsh
