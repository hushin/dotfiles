# history
bindkey '^r'   anyframe-widget-put-history
bindkey '^xr' anyframe-widget-execute-history
bindkey '^x^r' anyframe-widget-execute-history

# ghq
bindkey '^]' anyframe-widget-cd-ghq-repository

# git branch
bindkey '^gb'  anyframe-widget-checkout-git-branch
bindkey '^g^b' anyframe-widget-checkout-git-branch
bindkey '^gi' anyframe-widget-insert-git-branch
bindkey '^g^i' anyframe-widget-insert-git-branch

# cdr
bindkey '^[' anyframe-widget-cdr

bindkey '^w' anyframe-widget-select-widget

# kill
bindkey '^p^k' anyframe-widget-kill

# git-add with peco
# ref: http://petitviolet.hatenablog.com/entry/20140722/1406034439
function peco-git-add() {
  local SELECTED_FILE_TO_ADD="$(git status --porcelain  | \
                                peco --query "$LBUFFER" | \
                                awk -F ' ' '{print $NF}')"
  if [ -n "$SELECTED_FILE_TO_ADD" ]; then
    BUFFER="git add $(echo "$SELECTED_FILE_TO_ADD" | tr '\n' ' ')"
    CURSOR=$#BUFFER
    zle accept-line
  fi
}
zle -N peco-git-add
bindkey "^ga"  peco-git-add
bindkey "^g^a" peco-git-add

function peco-git-recent-all-branches() {
  local SELECTED_BRANCH="$(git for-each-ref --format='%(refname)' --sort=-committerdate | \
                           sed -e 's|^refs/\(heads\|remotes\)/||'                       | \
                           peco)"
  if [ -n "$SELECTED_BRANCH" ]; then
    if [ -n "$BUFFER" ]; then
      BUFFER="${BUFFER}${SELECTED_BRANCH}"
    else
      BUFFER="git checkout -t ${SELECTED_BRANCH}"
      zle accept-line
    fi
  fi
  zle clear-screen
}
zle -N peco-git-recent-all-branches
bindkey "^g^g^b"  peco-git-recent-all-branches

# ssh with peco
# ref: http://qiita.com/d6rkaiz/items/46e9c61c412c89e84c38
function peco-ssh() {
  # Hostの次の行にあるコメントをホスト名と一緒に表示するためのrubyワンライナー
  #
  # Host {KEYWORD}
  #   # {COMMENT}
  #   HostName {HOST_NAME}
  #
  # 上記フォーマットをパースして "KEYWORD  # COMMENT" に変換します
  BUFFER="ssh $(
    ruby -e "File.read('$HOME/.ssh/config').scan(/#[ \t]+Host|Host ([^*?\s]+)\n\s+(# [^\n]+)\n|Host ([^*?\s]+)\n/).each do |info|
      unless info.first.nil?
        puts sprintf('%s %s', info[0].ljust(30, ' '), info[1])
      else
        puts info.last
      end
    end" | sort | peco | cut -d ' ' -f 1
  )"
  CURSOR=4
  if [[ $#BUFFER = 4 ]]; then
    BUFFER=''
  fi
  zle clear-screen
}
zle -N peco-ssh
bindkey '^s^s' peco-ssh


# ps with peco
function psp() {
  if [[ $# = 0 ]]; then
    ps -ef | peco
  else
    ps -ef | peco --query "$*"
  fi
}
