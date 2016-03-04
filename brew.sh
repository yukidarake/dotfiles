# Add Repository
brew tap homebrew/versions 
brew tap homebrew/dupes 
brew tap homebrew/nginx 
brew tap caskroom/cask 
brew tap caskroom/versions

# Packages
brew install brew-cask 
brew install coreutils 
brew install curl 
brew install git 
brew install go 
brew install hg 
brew install hub 
brew install lua 
brew install luajit 
brew install mongodb
brew install mobile-shell 
#brew install nginx 
brew install nginx-full 
brew install ngrep 
brew install peco 
brew install plenv 
brew install pyenv 
brew install rbenv 
brew install ruby-build
brew install nodebrew 
brew install readline 
brew install reattach-to-user-namespace 
brew install subversion 
brew install the_silver_searcher 
brew install tig 
brew install tmux 
brew install w3m 
brew install wget 
brew install --disable-etcdir zsh 

# git diff
ln -s /usr/local/share/git-core/contrib/diff-highlight/diff-highlight /usr/local/bin/diff-highlight 

# Install homebrew-cask applications into /Applications
export HOMEBREW_CASK_OPTS="--appdir=/Applications"

# Add GUI Applications
brew cask install alfred 
brew cask install appcleaner 
brew cask install bettertouchtool 
brew cask install chromium 
brew cask install day-o 
brew cask install firefox 
brew cask install google-chrome 
brew cask install google-japanese-ime 
brew cask install iterm2 
brew cask install karabiner 
brew cask install nosleep 
brew cask install skype 
brew cask install slack 
brew cask install waterroof 
brew cask install virtualbox 
brew cask install vagrant 
brew cask install macvim-kaoriya
