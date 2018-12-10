set -x FZF_DEFAULT_COMMAND 'ag -g "" --hidden --ignore ".git"'
set -x FZF_DEFAULT_OPTS "--height 50% --layout=reverse --border --inline-info --preview 'head -100 {}'"


# theme
# bobthefish
set -g theme_color_scheme solarized-light
set -g theme_display_date no