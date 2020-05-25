#!/bin/bash

set -u

dir_name=$(cd $(dirname $0); pwd)

echo "install vscode extensions"
cd ${dir_name}
code .
