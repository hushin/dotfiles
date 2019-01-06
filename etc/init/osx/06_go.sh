#!/bin/sh

set -eu

# golang
export GOPATH=$HOME/.go
export PATH=$PATH:$GOPATH/bin

echo "install mattn/memo"
go get github.com/mattn/memo
