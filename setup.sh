#!/bin/bash

DOT_FILES=(.screenrc .vimrc .jshintrc .zshrc .zsh .gvimrc .tmux.conf)

if [ ! -d ~/.vim/bundle ]; then
    mkdir -p ~/.vim/bundle
    git clone git://github.com/Shougo/neobundle.vim ~/.vim/bundle/neobundle.vim
fi

for file in ${DOT_FILES[@]}; do
    ln -s ~/github/dotfiles/$file ~/$file
done

if [ ! -f ~/.nodebrew/nodebrew ]; then
  curl -L git.io/nodebrew | perl - setup
fi

npm i -g node-inspector jshint mocha should nodemon longjohn jsonlint

if [ ! -d ~/github ]; then
  mkdir ~/github
fi

if [ ! -d ~/github/powerline-fonts ]; then
  git clone https://github.com:Lokaltog/powerline-fonts.git ~/github/powerline-fonts
fi

if [ ! -d ~/github/tomorrow-theme ]; then
  git clone https://github.com:chriskempson/tomorrow-theme.git ~/github/tommorow-theme
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


# タブでボタンを選択できるようにする
#システム環境設定→キーボード→キーボードショートカット→すべてのコントロール

#ダブルタップでドラッグにする
#システム環境設定→アクセシビリティ→マウスとトラックパッド→トラックパッドオプション→ドラッグを有効にする

# dashboardを無効にする
# defaults write com.apple.dashboard mcx-disabled -boolean true
# アニメーション高速化
# defaults write com.apple.dock expose-animation-duration -float 0.15
# killall Dock


