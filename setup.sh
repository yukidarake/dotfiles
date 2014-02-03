#!/bin/bash

DOT_FILES=(.screenrc .vimrc .jshintrc .zshrc .zsh .gvimrc .tmux.conf)

if [ ! -d ~/.vim/bundle ]; then
    mkdir -p ~/.vim/bundle
    git clone git://github.com/Shougo/neobundle.vim ~/.vim/bundle/neobundle.vim
fi

for file in ${DOT_FILES[@]}; do
    ln -s $HOME/github/dotfiles/$file $HOME/$file
done

if [ -f ~/.nodebrew/nodebrew ]; then
  curl -L git.io/nodebrew | perl - setup
fi

npm i -g node-inspector jshint mocha should nodemon longjohn jsonlint

if [ ! -d ~/github ]; then
  mkdir ~/github
fi

if [ ! -d ~/github/powerline-fonts ]; then
  git clone git@github.com:Lokaltog/powerline-fonts.git
fi

if [ ! -d ~/github/tomorrow-theme ]; then
  git clone git@github.com:chriskempson/tomorrow-theme.git
fi
