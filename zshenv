# Don't put machine specific settings into this file.
# Please put them into ~/.zshenv.local

if [[ "$(uname)" == 'Darwin' ]]; then
  setopt no_global_rcs
  path=( \
    /bin \
    /sbin \
    /usr/sbin \
    /usr/bin \
    /usr/local/bin(N-/) \
    )
fi

# EDITOR
export EDITOR=nvim
export GIT_EDITOR="${EDITOR}"
export KUBE_EDITOR="${EDITOR}"

# For golang
export GOPATH="$HOME/dev"
export GOBIN="$GOPATH/bin"
export PATH="$GOBIN:$PATH"

# For rust
path+=( \
  $HOME/.cargo/bin(N-/) \
  )

# History
HISTFILE=~/.zsh_history
HISTSIZE=5000
SAVEHIST=50000

if [ -f ~/.zshenv.local ]; then
  source ~/.zshenv.local
fi
