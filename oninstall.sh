#!/bin/zsh

# clone prezto
git clone --depth 1 --recursive -b master https://github.com/sorin-ionescu/prezto.git "${ZDOTDIR:-$HOME}/.zprezto"

# do not simlink files, the castle ones source the appropriate prezto files

# check for zsh being the login shell and show the command to change it
shell=$(cat /etc/passwd | grep -Ew "^$USER" | cut -d":" -f7)
if [[ $shell != "/bin/zsh" ]]; then
    echo "run \"chsh $USER -s /bin/zsh\" to set the login shell to zsh if desired"
fi
