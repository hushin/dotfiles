# Dotfiles

## Overview

各dotfilesへのシンボリックリンクを $HOME の下に作ります。

## Installation

```
git clone https://github.com/hushin/dotfiles.git ~/.dotfiles
cd ~/.dotfiles
make deploy
make init
```

gitのユーザー設定は、`$HOME/.gitconfig.local` に書いて下さい。

```
# .gitconfig.local の例
[user]
  name  = hushin
  email = nnnnot+github@gmail.com
```

## Update

* `mackup backup`
* `code --list-extensions > ~/.dotfiles/etc/init/osx/vscode-extensions.txt`

## Docs

- [Chrome](./docs/chrome.md)
