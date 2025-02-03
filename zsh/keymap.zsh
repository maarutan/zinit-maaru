# ██╗  ██╗███████╗██╗   ██╗███╗   ███╗ █████╗ ██████╗
# ██║ ██╔╝██╔════╝╚██╗ ██╔╝████╗ ████║██╔══██╗██╔══██╗
# █████╔╝ █████╗   ╚████╔╝ ██╔████╔██║███████║██████╔╝
# ██╔═██╗ ██╔══╝    ╚██╔╝  ██║╚██╔╝██║██╔══██║██╔═══╝
# ██║  ██╗███████╗   ██║   ██║ ╚═╝ ██║██║  ██║██║
# ╚═╝  ╚═╝╚══════╝   ╚═╝   ╚═╝     ╚═╝╚═╝  ╚═╝╚═╝
#
bindkey "^H" backward-delete-char
bindkey "^W" backward-kill-word
bindkey "^?" backward-delete-char


# bindkey -M vicmd '^[k' history-substring-search-up
# bindkey -M vicmd '^[j' history-substring-search-down

bindkey '^N' history-beginning-search-forward
bindkey '^P' history-beginning-search-backward

# complete
bindkey "^I" fzf-tab-complete
bindkey "^[[105;5u"  autosuggest-accept


#fzf history
bindkey '^H' fzf_history_search
