#!/bin/sh

set -eu

dir_name=$(cd $(dirname $0); pwd)

# TODO Macかどうか判定したい
files=$(echo ${dir_name}/osx/*.sh)
for t in $files
do
  bash "$t"
done

fish ${dir_name}/osx/20_fish.fish
