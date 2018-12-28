#!/bin/sh

set -eu

curl https://git.io/fisher --create-dirs -sLo ~/.config/fish/functions/fisher.fish

# install fisher packages
fisher
