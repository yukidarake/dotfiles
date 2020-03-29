set fish_greeting 

export LANG=ja_JP.UTF-8

if not string match -q '*shims*' -- $PATH
  set -x PATH \
    ~/.nodebrew/current/bin \
    ~/.pyenv/shims \
    ~/go/bin \
    $PATH
end
set -x TERM xterm-256color
set -x EDITOR vim
set -x FZF_TMUX 0
set -x Z_CMD "j"
set -x Z_DATA "$HOME/.z/.z"

alias tmux 'tmux -2 -u'
alias .. 'cd ..'
alias ... 'cd ../..'
alias .... 'cd ../../..'
alias ..... 'cd ../../../..'
alias cp 'cp -i'
alias rm 'rm -i'
alias mv 'mv -i'
alias l ll
alias vi vim

source /usr/local/opt/asdf/asdf.fish
