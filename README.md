# zsh-maaru

## My Zsh Configuration with Zinit

[zinit (click me 🥳)](https://github.com/zdharma-continuum/zinit)  
[Install Script (click me 🥳🥳)](install)

## Zsh Plugins

```bash
# fast run load now
zinit light Aloxaf/fzf-tab
zinit light zsh-users/zsh-autosuggestions

# fast run load later
zinit wait lucid for agkozak/zsh-z
zinit wait lucid for zsh-users/zsh-completions
zinit wait lucid for djui/alias-tips
zinit wait lucid for zsh-users/zsh-history-substring-search
zinit wait lucid for seebi/dircolors-solarized
zinit wait lucid for paulirish/git-open
zinit wait lucid for MichaelAquilina/zsh-auto-notify
zinit wait lucid for joshskidmore/zsh-fzf-history-search
zinit wait lucid for zdharma-continuum/fast-syntax-highlighting
```

### Directory Structure

- `~/.config/zsh/` - Configuration directory
- `~/.zshrc` - Main configuration file

## Zsh Themes

```bash
# zinit install themes
zinit light romkatv/powerlevel10k
```

### Powerlevel10k Configuration

Make sure to run `p10k configure` after installing the theme to set up your prompt.

## Installation Steps

```bash
git clone https://github.com/maarutan/zinit.zsh-maaru
cd zinit.zsh-maaru
./install.sh
```

### Notes

1. Ensure you have `git` installed before running the script.
2. Restart your terminal or run `source ~/.zshrc` after installation.

---

If you encounter any issues, check the repository README or open an issue!
