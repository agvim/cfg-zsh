# Source prezto zshrc
source "$ZDOTDIR/.zprezto/runcoms/zshrc"

# Alias definitions directory. Source all the files there
if [ -d ~/.config/shell_sourced ]; then
    for F in ~/.config/shell_sourced/*; do . $F; done
fi

# ls and path completion colors
zstyle ':completion:*:default' list-colors ${(s.:.)LS_COLORS}

# history in tmp
export HISTFILE=/tmp/.zhistory_$USER
