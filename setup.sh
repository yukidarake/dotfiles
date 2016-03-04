#!/bin/bash 
set -ux

cd $(dirname $0)
GITHUB_ROOT=$(cd ../.. && pwd)

if ! type brew >/dev/null 2>&1; then
  ruby -e "$(curl -fsSL https://raw.github.com/Homebrew/homebrew/go/install)"
  . ./brew.sh
fi

if [ ! -d ~/.vim/rc ]; then
  ln -s ~/src/github.com/yukidarake/dotfiles/.vim/rc/ ~/.vim/rc
fi

if [ ! -d ~/.tmux/plugins/tpm ]; then
  git clone https://github.com/tmux-plugins/tpm ~/.tmux/plugins/tpm
fi

REPOS=(
  # zsh-users/antigen
  tarjoilija/zgen
  Lokaltog/powerline-fonts
  chriskempson/tomorrow-theme
)
for repo in ${REPOS[@]}; do
  if [ ! -d $GITHUB_ROOT/$repo ]; then
    git clone https://github.com/${repo}.git $GITHUB_ROOT/$repo
  fi
done

DOT_FILES=(".zsh* .screenrc .vimrc .jshintrc .gvimrc .tmux.conf. .tern-config")
for file in ${DOT_FILES[@]}; do
    ln -s $(pwd)/$file ~/$file
done

ln -s $(pwd)/snippets ~/snippets

if type go >/dev/null 2>&1; then
  go get -v github.com/motemen/ghq
  go get -v code.google.com/p/go.tools/cmd/goimports
  go get -v code.google.com/p/rog-go/exp/cmd/godef
  go get -v github.com/nsf/gocode 
  go get -v github.com/tools/godep
  go get -v github.com/golang/lint/golint
fi

if type npm >/dev/null 2>&1; then
  npm i -g node-inspector longjohn jsonlint eslint-cli js-yaml
fi

# key binding
if [ ! -f ~/Library/KeyBindings/DefaultKeyBinding.dict ]; then
  mkdir ~/Library/KeyBindings
  cat << _EOT_ >> ~/Library/KeyBindings/DefaultKeyBinding.dict 2>&1
{
  "^w"="deleteWordBackward:";
  "^u"="deleteToBeginningOfParagraph";
}
_EOT_
fi


