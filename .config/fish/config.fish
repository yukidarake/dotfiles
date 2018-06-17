set fish_greeting 

if not string match -q '*shims*' -- $PATH
  set -x PATH \
    ~/.nodebrew/current/bin \
    ~/.pyenv/shims \
    ~/.rbenv/shims \
    $GOPATH/bin \
    $PATH
end
set -x TERM xterm-256color
set -x EDITOR vim
set -x FZF_TMUX 0
set -x GOPATH $HOME
set -x Z_CMD "j"
set -x Z_DATA "$HOME/.z/.z"

alias tmux 'tmux -2'
alias .. 'cd ..'
alias ... 'cd ../..'
alias .... 'cd ../../..'
alias ..... 'cd ../../../..'
alias cp 'cp -i'
alias rm 'rm -i'
alias mv 'mv -i'
alias l ll
