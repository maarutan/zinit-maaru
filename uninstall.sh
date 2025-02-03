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
echo -e "${CYAN}     🌟 ZSH Environment Uninstaller 🌟       ${NC}"
echo -e "${CYAN}==============================================${NC}"

# Function to confirm 3 times
confirm_three_times() {
    for i in {1..3}; do
        read -p "Are you sure you want to uninstall ZSH environment? (Attempt $i/3) [y/n]: " choice
        case "$choice" in
            y|Y ) continue ;;
            n|N ) echo -e "${RED}Aborting uninstallation.${NC}" ; exit 1 ;;
            * ) echo "Please enter y or n." ;;
        esac
    done
}

# Ask for confirmation 3 times
confirm_three_times

# 1. Removing Zinit
echo -e "\n${BLUE}[1/5] Checking for Zinit installation...${NC}"
if [ -d "$HOME/.zinit" ] || [ -d "$HOME/.local/share/zinit" ]; then
    echo -e "${YELLOW}Zinit found. Removing...${NC}"
    rm -rf "$HOME/.zinit" "$HOME/.local/share/zinit"
    echo -e "${GREEN}✔️  Zinit removed successfully.${NC}"
else
    echo -e "${RED}❌ Zinit is not installed. Skipping...${NC}"
fi

# 2. Removing .zsh directory
echo -e "\n${BLUE}[2/5] Checking for .zsh directory...${NC}"
if [ -d "$HOME/.zsh" ]; then
    echo -e "${YELLOW}.zsh directory found. Removing...${NC}"
    rm -rf "$HOME/.zsh"
    echo -e "${GREEN}✔️  .zsh directory removed successfully.${NC}"
else
    echo -e "${RED}❌ .zsh directory not found. Skipping...${NC}"
fi

# 3. Removing configuration files
echo -e "\n${BLUE}[3/5] Checking for configuration files...${NC}"
CONFIG_FILES=(".p10k.zsh" ".zshrc")
for file in "${CONFIG_FILES[@]}"; do
    if [ -f "$HOME/$file" ]; then
        echo -e "${YELLOW}Found $file. Removing...${NC}"
        rm -f "$HOME/$file"
        echo -e "${GREEN}✔️  $file removed successfully.${NC}"
    else
        echo -e "${RED}❌ $file not found. Skipping...${NC}"
    fi
done

# 4. Clearing Zsh cache
echo -e "\n${BLUE}[4/5] Checking for Zsh cache...${NC}"
if [ -d "$HOME/.cache/zsh" ]; then
    echo -e "${YELLOW}Zsh cache found. Clearing...${NC}"
    rm -rf "$HOME/.cache/zsh"
    echo -e "${GREEN}✔️  Zsh cache cleared successfully.${NC}"
else
    echo -e "${RED}❌ Zsh cache not found. Skipping...${NC}"
fi

# Clearing the screen
clear

# 5. Final message
echo -e "${CYAN}==============================================${NC}"
echo -e "${CYAN}     🎉 Uninstallation Completed! 🎉         ${NC}"
echo -e "${CYAN}==============================================${NC}"
echo -e "${GREEN}Your system is now clean and ready for a fresh setup!${NC}"
