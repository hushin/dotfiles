#!/bin/bash

set -u

echo "check .gitconfig.local"
[ -e ~/.gitconfig.local ] || cp ~/.dotfiles/.gitconfig.local.template ~/.gitconfig.local
