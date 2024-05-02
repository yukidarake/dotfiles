#!/bin/bash 
set -euxo pipefail

cd "$(dirname "$0")"

if ! type brew >/dev/null 2>&1; then
  /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install.sh)"
  echo 'eval "$(/opt/homebrew/bin/brew shellenv)"' >> ~/.zprofile
  eval "$(/opt/homebrew/bin/brew shellenv)"
  brew bundle
fi

if [ ! -d ~/.tmux/plugins/tpm ]; then
  git clone https://github.com/tmux-plugins/tpm ~/.tmux/plugins/tpm
fi

PLUG_VIM="${XDG_DATA_HOME:-$HOME/.local/share}"/nvim/site/autoload/plug.vim
if [ ! -e "$PLUG_VIM" ]; then
  curl -fLo "$PLUG_VIM" --create-dirs 'https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim'
fi

DOT_FILES=(
  .vimrc
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
  fish/fish_plugins
  karabiner/karabiner.json
  alacritty/alacritty.yml
  nvim/init.vim
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
git config --global alias.f 'fetch --prune'
git config --global merge.ff false
git config --global pull.ff only

# key repeat
defaults write -g InitialKeyRepeat -int 10
defaults write -g KeyRepeat -int 1

# https://qiita.com/ucan-lab/items/c1a12c20c878d6fb1e21
defaults write com.apple.finder AppleShowAllFiles -boolean true
defaults write com.apple.desktopservices DSDontWriteNetworkStores true
