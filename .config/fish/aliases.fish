if test (type -t balias) = 'function'
  balias t tig
  balias ta 'tig --all'
end

# zsh
alias reload='source ~/.config/fish/config.fish'

function checkout-git-branch -d "Fuzzy-find and checkout a branch"
  git branch | grep -v HEAD | string trim | fzf | read -l result; and git checkout "$result"
  commandline -f repaint
end

function checkout-recent-git-branch -d "Fuzzy-find and checkout a branch"
  git for-each-ref --format="%(refname)" --sort=-committerdate | \
  grep -v HEAD | \
  grep -v refs/tags | \
  sed -e "s|^refs/heads/||" | \
  sed -e "s|^refs/remotes/||" | \
  string trim | \
  fzf | \
  read -l result; and git checkout -t "$result"
  commandline -f repaint
end

function fssh -d "Fuzzy-find ssh host via ag and ssh into it"
  ag --ignore-case '^host [^*]' ~/.ssh/config | cut -d ' ' -f 2 | fzf | read -l result; and ssh "$result"
  commandline -f repaint
end
