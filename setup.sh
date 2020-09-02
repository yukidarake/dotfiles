#!/bin/bash 
set -eux

cd "$(dirname "$0")"

if ! type brew >/dev/null 2>&1; then
  /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install.sh)"
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

CONFIG_FILES=(
  fish/config.fish
  fish/fishfile
  karabiner/karabiner.json
  alacritty/alacritty.yml
)
for file in "${CONFIG_FILES[@]}"; do
  if [ ! -h "$HOME/.config/$file" ]; then
    mkdir -p "$(dirname "$HOME/.config/$file")"
    ln -s "$(pwd)/.config/$file" "$HOME/.config/$file"
  fi
done

if type fisher >/dev/null 2>&1; then
  fisher
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

# git
git config --global core.editor vim
git config --global ghq.root ~/go/src 
git config --global commit.verbose true
git config --global color.ui true
git config --global alias.br branch
git config --global alias.ci commit
git config --global alias.co checkout
git config --global alias.st 'status -uno'
git config --global alias.p 'pull --prune'

# key repeat
defaults write -g InitialKeyRepeat -int 10
defaults write -g KeyRepeat -int 1

# https://qiita.com/ucan-lab/items/c1a12c20c878d6fb1e21
defaults write com.apple.finder AppleShowAllFiles -boolean true
defaults write com.apple.desktopservices DSDontWriteNetworkStores true
