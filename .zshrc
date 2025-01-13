export LANG=ja_JP.UTF-8
export LC_ALL=ja_JP.UTF-8
export PATH="$HOME/.local/share/mise/shims:$PATH"
if type colima > /dev/null 2>&1; then
  export DOCKER_HOST="unix://${HOME}/.colima/default/docker.sock"
fi



