export LANG=ja_JP.UTF-8
export LSCOLORS=gxfxcxdxbxegedabagacad
export TERM=xterm-color
export EDITOR=vim
export LESS='-R'
export GREP_OPTIONS='--color=none'
export GIT_MERGE_AUTOEDIT=no
export GOPATH=~/.go

bindkey -e
stty stop undef

typeset -U path PATH fpath
path=(
/usr/local/bin(N-/) 
${path}
)

# node
if [ -f ~/.nodebrew/nodebrew ]; then
  path=(~/.nodebrew/current/bin $path)
  fpath=(~/.nodebrew/completions/zsh $fpath)
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
alias ls='ls -G'
alias ll='ls -ahl'
alias l='ls -al'
alias ltr='ls -ltr'
alias cp='cp -i'
alias mv='mv -i'
alias rm='rm -i'
alias less='less -R'
alias tmux='tmux -2'
alias view='vim -R'
alias v='vim -'
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
alias -g V=' | v'
 
# cd to the path of the front Finder window
cdf() {
  target=`osascript -e 'tell application "Finder" to if (count of Finder windows) > 0 then get POSIX path of (target of front Finder window as text)'`
  if [ "$target" != "" ]; then
    cd "$target"; pwd
  else
    echo 'No Finder window found' >&2
  fi
}

if [ -f ~/.zsh/plugins/auto-fu.zsh/auto-fu.zsh ]; then
  . ~/.zsh/plugins/auto-fu.zsh/auto-fu.zsh
  function zle-line-init () {
      auto-fu-init
  }
  zle -N zle-line-init
  zstyle ':completion:*' completer _oldlist _complete
  zstyle ':auto-fu:var' postdisplay ''
fi

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

# 補完
fpath=(~/.zsh/plugins/zsh-completions/src $fpath)
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
autoload history-search-end
zle -N history-beginning-search-backward-end history-search-end
zle -N history-beginning-search-forward-end history-search-end
bindkey "^P" history-beginning-search-backward-end
bindkey "^N" history-beginning-search-forward-end
bindkey '^R' history-incremental-pattern-search-backward
bindkey '^S' history-incremental-pattern-search-forward
HISTFILE=~/.zsh_history
HISTSIZE=16384
SAVEHIST=16384
LISTMAX=1000
setopt hist_ignore_all_dups
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
