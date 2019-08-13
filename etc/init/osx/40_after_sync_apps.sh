#!/bin/sh

set -u

echo "Dropbox の設定が終わったら実行してください"
read -p "Hit enter: "

mkdir -p ~/Documents/memo
[ -e ~/Dropbox/memo/_posts ] && [ ! -L ~/Documents/memo ] && ln -s ~/Dropbox/memo/_posts ~/Documents/memo

[ -e ~/Dropbox/env/ssh/ ] && [ ! -L ~/.ssh ] && ln -s ~/Dropbox/env/ssh/ ~/.ssh
chmod 0600 ~/.ssh/id_rsa
