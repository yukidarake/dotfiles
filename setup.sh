#!/bin/bash 
set -eux

cd "$(dirname "$0")"

if ! type brew >/dev/null 2>&1; then
  ruby -e "$(curl -fsSL https://raw.github.com/Homebrew/homebrew/go/install)"
  brew bundle
fi

if [ ! -f ~/.vim/autoload/plug.vim ]; then
  curl -fLo ~/.vim/autoload/plug.vim --create-dirs \
      https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
fi

DIRS=(
  "$HOME/.vim/backup "
  "$HOME/.vim/undo "
  "$HOME/.z"
)
for dir in "${DIRS[@]}"; do
  if [ ! -d "$dir" ]; then
    mkdir "$dir"
  fi
done

if [ ! -d ~/.nodebrew ]; then
  nodebrew setup_dirs
fi

if [ ! -d ~/.tmux/plugins/tpm ]; then
  git clone https://github.com/tmux-plugins/tpm ~/.tmux/plugins/tpm
fi

DOT_FILES=(
  .vimrc
  .gvimrc
  .ideavimrc
  .tmux.conf
  .terraformrc
)
for file in "${DOT_FILES[@]}"; do
  if [ ! -h "$HOME/$file" ]; then
    ln -s "$(pwd)/$file" "$HOME/$file"
  fi
done

FISH_FILES=(
  config.fish
  fishfile
)
for file in "${FISH_FILES[@]}"; do
  if [ ! -h "$HOME/.config/fish/$file" ]; then
    ln -s "$(pwd)/.config/fish/$file" "$HOME/.config/fish/$file"
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

# git
git config --global core.editor vim
