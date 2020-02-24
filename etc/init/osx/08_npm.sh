#!/bin/sh

set -u

# nodebrew
export PATH=$HOME/.nodebrew/current/bin:$PATH

echo "install node"
mkdir -p ~/.nodebrew/src
nodebrew selfupdate
nodebrew install-binary v12.x
nodebrew use v12.x

echo "install npm packages"
npm install -g npm
npm install -g init-package-json-parcel http-server prettier
