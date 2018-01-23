# path
export PATH=/usr/local/sbin:/usr/local/bin:/usr/bin:/bin:/sbin:/usr/sbin:$HOME/bin

# anyenv
export PATH=$HOME/.anyenv/bin:$PATH
if type anyenv > /dev/null 2>&1; then
  eval "$(anyenv init -)"
fi

# rbenv TODO anyenvに移行
eval "$(rbenv init -)"

# ansible
export PATH=/usr/local/opt/ansible@1.9/bin:$PATH

# homebrew cask
export HOMEBREW_CASK_OPTS="--appdir=/Applications"

# nodebrew
export PATH=$HOME/.nodebrew/current/bin:$PATH

# Add ~/bin to PATH
export PATH=~/bin:$PATH

# editor
export EDITOR='emacsclient -t -a ""'

# term color
export TERM=xterm-256color

# diff-highlight
export PATH=$PATH:/usr/local/share/git-core/contrib/diff-highlight

# golang
export GOPATH=$HOME/.go
export PATH=$PATH:$GOPATH/bin

# rails (for rails server alias)
export RAILS_SERVER_PORT=3000

# 環境ローカルの設定の読み込み
test -r $HOME/.zshenv.local && source $HOME/.zshenv.local
