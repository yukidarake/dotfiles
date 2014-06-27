export LANG=ja_JP.UTF-8
export LSCOLORS=gxfxcxdxbxegedabagacad
export TERM=xterm-color
export EDITOR=vi
export LESS='-R'
export GREP_OPTIONS='--color=none'
export GIT_MERGE_AUTOEDIT=no
export GOPATH=$HOME

bindkey -e
stty stop undef

typeset -U path PATH fpath
path=(
/usr/local/bin(N-/)
$GOPATH/bin(N-/)
$path
)

# node
if [ -f ~/.nodebrew/nodebrew ]; then
  path+=(~/.nodebrew/current/bin)
  fpath+=(~/.nodebrew/completions/zsh)
  if [ ! -h /usr/local/share/zsh/site-functions/_nodebrew ]; then
    ln -s ~/.nodebrew/completions/zsh/_nodebrew \
      /usr/local/share/zsh/site-functions/
  fi
  export NODE_PATH=~/.nodebrew/current/lib/node_modules
  nodebrew use v0.8
fi

# python
if [ $+commands[pyenv] ]; then
  eval "$(SHELL=zsh pyenv init -)"
fi

# perl
if [ $+commands[plenv] ]; then
  eval "$(SHELL=zsh plenv init -)"
fi

# ruby
if [ $+commands[rbenv] ]; then
  eval "$(SHELL=zsh rbenv init - --no-rehash)"
fi

# java
if [ -f /usr/local/maven2/bin/mvn ]; then
  export MAVEN_HOME=/usr/local/maven2
  path=($path $MAVEN_HOME/bin)
fi

if [ -s ~/.tmuxinator/scripts/tmuxinator ]; then
  . ~/.tmuxinator/scripts/tmuxinator
fi

# alias
git config --global core.editor ~/Applications/MacVim.app/Contents/MacOS/Vim
alias vim='env LANG=ja_JP.UTF-8 ~/Applications/MacVim.app/Contents/MacOS/Vim -u $HOME/.vimrc'
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
alias p='peco'

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
function() {

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

}
# tmux end

_fh() {
  grep -E '[0-9]' /etc/hosts | peco
}

_fh-ip() {
  _fh | perl -pe 's/^[# ]*([0-9.]+)\s+.+/$1/'
}

_fh-host() {
  _fh | perl -pe 's/^[# ]*[0-9.]+\s+(\S+).*$/$1/'
}

fh() {
  _fh | tee >(pbcopy)
}

fh-ip() {
  _fh-ip | tee >(pbcopy)
}

fh-host() {
  _fh-host | tee >(pbcopy)
}

fh-open() {
  local h
  h=$(_fh-host)
  open "http://${h}"
}

# peco
function() {

if (( ! $+commands[tac] )); then
  alias tac='tail -r'
fi

peco-writeback() {
  BUFFER=$($LBUFFER | peco)
  CURSOR=$#BUFFER
  zle -R -c
}
zle -N peco-writeback
bindkey '^X^X' peco-writeback

peco-find() {
  LBUFFER="$LBUFFER$(find * -path '*/\.*' -prune -o -type f -print -o -type l -print 2> /dev/null | peco)"
  BUFFER="$LBUFFER$RBUFFER"
  CURSOR=$#LBUFFER
  zle -R -c
}
zle -N peco-find
bindkey "^X^F" peco-find

peco-jump-dir() {
  local DIR=${BUFFER#cd }
  local DEST=$(find -E ${DIR:-.} -regex '.*\.(git|svn).*' -prune -o -type d 2> /dev/null | peco)
  if [ -n $DEST ]; then
    BUFFER="cd $DEST"
    zle accept-line
  fi
  zle -R -c
}
zle -N peco-jump-dir
bindkey "^X^D" peco-jump-dir

peco-kill() {
  ps -ef | sed 1d | peco | awk '{print $2}' | xargs kill -${1:-9}
}
zle -N peco-kill
bindkey "^X^K" peco-kill

peco-change-dir() {
  local DEST=$(_z -l "$LBUFFER" 2>&1 | awk '{ print $2 }' | tac | peco)
  if [ -n "$DEST" ]; then
    BUFFER="cd $DEST"
    zle accept-line
  fi
  #zle reset-prompt
  #zle clear-screen
  zle -R -c
}
zle -N peco-change-dir
bindkey "^X^J" peco-change-dir
bindkey "^J" peco-change-dir

peco-select-history() {
  BUFFER=$(fc -l -n 1 | tac | peco --query "$LBUFFER")
  CURSOR=$#BUFFER
  zle -R -c
}
zle -N peco-select-history
bindkey '^X^R' peco-select-history
bindkey '^R' peco-select-history

peco-src() {
  local SELECTED_DIR=$(ghq list --full-path | peco --query "$LBUFFER")
  if [ -n "$SELECTED_DIR" ]; then
    BUFFER="cd $SELECTED_DIR"
    zle accept-line
  fi
  zle clear-screen
}
zle -N peco-src
bindkey '^G' peco-src
}
# peco end

if [ -f ~/.zsh/plugins/z/z.sh ]; then
    _Z_CMD=j
    _Z_DATA=~/.z/.z
    . ~/.zsh/plugins/z/z.sh
fi

if [ -f ~/.zsh/plugins/pure/pure.zsh ]; then
  if [ ! -h /usr/local/share/zsh/site-functions/prompt_pure_setup ]; then
      ln -s ~/.zsh/plugins/pure/pure.zsh \
        /usr/local/share/zsh/site-functions/prompt_pure_setup
  fi
  autoload -U promptinit && promptinit
  prompt pure

  # display svn branch info
  zstyle ':vcs_info:*' enable git svn
  zstyle ':vcs_info:svn*' formats ' %F{magenta}%s%f %b'
  zstyle ':vcs_info:svn*' branchformat '%b:r%r'
  zstyle ':vcs_info:svn+set-branch-format:*' hooks svn-hook
  +vi-svn-hook() {
    hook_com[branch]=`svn info | perl -ne 's/^Relative URL: // && print'`
  }
fi

if [ -f ~/.zsh/plugins/auto-fu.zsh/auto-fu.zsh ]; then
  . ~/.zsh/plugins/auto-fu.zsh/auto-fu.zsh
  function zle-line-init () {
      auto-fu-init
  }
  zle -N zle-line-init
  zstyle ':completion:*' completer _oldlist _complete
  zstyle ':auto-fu:var' postdisplay ''
fi

# 補完
fpath+=(~/.zsh/plugins/zsh-completions/src)
autoload -U compinit && compinit
compdef mosh=ssh

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

# 設定ファイルのinclude
if [ -f ~/.zshrc.include ]; then
  . ~/.zshrc.include
fi

#if (which zprof > /dev/null) ;then
#  zprof | less
#fi

