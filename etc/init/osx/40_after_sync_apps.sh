#!/bin/sh

set -u

echo "Dropbox の設定が終わったら実行してください"
read -p "Hit enter: "

mkdir -p ~/Documents/memo
[ -e ~/Dropbox/memo/_posts ] && ln -s ~/Dropbox/memo/_posts ~/Documents/memo

[ -e ~/Dropbox/ssh/ ] && ln -s ~/Dropbox/ssh/ ~/.ssh
chmod 0600 ~/.ssh/id_rsa
