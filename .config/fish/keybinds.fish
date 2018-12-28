function fish_user_key_bindings
  bind \x1b 'fzf_recentd' # Ctrl-[にバインドする
  bind \c] 'fzf_ghq'
  bind \ct '__fzf_find_file'
  bind \cr '__fzf_reverse_isearch'
  bind \eo '__fzf_cd'
  bind \eO '__fzf_cd --hidden'
  # bind \cg '__fzf_open'
  bind \co '__fzf_open --editor'
  bind \cs\cs fssh
  bind \cg\cb checkout-git-branch
  bind \cg\cg\cb checkout-recent-git-branch
end