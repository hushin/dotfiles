# Dotfiles

## Overview

* 各dotfilesへのシンボリックリンクを $HOME の下に作ります。
* 各種アプリをインストール・設定します。

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

## Manual Docs

- [Chrome](./docs/chrome.md)
- Alfred -> Alfred Preferences -> Advanced -> Syncing
- Google IME
  - ¥ キーで バックスラッシュを入力
  - キー設定: ATOK から Ctrl-kで全角カタカナに変換
  - 必要に応じて辞書登録
