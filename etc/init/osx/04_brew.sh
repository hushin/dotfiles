#!/bin/sh

set -eu

dir_name=$(cd $(dirname $0); pwd)

if ! command -v brew > /dev/null 2>&1; then
  # Install homebrew: https://brew.sh/
  echo "Install homebrew"
  /usr/bin/ruby -e "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install)"
fi

echo "Install homebrew apps"
cd ${dir_name}
brew bundle
cd -
echo
