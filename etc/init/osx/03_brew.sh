#!/bin/bash

set -u

dir_name=$(cd $(dirname $0); pwd)

# Ask for the administrator password upfront
sudo -v

# Keep-alive: update existing `sudo` time stamp until `brew.sh` has finished
while true; do sudo -n true; sleep 60; kill -0 "$$" || exit; done 2>/dev/null &

sudo softwareupdate --install-rosetta

if ! command -v brew > /dev/null 2>&1; then
  # Install homebrew: https://brew.sh/
  echo "Install homebrew"
  /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install.sh)"
fi

echo "brew update"
brew update
echo "brew doctor"
brew doctor

echo "Install homebrew apps"
cd ${dir_name}
brew bundle
echo

# TODO あとで移す
# diff-highlight
[ -h /usr/local/bin/diff-highlight ] || sudo ln -s $(brew --prefix git)/share/git-core/contrib/diff-highlight/diff-highlight /usr/local/bin/diff-highlight
