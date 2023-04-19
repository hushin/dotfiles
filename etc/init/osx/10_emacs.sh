#!/bin/sh

set -u

brew tap d12frosted/emacs-plus
brew install emacs-plus@28 --with-spacemacs-icon
brew link emacs-plus
ln -s /opt/homebrew/Cellar/emacs-plus@28/28.2/Emacs.app /Applications

# TODO doom-emacs
[ -e ~/.emacs.d ] || git clone https://github.com/syl20bnr/spacemacs ~/.emacs.d
cd ~/.emacs.d
git fetch --prune
git checkout --force develop
git reset --hard origin/develop

emacs --insecure &
echo "running 'emacs --insecure'"
