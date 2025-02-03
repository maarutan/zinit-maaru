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

# Check for required dependencies
MISSING_DEPENDENCIES=()
for dep in "${REQUIRED_DEPENDENCIES[@]}"; do
    if ! command -v "$dep" &> /dev/null; then
        MISSING_DEPENDENCIES+=("$dep")
    fi
done

# Report missing dependencies
if [ "${#MISSING_DEPENDENCIES[@]}" -gt 0 ]; then
    echo -e "${RED}❌ Missing dependencies: ${MISSING_DEPENDENCIES[*]}.${NC}"
    echo -e "${YELLOW}To ensure proper functionality, please install these packages with your package manager (e.g., pacman, apt, etc.).${NC}"
else
    echo -e "${GREEN}✔️  All required dependencies are installed.${NC}"
fi

# 1. Check and create necessary directories
echo -e "\n${BLUE}[1/5] Creating necessary directories...${NC}"
mkdir -p "$HOME/.config/zsh/functions" "$HOME/.config/zsh/plugins"

# 2. Copy files from repository
echo -e "\n${BLUE}[2/5] Copying files from repository...${NC}"

cp "$REPO_DIR/.zshrc" "$HOME/.zshrc"
cp "$REPO_DIR/.p10k.zsh" "$HOME/.p10k.zsh"
rsync -av --ignore-existing "$REPO_DIR/.config/zsh/" "$HOME/.config/zsh/"

# 3. Install Zinit if not installed
echo -e "\n${BLUE}[3/5] Checking for Zinit...${NC}"
if [ ! -d "$HOME/.local/share/zinit" ]; then
    echo -e "${YELLOW}Zinit is not installed. Please install it by running:${NC}"
    echo -e "${GREEN}bash -c \"\$(curl -fsSL https://git.io/zinit-install)\"${NC}"
else
    echo -e "${GREEN}✔️  Zinit is already installed.${NC}"
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


