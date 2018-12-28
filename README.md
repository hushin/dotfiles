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
