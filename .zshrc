export LANG=ja_JP.UTF-8 
export LSCOLORS=gxfxcxdxbxegedabagacad
export TERM=xterm-color
export PATH=/usr/local/bin:$PATH
export EDITOR=vim

bindkey -e


# node
if [[ -f ~/.nvm/nvm.sh ]]; then
    source ~/.nvm/nvm.sh
    nvm use 0.6.14
    export NODE_PATH=${NVM_PATH}_modules:/usr/local/lib/jsctags/

    # 常用npmモジュール
    _NPM_INSTALLED=`npm ls -g`
    for x in optimist async jshint nodeunit mocha should node-inspector node-dev; do
        if ! echo "$_NPM_INSTALLED" | grep "$x@" > /dev/null; then
            npm install -g $x
        fi
    done
    unset _NPM_INSTALLED
fi


# ruby
if [[ -f ~/.rvm/scripts/rvm ]]; then
    source ~/.rvm/scripts/rvm
    rvm use 1.9.3
fi


# java
if [[ -f /usr/local/maven2/bin/mvn ]]; then
    export MAVEN_HOME=/usr/local/maven2
    export PATH=$MAVEN_HOME/bin:$PATH
fi


# prompt
case ${UID} in
    0)
    PROMPT="%B%{[31m%}%/#%{[m%}%b "
    PROMPT2="%B%{[31m%}%_#%{[m%}%b "
    SPROMPT="%B%{[31m%}%r is correct? [n,y,a,e]:%{[m%}%b "
    [ -n "${REMOTEHOST}${SSH_CONNECTION}" ] && 
    PROMPT="%{[37m%}${HOST%%.*} ${PROMPT}"
    ;;
    *)
    PROMPT="%{[31m%}%/%%%{[m%} "
    PROMPT2="%{[31m%}%_%%%{[m%} "
    SPROMPT="%{[31m%}%r is correct? [n,y,a,e]:%{[m%} "
    [ -n "${REMOTEHOST}${SSH_CONNECTION}" ] && 
    PROMPT="%{[37m%}${HOST%%.*} ${PROMPT}"
    ;;
esac
RPS1=$'%D'
RPROMPT="%T"                      # 右側に時間を表示する
setopt transient_rprompt          # 右側まで入力がきたら時間を消す
setopt prompt_subst               # 便利なプロント


# alias
alias ls='ls -G'
alias ll='ls -ahl'
alias l='ls -al'
alias tmux='tmux -2'


## 補完時に大小文字を区別しない
zstyle ':completion:*' matcher-list 'm:{a-z}={A-Z}'
zstyle ':completion:*' menu select=1

autoload -U compinit && compinit

## options
setopt BASH_AUTO_LIST
setopt LIST_AMBIGUOUS
setopt autopushd
stty stop undef

## history
autoload history-search-end
zle -N history-beginning-search-backward-end history-search-end
zle -N history-beginning-search-forward-end history-search-end
bindkey "^P" history-beginning-search-backward-end
bindkey "^N" history-beginning-search-forward-end 
HISTFILE=~/.zsh_history
HISTSIZE=16384
SAVEHIST=16384
setopt hist_ignore_all_dups
setopt hist_reduce_blanks
setopt share_history

zshaddhistory() {
    local line=${1%%$'\n'}
    local cmd=${line%% *}

    # 以下の条件をすべて満たすものだけをヒストリに追加する
    [[ ${#line} -ge 5
        && ${cmd} != (l|l[sal])
        && ${cmd} != (c|cd)
        && ${cmd} != (m|man)
        && ${cmd} != (rm) ]]
}

# 設定ファイルのinclude
[ -f ~/.zshrc.include ] && source ~/.zshrc.include

