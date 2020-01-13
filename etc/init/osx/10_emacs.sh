#!/bin/sh

set -u

brew tap d12frosted/emacs-plus
brew install emacs-plus
# brew linkapps emacs-plus
ln -s /usr/local/opt/emacs-plus/Emacs.app /Applications

[ -e ~/.emacs.d ] || git clone https://github.com/syl20bnr/spacemacs ~/.emacs.d
cd ~/.emacs.d
git fetch --prune
git checkout --force develop
git reset --hard origin/develop

echo "/////////////////////////////////"
echo "Please run 'emacs --insecure'"
echo "/////////////////////////////////"
echo
