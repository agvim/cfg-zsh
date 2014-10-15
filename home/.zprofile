# Source prezto settings
source ~/.zprezto/runcoms/zprofile

# Overwrite some of the settings

#
# Editors
#

export EDITOR='vim'
export VISUAL='vim'
export PAGER='less'

#
# Language
#

if [[ -z "$LANG" ]]; then
  export LANG='en_US.UTF-8'
fi
