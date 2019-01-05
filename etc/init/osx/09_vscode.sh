#!/bin/bash

set -u

dir_name=$(cd $(dirname $0); pwd)

echo "install vscode extensions"
cd ${dir_name}
extensions=$(cat vscode-extensions.txt)
for i in ${extensions}; do
  code --install-extension $i
done
echo
