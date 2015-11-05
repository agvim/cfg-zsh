# Source prezto zshrc
source ~/.zprezto/runcoms/zshrc

# Customize to your needs...

# Colors; no need to autoload zsh colors
# autoload -U colors && colors
if [ -f ~/.bash/display ]; then
    . ~/.bash/display
fi

# use variable expansion in prompt
setopt prompt_subst

# prompt using our defined colors
# <last command status> <vi_mode> <username>@<host> <cwd>
# $
PROMPT='%{$BACKHLBG$BASE3%}%(?.%{$GREENBG%} $CHECKMARK %{$GREEN%}.%{$REDBG%} $CROSS %{$RED%})${vi_mode}%(!.%{$ORANGEBG%}.%{$BASE00BG%})$LEFT_SEP%{$BASE3%} %n@%m %(!.%{$ORANGE%}.%{$BASE00%})%{$BACKHLBG%}$LEFT_SEP%{$SECONDARY%} %~ %E%{$RESET%}
%(!.%{$RED%}#.%{$ORANGE%}\$)%{$RESET%} '
vi_ins_mode="%{$YELLOWBG%}$LEFT_SEP%{$BASE3$BOLD%} INSERT %{$RESET$YELLOW%}"
vi_cmd_mode="%{$EMPHASISBG%}$LEFT_SEP%{$BASE3$BOLD%} NORMAL %{$RESET$EMPHASIS%}"
vi_no_mode=""
# vim mode is cleaned up when issuing a command
# and a redraw is forced so it is only shown in the latest prompt
zle-line-finish() {
    vi_mode=$vi_no_mode
    zle reset-prompt
}
# default is insert mode
precmd() {
    vi_mode=$vi_ins_mode
}
# update status display when switching mode
zle-keymap-select() {
    vi_mode=${${KEYMAP/vicmd/${vi_cmd_mode}}/(main|viins)/${vi_ins_mode}}
    zle reset-prompt
    zle -R
}
# fix for when ctrl+c is issued
function TRAPINT() {
    # remove mode indicator and redraw
    vi_mode=$vi_no_mode
    zle && zle reset-prompt
    # set mode to ins for new prompt
    precmd
    # return value as explained in zsh docs
    return $(( 128 + $1 ))
}
zle -N zle-keymap-select

# timeout for mode change
export KEYTIMEOUT=1

# Alias definitions directory. Source all the files there
if [ -d ~/.sourced ]; then
    for F in ~/.sourced/*; do . $F; done
fi

# ls and path completion colors
zstyle ':completion:*:default' list-colors ${(s.:.)LS_COLORS}

# history in tmp
export HISTFILE=/tmp/.zhistory$USER
