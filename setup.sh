#!/bin/bash

DOT_FILES=(.screenrc .vimrc .jshintrc .zshrc)

for file in ${DOT_FILES[@]}
do
    ln -s $HOME/github/dotfiles/$file $HOME/$file
done
