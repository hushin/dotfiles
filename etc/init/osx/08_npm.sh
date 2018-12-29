#!/usr/local/bin/fish

mkdir ~/.nvm
nvm install --lts
nvm use --lts

node -v

npm install -g init-package-json-parcel
