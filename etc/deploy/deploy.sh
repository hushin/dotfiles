#!/bin/bash

set -u

echo "check .gitconfig.local"
[ -e ~/.gitconfig.local ] || cp ~/.dotfiles/.gitconfig.local.template ~/.gitconfig.local

configDir="$HOME/.config"

if [ ! -L $configDir ]; then
  if [ -d $configDir ]; then
    mv $configDir ~/.config-bak
    echo $configDir move to ~/.config-bak
  fi
  ln -s ~/.dotfiles/.config $configDir
  echo $configDir deploy
else
  echo $configDir is already deployed
fi
