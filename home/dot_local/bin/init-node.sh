#!/bin/bash

git init
# https://github.com/simonwhitaker/gibo
gibo dump Node >> .gitignore
# create dir
mkdir src
npm init -y

npx mklicense
# create README
CURRENT_DIR=$(echo ${PWD##*/})
cat <<EOF > README.md
# $CURRENT_DIR

(Overview)

## Description

***DEMO:***

## Features

- aaa

## Installation

\`\`\`

\`\`\`

## Usage

\`\`\`

\`\`\`

## Anything Else

## Develop

\`\`\`
npm ci
npm run dev
npm test
\`\`\`
EOF

# git
git add .
