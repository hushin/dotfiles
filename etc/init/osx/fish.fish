#!/usr/local/bin/fish

echo "install fisher"
curl https://git.io/fisher --create-dirs -sLo ~/.config/fish/functions/fisher.fish

# install fisher packages
fisher
