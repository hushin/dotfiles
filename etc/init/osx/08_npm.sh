#!/bin/sh

set -u

echo "install node"
nodebrew selfupdate
nodebrew install-binary v10.x
nodebrew use v10.x

echo "install npm packages"
npm install -g init-package-json-parcel http-server
