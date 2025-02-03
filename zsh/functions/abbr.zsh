typeset -A abbr

function abbr() {
    abbr[$1]=$2
}

function expand-abbr() {
    local lastword="${(L)${LBUFFER##* }}"
    if [[ -n ${abbr[$lastword]} ]]; then
        LBUFFER="${LBUFFER%$lastword}${abbr[$lastword]} "
    fi
    zle magic-space
}

zle -N expand-abbr

function smart_enter() {
    expand-abbr
    zle .accept-line
}

zle -N smart_enter

bindkey ' ' expand-abbr # with space
bindkey '^M' smart_enter # with enter
bindkey '^ ' magic-space # with ctrl-space
bindkey -M isearch " " magic-space # with space in search

