typeset -A abbr

function abbr() {
    abbr[$1]=$2
}

function expand-abbr() {
    local words=(${(z)LBUFFER})
    local new_buffer=""

    for word in $words; do
        if [[ -n ${abbr[$word]} ]]; then
            new_buffer+="${abbr[$word]} "
        else
            new_buffer+="$word "
        fi
    done

    LBUFFER="$new_buffer"
    zle magic-space
}

zle -N expand-abbr

function smart_enter() {
    expand-abbr
    zle .accept-line
}

zle -N smart_enter

bindkey ' ' expand-abbr
bindkey '^M' smart_enter
bindkey '^ ' magic-space
bindkey -M isearch " " magic-space

