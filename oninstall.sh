#!/bin/zsh

# clone prezto
git clone --recursive https://github.com/sorin-ionescu/prezto.git "${ZDOTDIR:-$HOME}/.zprezto"

# simlink the zsh files and remove them so they can be replaced with the castle ones
setopt EXTENDED_GLOB
for rcfile in "${ZDOTDIR:-$HOME}"/.zprezto/runcoms/^README.md(.N); do
  ln -s "$rcfile" "${ZDOTDIR:-$HOME}/.${rcfile:t}"
  rm $rcfile
done

shell=$(cat /etc/passwd | grep -Ew "^$USER" | cut -d":" -f7)
if [[ $shell != "/bin/zsh" ]]; then
    echo "run \"chsh $USER -s /bin/zsh\" to set the login shell to zsh"
fi
