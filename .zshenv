# zmodload zsh/zprof
setopt no_global_rcs

. /etc/zprofile

typeset -U path cdpath fpath manpath

path=(
  /usr/local/bin(N-/)
  $path
)

if (( $+commands[go] )); then
  export GOPATH=$HOME
  path+=(
    $GOPATH/bin
    $(go env GOROOT)/bin
  )
fi

if (( $+commands[android] )); then
  export ANDROID_HOME=$(brew --prefix)/var/lib/android-sdk
  export NDK=$HOME/Develop/Android/NDK
  export NDK_ROOT=$(brew --prefix)/var/lib/android-ndk/r10e
fi

if (( $+commands[nodebrew] )); then
  path+=(~/.nodebrew/current/bin)
fi

# python, perl, ruby, perl6
for xenv in pyenv plenv rbenv rakudobrew; do
  if (( $+commands[$xenv] )); then
    path=($($xenv root)/shims $path)
    eval "$(SHELL=zsh $xenv init - --no-rehash)"
  fi
done

path+=(./node_modules/.bin)
