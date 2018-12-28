#!/bin/sh

set -eu

dir_name=$(cd $(dirname $0); pwd)

# TODO Macかどうか判定する

# Mac basic settings
sh ${dir_name}/osx/configure.sh

# Install Homebrew
sh ${dir_name}/osx/brew.sh
