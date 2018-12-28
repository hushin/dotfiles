set -x FZF_DEFAULT_COMMAND 'ag -g "" --hidden --ignore ".git"'
set -x FZF_DEFAULT_OPTS "--height 50% --layout=reverse --border --inline-info --preview 'head -100 {}'"

# Add ~/bin to PATH
set -x PATH ~/bin $PATH

# editor
set -x EDITOR 'emacsclient -t -a ""'

# diff-highlight
set -x PATH $PATH /usr/local/share/git-core/contrib/diff-highlight

# golang
set -x GOPATH $HOME/.go
set -x PATH $PATH $GOPATH/bin

# theme
# bobthefish
set -g theme_color_scheme solarized-light
set -g theme_display_date no