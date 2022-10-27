alias tmux 'tmux -2 -u'
alias .. 'cd ..'
alias ... 'cd ../..'
alias .... 'cd ../../..'
alias ..... 'cd ../../../..'
alias ..... 'cd ../../../../..'
alias l 'ls -la'
alias ll 'ls -la'
alias cp 'cp -i'
alias rm 'rm -i'
alias mv 'mv -i'
alias vi 'nvim'

set -g fish_greeting
set -x TERM xterm-256color
set -x LANG ja_JP.UTF-8
set -x EDITOR vi
set -x FZF_TMUX 0

if type -q zoxide
  zoxide init fish | source
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
