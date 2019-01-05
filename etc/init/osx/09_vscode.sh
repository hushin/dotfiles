#!/bin/bash

set -u

extensions='
alefragnani.project-manager
CoenraadS.bracket-pair-colorizer
dbaeumer.vscode-eslint
dracula-theme.theme-dracula
dsznajder.es7-react-js-snippets
eamodio.gitlens
EditorConfig.EditorConfig
esbenp.prettier-vscode
infeng.vscode-react-typescript
jebbs.plantuml
lfs.vscode-emacs-friendly
MS-CEINTL.vscode-language-pack-ja
ms-vscode.atom-keybindings
ms-vscode.vscode-typescript-tslint-plugin
octref.vetur
satokaz.vscode-bs-ctrlchar-remover
shd101wyy.markdown-preview-enhanced
skyapps.fish-vscode
spoonscen.es6-mocha-snippets
yzhang.markdown-all-in-one
'

echo "install vscode extensions"
for i in ${extensions}; do
  code --install-extension $i
done
