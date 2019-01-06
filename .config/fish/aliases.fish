if test (type -t balias) = 'function'
  balias t tig
  balias ta 'tig --all'
  balias g 'git'
  balias gsh 'git show'
  balias gdc 'git diff --cached'
  balias agh 'ag --hidden'
end

if ! command -v tac > /dev/null
  alias tac='tail -r'
end

alias reload='source ~/.config/fish/config.fish'
alias diff='diff -u'
alias cdu='cd-gitroot'

alias e='emacsclient -t -a ""'
alias ekill='emacsclient -e "(kill-emacs)"'

function git-review
  set -l N (git log --pretty=format:"%H %h" | grep -n $argv | cut -d : -f 1)
  git log --decorate --stat --reverse -p -$N
end
alias gre='git-review'

function touchp
  mkdir -p (dirname "$argv") && touch "$argv"
end

function copy-history -a historyNum
  set -q historyNum[1] || set historyNum 10
  history | tac | tail -n $historyNum | pbcopy
end

function joinpdf
  mkdir -p formatted
  "/System/Library/Automator/Combine PDF Pages.action/Contents/Resources/join.py" --output formatted/output(date "+%Y%m%d_%H%M%S").pdf $argv
end

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
