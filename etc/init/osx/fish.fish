#!/usr/local/bin/fish


echo "add fish"
# TODO すでにある場合は追記しないようにする
echo /usr/local/bin/fish | sudo tee -a /etc/shells
# TODO デフォルトシェルにするか分岐させる？
chsh -s /usr/local/bin/fish

echo "install fisher"
curl https://git.io/fisher --create-dirs -sLo ~/.config/fish/functions/fisher.fish

# install fisher packages
fisher
