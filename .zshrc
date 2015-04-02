bindkey -e
stty stop undef

export LANG=ja_JP.UTF-8
export LSCOLORS=gxfxcxdxbxegedabagacad
export TERM=xterm-color
export EDITOR="$HOME/Applications/MacVim.app/Contents/MacOS/Vim"
export LESS='-R'
export GREP_OPTIONS='--color=none'
export GIT_MERGE_AUTOEDIT=no

if [ -s ~/.tmuxinator/scripts/tmuxinator ]; then
  . ~/.tmuxinator/scripts/tmuxinator
fi

# git
git config --global core.editor "$EDITOR"

# alias
alias vim="env LANG=ja_JP.UTF-8 $EDITOR -u $HOME/.vimrc"
alias vi=vim
alias view='vim -R'
alias v='vim -'
alias ls='ls -G'
alias ll='ls -ahl'
alias l='ls -al'
alias ltr='ls -ltr'
alias cp='cp -i'
alias mv='mv -i'
alias rm='rm -i'
alias less='less -R'
alias tmux='tmux -2'
alias ..='cd ..'
alias ...='cd ../..'
alias ....='cd ../../..'
alias .....='cd ../../../..'
alias diff='diff --exclude=".svn"'
alias ag='ag -S --nogroup --nocolor'
alias f='open .'
alias L='less'
alias h='history'
alias H='history 0'
alias man='vs man'

# cd to the path of the front Finder window
cdf() {
  target=`osascript -e 'tell application "Finder" to if (count of Finder windows) > 0 then get POSIX path of (target of front Finder window as text)'`
  if [ "$target" != "" ]; then
    cd "$target"; pwd
  else
    echo 'No Finder window found' >&2
  fi
}

# tmux
() {

vs() {
  tmux split-window -h "exec $*"
}

sp() {
  tmux split-window -v "exec $*"
}

sssh() {
  tmux new-window -n $@ "exec ssh $@"
}

moshx() {
  SSHX_COMMAND=mosh sshx $@
}

sshx() {
  local SSH=${SSHX_COMMAND:-ssh}

  if [ -n "$SESSION_NAME" ]; then
    session=$SESSION_NAME
  else
    session=${SSH}x-`date +%s`
  fi

  window=${SSH}x

  tmux new-session -d -n $window -s $session

  tmux send-keys "$SSH $1" C-m
  shift

  for h in $*; do
    tmux split-window
    tmux select-layout tiled
    tmux send-keys "$SSH $h" C-m
  done

  tmux select-pane -t 0

  tmux set-window-option synchronize-panes on

  tmux attach-session -t $session
}

} # tmux end

# 補完時に大小文字を区別しない
zstyle ':completion:*' matcher-list 'm:{a-z}={A-Z}'
zstyle ':completion:*' menu select=1

# options
setopt bash_auto_list
setopt list_ambiguous
setopt autopushd
setopt auto_cd

# history
# autoload history-search-end
# zle -N history-beginning-search-backward-end history-search-end
# zle -N history-beginning-search-forward-end history-search-end
# bindkey "^P" history-beginning-search-backward-end
# bindkey "^N" history-beginning-search-forward-end
# bindkey '^R' history-incremental-pattern-search-backward
# bindkey '^S' history-incremental-pattern-search-forward
HISTFILE=~/.zsh_history
HISTSIZE=16384
SAVEHIST=16384
LISTMAX=1000
setopt hist_ignore_all_dups
setopt hist_ignore_space
setopt hist_reduce_blanks
setopt share_history

zshaddhistory() {
  local line=${1%%$'\n'}
  local cmd=${line%% *}

  # 以下の条件をすべて満たすものだけをヒストリに追加する
  [[ ${#line} -ge 5
    && ! ( ${cmd} =~ [[:\<:]](mv|cd|rm|l[sal]|[lj]|man)[[:\>:]] ) ]]
}

# include
[ -f ~/.zshrc.zgen ] && . ~/.zshrc.zgen
[ -f ~/.zshrc.local ] && . ~/.zshrc.local

# if type zprof > /dev/null 2>&1; then
#   zprof | less
# fi

