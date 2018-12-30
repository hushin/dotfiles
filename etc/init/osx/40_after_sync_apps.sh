#!/bin/sh

set -u

echo "Dropbox の設定が終わったら実行してください"
read -p "Hit enter: "

mkdir -p ~/Documents/memo
ln -s ~/Dropbox/memo/_posts ~/Documents/memo

ln -s ~/Dropbox/ssh/ ~/.ssh
