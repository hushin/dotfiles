# Source global definitions
test -r /etc/bashrc && source /etc/bashrc

# homebrew
export PATH=/usr/local/bin:$PATH
export HOMEBREW_CASK_OPTS="--appdir=/Applications"


# golang
export GOPATH=$HOME/.go
export PATH=$PATH:$GOPATH/bin

# nodebrew
export PATH=$HOME/.nodebrew/current/bin:$PATH

# start fish
# ref: http://blog.kenichimaehashi.com/?article=12851025960
if [ -z "${BASH_EXECUTION_STRING}" ]; then
  SHELL=`which fish`
  test -x "${SHELL}" && exec "${SHELL}" -l
fi
