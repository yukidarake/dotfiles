# zmodload zsh/zprof

typeset -U path cdpath fpath manpath

path=(
  /usr/local/bin(N-/)
  $path
)

export GOPATH=$HOME
if (( $+commands[go] )); then
  path+=(
    $GOPATH/bin(N-/)
    $(go env GOROOT)/bin(N-/)
  )
fi

export ANDROID_HOME=$(brew --prefix)/Cellar/android-sdk/24.3.3
export NDK=$HOME/Develop/Android/NDK
export NDK_ROOT=$(brew --prefix)/Cellar/android-ndk/r10e

if (( $+commands[nodebrew] )); then
  path=(~/.nodebrew/current/bin $path)
  # fpath+=(~/.nodebrew/completions/zsh)
fi

# java
if [ -f /usr/local/maven2/bin/mvn ]; then
  export MAVEN_HOME=/usr/local/maven2
  path+=($MAVEN_HOME/bin)
fi
