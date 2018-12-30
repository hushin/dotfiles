test -r ~/.bashrc && source ~/.bashrc
# Source global definitions
test -r /etc/bashrc && source /etc/bashrc

# homebrew
export HOMEBREW_CASK_OPTS="--appdir=/Applications"

# golang
export GOPATH=$HOME/.go
export PATH=$PATH:$GOPATH/bin

# ruby
export PATH=/usr/local/opt/ruby/bin:$PATH

# nodebrew
export PATH=$HOME/.nodebrew/current/bin:$PATH

# start fish
# ref: http://blog.kenichimaehashi.com/?article=12851025960
if [ -z "${BASH_EXECUTION_STRING}" ]; then
  SHELL=`which fish`
  test -x "${SHELL}" && exec "${SHELL}" -l
fi
