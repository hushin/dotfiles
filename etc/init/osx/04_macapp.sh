#!/bin/sh

set -u

echo "macapp"

MY_VSCODE_SETTING_DIR=~/.dotfiles/etc/osxLibrary/VSCode
VSCODE_SETTING_DIR=~/Library/Application\ Support/Code/User
if [ -d "$VSCODE_SETTING_DIR" ]; then
  echo "vscode"
  rm "$VSCODE_SETTING_DIR/settings.json"
  ln -s "$MY_VSCODE_SETTING_DIR/settings.json" "$VSCODE_SETTING_DIR/settings.json"

  rm "$VSCODE_SETTING_DIR/keybindings.json"
  ln -s "$MY_VSCODE_SETTING_DIR/keybindings.json" "$VSCODE_SETTING_DIR/keybindings.json"

  rm -rf "$VSCODE_SETTING_DIR/snippets"
  ln -s "$MY_VSCODE_SETTING_DIR/snippets" "$VSCODE_SETTING_DIR/snippets"
fi
