#!/bin/bash -x

cd $(dirname $0)
GITHUB_ROOT=$(cd ../.. && pwd)

if ! type brew >/dev/null 2>&1; then
  ruby -e "$(curl -fsSL https://raw.github.com/Homebrew/homebrew/go/install)"
  . ./brew.sh
fi

if [ ! -d ~/.vim/bundle ]; then
    mkdir -p ~/.vim/bundle
    git clone git://github.com/Shougo/neobundle.vim ~/.vim/bundle/neobundle.vim
fi

DOT_FILES=(".zsh* .screenrc .vimrc .jshintrc .gvimrc .tmux.conf")
for file in ${DOT_FILES[@]}; do
    ln -s $(pwd)/$file ~/$file
done

if type go >/dev/null 2>&1; then
  go get -v code.google.com/p/go.tools/cmd/goimports
  go get -v code.google.com/p/rog-go/exp/cmd/godef
  go get -v github.com/motemen/ghq
  go get -v github.com/nsf/gocode 
  go get -v github.com/tools/godep
  go get -v github.com/golang/lint/golint
fi

if type npm >/dev/null 2>&1; then
  npm i -g node-inspector jshint mocha should nodemon longjohn jsonlint eslint jscs
fi

if [ ! -d $GITHUB_ROOT ]; then
  mkdir -p $GITHUB_ROOT
fi

REPOS=(
  Lokaltog/powerline-fonts
  chriskempson/tomorrow-theme
)

for repo in ${REPOS[@]}; do
  if [ ! -d $GITHUB_ROOT/$repo ]; then
    git clone https://github.com/${repo}.git $GITHUB_ROOT/$repo
  fi
done

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

if [ ! -d ~/.tmux/plugins/tpm ]; then
   git clone https://github.com/tmux-plugins/tpm ~/.tmux/plugins/tpm
fi


# タブでボタンを選択できるようにする
#システム環境設定→キーボード→キーボードショートカット→すべてのコントロール

#ダブルタップでドラッグにする
#システム環境設定→アクセシビリティ→マウスとトラックパッド→トラックパッドオプション→ドラッグを有効にする

# dashboardを無効にする
# defaults write com.apple.dashboard mcx-disabled -boolean true
# アニメーション高速化
# defaults write com.apple.dock expose-animation-duration -float 0.15
# killall Dock


