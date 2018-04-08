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
if [ -f $(brew --prefix)/etc/brew-wrap ]; then
  source $(brew --prefix)/etc/brew-wrap
fi

if type "direnv" > /dev/null ; then
  eval "$(direnv hook zsh)"
fi

if type "opam" > /dev/null ; then
  eval `opam config env`
fi

if type "pyenv" > /dev/null ; then
  eval "$(pyenv virtualenv-init -)"
fi


[ -f ~/.fzf.zsh ] && source ~/.fzf.zsh
