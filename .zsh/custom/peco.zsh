# history
bindkey '^r'   anyframe-widget-put-history

# git branch
bindkey '^gb'  anyframe-widget-checkout-git-branch
bindkey '^g^b' anyframe-widget-checkout-git-branch
bindkey '^g^b^b' anyframe-widget-insert-git-branch

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

# ghq with peco
function peco-src () {
  local selected_dir=$(ghq list -p | peco --query "$LBUFFER")
  if [ -n "$selected_dir" ]; then
    BUFFER="cd ${selected_dir}"
    zle accept-line
  fi
  zle clear-screen
}
zle -N peco-src
bindkey '^]' peco-src

# tmux with peco
function peco-tmux() {
  local i=$(tmux lsw | awk '/active.$/ {print NR-1}')
  local f='#{window_index}: #{window_name}#{window_flags} #{pane_current_path}'
  tmux lsw -F "$f" \
    | anyframe-selector-auto '' --initial-index $i \
    | cut -d ':' -f 1 \
    | anyframe-action-execute tmux select-window -t
}
zle -N peco-tmux
bindkey '^l^l' peco-tmux
