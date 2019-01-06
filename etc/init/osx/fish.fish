#!/usr/local/bin/fish

if grep fish /etc/shells
  echo Found fish
else
  echo "add fish"
  echo /usr/local/bin/fish | sudo tee -a /etc/shells
end

# chsh -s /usr/local/bin/fish

echo "install fisher"
curl https://git.io/fisher --create-dirs -sLo ~/.config/fish/functions/fisher.fish

# install fisher packages
fisher

fish_update_completions
