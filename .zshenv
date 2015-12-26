# path
export PATH=/bin:/usr/bin:/usr/local/bin:/sbin:/usr/sbin:/usr/local/sbin:$HOME/bin

# anyenv
export PATH=$HOME/.anyenv/bin:$PATH
if type anyenv > /dev/null 2>&1; then
  eval "$(anyenv init -)"
fi

# homebrew cask
export HOMEBREW_CASK_OPTS="--appdir=/Applications"

# nodebrew
export PATH=$HOME/.nodebrew/current/bin:$PATH

# Add ~/bin to PATH
export PATH=~/bin:$PATH

# editor
export EDITOR=atom

# term color
export TERM=xterm-256color

# golang
export GOPATH=$HOME/.go
export PATH=$PATH:$GOPATH/bin

# rails (for rails server alias)
export RAILS_SERVER_PORT=3000

# 環境ローカルの設定の読み込み
test -r $HOME/.zshenv.local && source $HOME/.zshenv.local
