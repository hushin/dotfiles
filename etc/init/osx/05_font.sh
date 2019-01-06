#!/bin/sh

set -eu

echo "install Ricty for Powerline"

if [ ! -e "~/Library/Fonts/Ricty Regular for Powerline.ttf" ]; then
  brew tap sanemat/font
  brew install ricty --with-powerline
  cp -f /usr/local/opt/ricty/share/fonts/Ricty*.ttf ~/Library/Fonts/
  fc-cache -vf
fi

