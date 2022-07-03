set fish_greeting

fish_add_path ~/go/bin 
set -x TERM xterm-256color
set -x PIPENV_VENV_IN_PROJECT true
set -x LANG ja_JP.UTF-8
set -x EDITOR vim
set -x FZF_TMUX 0
set -x Z_CMD "j"
set -x Z_DATA "$HOME/.z/.z"

alias tmux 'tmux -2 -u'
alias .. 'cd ..'
alias ... 'cd ../..'
alias .... 'cd ../../..'
alias ..... 'cd ../../../..'
alias l 'ls -la'
alias cp 'cp -i'
alias rm 'rm -i'
alias mv 'mv -i'
alias vi 'vim'

if not functions -q fisher
    set -q XDG_CONFIG_HOME; or set XDG_CONFIG_HOME ~/.config
    curl https://git.io/fisher --create-dirs -sLo $XDG_CONFIG_HOME/fish/functions/fisher.fish
    fish -c fisher
end

function pfd -d "Return the path of the frontmost Finder window"
  osascript 2>/dev/null -e '
    tell application "Finder"
      return POSIX path of (target of window 1 as alias)
    end tell'
end

function cdf -d "cd to the current Finder directory"
  cd (pfd)
end

function fssh -d "Fuzzy-find ssh host via rg and ssh into it"
  rg --ignore-case '^host [^*]' ~/.ssh/config ~/.ssh/conf.d/hosts/* | cut -d ' ' -f 2 | fzf -m --tac --cycle | xpanes --ssh
end

if test -f /opt/homebrew/opt/asdf/asdf.fish
  source /opt/homebrew/opt/asdf/asdf.fish
else 
  echo '/opt/homebrew/opt/asdf/asdf.fish not found'
end

