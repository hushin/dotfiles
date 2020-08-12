# fzf
set -x FZF_DEFAULT_COMMAND 'ag -g "" --hidden --ignore ".git"'
set -x FZF_DEFAULT_OPTS "--height 70% --layout=reverse --border --ansi --inline-info"

# Add ~/bin to PATH
set -x PATH ~/bin $PATH

# editor
set -x EDITOR 'emacsclient -t -a ""'

# homebrew
set -x HOMEBREW_CASK_OPTS "--appdir=/Applications"
set -g fish_user_paths "/usr/local/sbin" $fish_user_paths

# diff-highlight
set -x PATH $PATH /usr/local/share/git-core/contrib/diff-highlight

# golang
set -x GOPATH $HOME/.go
set -x PATH $PATH $GOPATH/bin

# ruby
set -x PATH /usr/local/opt/ruby/bin $PATH
if which ruby >/dev/null; and which gem >/dev/null
  set -x PATH (ruby -r rubygems -e 'puts Gem.dir')/bin $PATH
end

# nodebrew
set -x PATH $HOME/.nodebrew/current/bin $PATH

# theme
# bobthefish
set -g theme_color_scheme zenburn
set -g theme_display_date no

# gabbr
set -U gabbr_config $HOME/.config/fish/gabbr.conf

# color
set -g fish_color_command --bold
