#!/bin/sh
# Add Repository
brew tap homebrew/versions 
brew tap homebrew/dupes 
brew tap homebrew/nginx 
brew tap caskroom/cask 
brew tap caskroom/versions

# Packages
brew install zsh --disable-etcdir 
brew install brew-cask 
brew install coreutils 
brew install curl 
brew install git 
brew install go 
brew install hg 
brew install hub 
brew install lua 
brew install luajit 
brew install mobile-shell 
brew install mongodb
brew install nginx-full 
brew install ngrep 
brew install nodebrew 
brew install peco 
brew install plenv 
brew install pyenv 
brew install rbenv 
brew install readline 
brew install reattach-to-user-namespace 
brew install ruby-build
brew install shellcheck 
brew install the_silver_searcher 
brew install tig 
brew install tmux 
brew install wget 

# git diff
ln -s /usr/local/share/git-core/contrib/diff-highlight/diff-highlight /usr/local/bin/diff-highlight 

# Install homebrew-cask applications into /Applications
export HOMEBREW_CASK_OPTS="--appdir=/Applications"

# Add GUI Applications
brew cask install alfred 
brew cask install appcleaner 
brew cask install bettertouchtool 
brew cask install day-o 
brew cask install google-chrome 
brew cask install google-japanese-ime 
brew cask install karabiner 
brew cask install macvim-kaoriya
brew cask install nosleep 
brew cask install skype 
brew cask install slack 
brew cask install vagrant 
brew cask install virtualbox 
brew cask install waterroof 
