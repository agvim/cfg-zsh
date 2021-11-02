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

# other symbols
CHECKMARK='✔'
CROSS='✘'

# prompt using our defined colors
# <last command status> <vi_mode> <username>@<host> <cwd>
# $
PROMPT='%{$BACKHLBG$INVERTEDPRIMARY%}%(?.%{$GREENBG%} $CHECKMARK %{$GREEN%}.%{$REDBG%} $CROSS:%? %{$RED%})${vi_mode}${MODESTATUS}%(!.%{$ORANGEBG%}.%{$INVERTEDBACKBG%})$LEFT_SEP%{$INVERTEDPRIMARY%} %n@%m %(!.%{$ORANGE%}.%{$INVERTEDBACK%})%{$BACKHLBG%}$LEFT_SEP%{$PRIMARY%} %~ $LEFT_SEP_ALT %E%{$RESET%}
%(!.%{$RED%}#.%{$ORANGE%}\$)%{$RESET%} '
vi_ins_mode="%{$YELLOWBG%}$LEFT_SEP%{$INVERTEDPRIMARY$BOLD%} INSERT %{$RESET$YELLOW%}"
vi_cmd_mode="%{$BLUEBG%}$LEFT_SEP%{$INVERTEDPRIMARY$BOLD%} NORMAL %{$RESET$BLUE%}"
vi_no_mode=""
# # vim mode is cleaned up when issuing a command
# # and a redraw is forced so it is only shown in the latest prompt
# zle-line-finish() {
#     vi_mode=$vi_no_mode
#     zle reset-prompt
# }
# default is insert mode
precmd() {
    vi_mode=$vi_ins_mode
    MODESTATUS=$(if [[ -n $SHELL_ENVIRONMENT ]]; then echo "%{$MAGENTABG%}$LEFT_SEP%{$INVERTEDPRIMARY$BOLD%} $SHELL_ENVIRONMENT %{$RESET$MAGENTA%}"; fi)
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
