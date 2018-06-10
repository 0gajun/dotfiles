# Theme
if [[ is_osx ]]; then
  ZSH_THEME="honukai"
else
  ZSH_THEME="agnoster"
fi

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

if [ -f $HOME/.anyenv/bin/anyenv ] ; then
  path+=$HOME/.anyenv/bin
  eval "$(anyenv init -)"
fi

if type "pyenv" > /dev/null ; then
  # pyenv-virtualenv
  eval "$(pyenv virtualenv-init -)"
fi

if [ -f ~/.fzf.zsh ]; then
  source ~/.fzf.zsh
fi
