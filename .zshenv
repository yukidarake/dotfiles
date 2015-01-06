# zmodload zsh/zprof

typeset -U path cdpath fpath manpath

path=(
  /usr/local/bin(N-/)
  $path
)

export GOPATH=$HOME
if [ $+commands[go] ]; then
  path+=(
    $GOPATH/bin(N-/)
    $(go env GOROOT)/bin(N-/)
  )
fi

export ANDROID_HOME=$(brew --prefix)/Cellar/android-sdk/23.0.2
export NDK=$HOME/Develop/Android/NDK
export NDK_ROOT=$(brew --prefix)/Cellar/android-ndk/r10c

if [ $+commands[nodebrew] ]; then
  path=(~/.nodebrew/current/bin $path)
  # fpath+=(~/.nodebrew/completions/zsh)
fi

# if [ $+commands[nvm] ]; then
#   . ~/.nvm/nvm.sh
#   nvm use default
# fi

# python, perl, ruby
for xenv in pyenv plenv rbenv; do
  if [ $+commands[$xenv] ]; then
    eval "$(SHELL=zsh $xenv init - --no-rehash)"
    path=($($xenv root)/shims $path)
  fi
done

# java
if [ -f /usr/local/maven2/bin/mvn ]; then
  export MAVEN_HOME=/usr/local/maven2
  path+=($MAVEN_HOME/bin)
fi
