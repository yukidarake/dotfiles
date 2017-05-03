set fish_greeting 

# set PATH \
#   ~/.nodebrew/current/bin \
#   ~/.pyenv/shims \
#   ~/.plenv/shims \
#   ~/.rbenv/shims \
#   $GOPATH/bin \
#   /usr/local/bin \
#   $PATH
set -x TERM xterm-256color

set -U EDITOR vim
set -U FZF_TMUX 1
set -U GOPATH $HOME
set -U Z_CMD "j"
set -U Z_DATA "$HOME/.z/.z"

alias tmux 'tmux -2'
alias .. 'cd ..'
alias ... 'cd ../..'
alias .... 'cd ../../..'
alias ..... 'cd ../../../..'
alias cp 'cp -i'
alias rm 'rm -i'
alias mv 'mv -i'
alias nv nvim
