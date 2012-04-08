export LANG=ja_JP.UTF-8
export LSCOLORS=gxfxcxdxbxegedabagacad
export TERM=xterm-color
export PATH=/usr/local/bin:$PATH
export EDITOR=vim
export LESS='-R'
export GREP_OPTIONS='--color=always'


bindkey -e
stty stop undef


# node
if [[ -f ~/.nvm/nvm.sh ]]; then
    source ~/.nvm/nvm.sh
    nvm use 0.6.14
    export NODE_PATH=${NVM_PATH}_modules:/usr/local/lib/jsctags/

    # 常用npmモジュール
    __NPM_INSTALLED=`npm ls -g`
    __NPM_MODULES=(
        optimist async jshint nodeunit mocha
        should node-inspector node-dev long-stack-traces
    )
    for x in ${__NPM_MODULES[@]}; do
        if ! echo "$__NPM_INSTALLED" | grep "$x@" > /dev/null; then
            npm install -g $x
        fi
    done
    unset __NPM_INSTALLED
    unset __NPM_MODULES
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
alias mv='mv -i'
alias rm='rm -i'
alias less='less -R'
alias tmux='tmux -2'
alias view='vim -R'
alias v='vi -'


# 補完
autoload -U compinit && compinit

## 補完時に大小文字を区別しない
zstyle ':completion:*' matcher-list 'm:{a-z}={A-Z}'
zstyle ':completion:*' menu select=1




# options
setopt bash_auto_list
setopt list_ambiguous
setopt autopushd



# 単語の単位は/で区切る
autoload -Uz select-word-style
select-word-style default
zstyle ':zle:*' word-chars " _-./;@"
zstyle ':zle:*' word-style unspecified


# history
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

