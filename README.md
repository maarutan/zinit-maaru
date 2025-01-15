# zsh-maaru

## My Zsh Configuration with Zinit

[zinit (click me 🥳)](https://github.com/zdharma-continuum/zinit)  
[Install Script (click me 🥳🥳)](install)

## Zsh Plugins

```bash
# zinit install plugins
zsh-users/zsh-autosuggestions
agkozak/zsh-z
Aloxaf/fzf-tab
zsh-users/zsh-completions
djui/alias-tips
zdharma-continuum/fast-syntax-highlighting
zsh-users/zsh-history-substring-search
seebi/dircolors-solarized
paulirish/git-open
hlissner/zsh-autopair
MichaelAquilina/zsh-auto-notify
```

### Directory Structure

- `~/.zsh/` - Configuration directory
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
