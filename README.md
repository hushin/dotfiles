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
  email = ngtv.hsn@gmail.com
```

## Update

* `mackup backup`

## Manual Docs

- Launch apps (set Launch at Startup)
  - Dropbox
  - Karabiner-elements
  - 1Password
  - Rectangle
  - Clipy
  - Activity Monitor
- [Chrome](./docs/chrome.md)
- Alfred Preferences
  - Powerpack -> license
  - Advanced -> Syncing (Dropbox)
- Install [Google IME](https://www.google.co.jp/ime/)
  - ¥ キーで バックスラッシュを入力
  - キー設定: ATOK から Ctrl-kで全角カタカナに変換
  - 必要に応じて辞書登録
- システム環境設定
  - キーボード
    - ショートカット Spotlight 検索をオフ
    - 入力ソース Google IME
