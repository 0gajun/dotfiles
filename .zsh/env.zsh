# Theme
if [[ is_osx ]]; then
  ZSH_THEME="honukai"
else
  ZSH_THEME="agnoster"
fi

# History Settings
HISTFILE=~/.zsh_history
HISTSIZE=5000
SAVEHIST=50000

# For go
export GOPATH=$HOME/dev
export PATH=$PATH:$GOROOT:$GOPATH/bin

# For ghq
export GHQ_ROOT=$GOPATH/src

# For brew-file
if [ -f $(brew --prefix)/etc/brew-wrap ];then
  source $(brew --prefix)/etc/brew-wrap
fi
