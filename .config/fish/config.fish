set fish_greeting 

set -x GOPATH $HOME
set -x EDITOR vim
set -x TERM xterm-256color
set -x PATH /usr/local/bin $PATH
set -x PATH ~/.nodebrew/current/bin $PATH
set -x PATH ~/.pyenv/shims $PATH
set -x PATH ~/.plenv/shims $PATH
set -x PATH ~/.rbenv/shims $PATH
set -x PATH $GOPATH/bin $PATH

set -U FZF_TMUX 1
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
