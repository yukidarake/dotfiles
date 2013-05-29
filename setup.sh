#!/bin/bash

DOT_FILES=(.screenrc .vimrc .jshintrc .zshrc .zsh .gvimrc .tmux.conf)

if [ ! -d ~/.vim/bundle ]; then
    mkdir -p ~/.vim/bundle
    git clone git://github.com/Shougo/neobundle.vim ~/.vim/bundle/neobundle.vim
fi

for file in ${DOT_FILES[@]}
do
    ln -s $HOME/github/dotfiles/$file $HOME/$file
done
