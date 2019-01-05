# FIXME 動かなくなったので一時的に無効化
# bind \x1b 'fzf_recentd' # Ctrl-[にバインドする
bind \cJ 'fzf_recentd'
bind \c] 'fzf_ghq'
bind \ct '__fzf_find_file'
bind \cr '__fzf_reverse_isearch'
bind \eo '__fzf_cd'
bind \eO '__fzf_cd --hidden'
bind \co '__fzf_open'
bind \cO '__fzf_open --editor'
bind \cs\cs fssh
bind \cg\cb checkout-git-branch
bind \cg\cg\cb checkout-recent-git-branch
