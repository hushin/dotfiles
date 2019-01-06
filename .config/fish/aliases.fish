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
alias tree "tree -NC" # N: 文字化け対策, C:色をつける
alias notes 'ag "TODO|HACK|FIXME|OPTIMIZE"'

alias e='emacsclient -t -a ""'
alias ekill='emacsclient -e "(kill-emacs)"'

function f
  git ls-tree -r --name-only HEAD
end

function ef
  f | fzf | xargs -o emacsclient -t -a ""
end

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

# https://github.com/junegunn/fzf/wiki/Examples-(fish)
function fssh -d "Fuzzy-find ssh host via ag and ssh into it"
  ag --ignore-case '^host [^*]' ~/.ssh/config | cut -d ' ' -f 2 | fzf --preview='' | read -l result; and ssh "$result"
  commandline -f repaint
end

function checkout-git-branch -d "Fuzzy-find and checkout a branch"
  git branch | grep -v HEAD | string trim | fzf --preview="git log -200 --pretty=format:%s" | read -l result; and git checkout "$result"
  commandline -f repaint
end

function checkout-recent-git-branch -d "Fuzzy-find and checkout a branch"
  git for-each-ref --format="%(refname)" --sort=-committerdate | \
  grep -v HEAD | \
  grep -v refs/tags | \
  sed -e "s|^refs/heads/||" | \
  sed -e "s|^refs/remotes/||" | \
  string trim | \
  fzf --preview='' | \
  read -l result; and git checkout -t "$result"
  commandline -f repaint
end

# https://gist.github.com/azu/09dd6f27f52e2e8d9978
function mkdev -a dirName
	if ! test "$dirName"
		echo "Usage: mkdev dir-name"
		return
	end
	set -l rootDir (ghq root)
  set -l gitUser (git config user.name)
	set -l githubUser "github.com/$gitUser"
	set -l devPath "$rootDir/$githubUser/$dirName"

	mkdir -p $devPath
	cd $devPath
end

function move-to-bitbucket -d "github to bitbucket ghq directory" -a dirName
	if ! test "$dirName"
		echo "Usage: move-to-bitbucket dir-name"
		return
	end
	set -l rootDir (ghq root)
  set -l gitUser (git config user.name)
	set -l bitbucketUser "bitbucket.org/$gitUser"
  set -l path "$rootDir/$bitbucketUser/"

  mkdir -p $path
  mv $dirName $path
  cd "$path/$dirName"
end
