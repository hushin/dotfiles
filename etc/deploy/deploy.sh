#!/bin/bash

set -u

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
