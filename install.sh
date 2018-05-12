#!/bin/sh
TMP_DIR=~/tmp-dotfiles
DOTFILES_DIR=$(cd "$(dirname "$0")";pwd)
PYTHON2_VERSION=2.7.13
PYTHON3_VERSION=3.5.2

# when error occurs, stop task
set -e

## Detect platform
platform='unknown'
unamestr=$(uname)
case "$unamestr" in
  Darwin*) platform='OSX' ;;
  Linux*) platform='linux' ;;
esac

if [ ! "$(which zsh)" ] ; then
  echo "Please install zsh before this installation"
  exit 1
fi

# create working directory
mkdir $TMP_DIR

if [ ! -e ~/.config ] ; then
  mkdir ~/.config
fi

#############################
## For Xmonad
if [ "$(which xmonad)" ] ; then
  if [ ! -e ~/.xmonad ] ; then
    mkdir ~/.xmonad
  fi
  ln -sf $DOTFILES_DIR/xmonad/* ~/.xmonad/
fi

#############################
## For tmux
# Install tmux plugin manager
if [ ! -e ~/.tmux/plugins/tpm ] ; then
  git clone https://github.com/tmux-plugins/tpm ~/.tmux/plugins/tpm
else
  echo "tpm is already installed"
fi

ln -sf "$DOTFILES_DIR/tmux.conf" ~/.tmux.conf


#############################
## For vim
VIM_ROOT=$HOME/.vim/
NVIM_ROOT=$HOME/.config/nvim/

for root in "$VIM_ROOT" "$NVIM_ROOT"
do
  echo "Installing vim configuration into $root"
  if [ ! -e "$root" ]; then
    mkdir "$root"
  fi

  ln -sf "$DOTFILES_DIR/vim/filetype.vim" "$root/filetype.vim"
  if [ ! -e "$root/ftplugin" ]; then
    ln -sf "$DOTFILES_DIR/vim/ftplugin" "$root/ftplugin"
  fi

  # install vim-plug
  if [ ! -e "$root/autoload/plug.vim" ] ; then
    curl -fLo "$root/autoload/plug.vim" --create-dirs \
          https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
  else
    echo "vim-plug is already installed"
  fi

  # install Solarized color scheme for vim
  if [ ! -e "$root/colors/solarized.vim" ] ; then
    echo "Install solalized color scheme"
    if [ ! -e $TMP_DIR/vim-colors-solarized/ ]; then
      git clone https://github.com/altercation/vim-colors-solarized.git $TMP_DIR/vim-colors-solarized/
    fi
    cp -r $TMP_DIR/vim-colors-solarized/* "$root"
  else
    echo "Solarized is already installed"
  fi

  # install molokai color scheme for vim
  if [ ! -e "$root/colors/molokai.vim" ] ; then
    echo "Install molokai color scheme"
    if [ ! -e $TMP_DIR/molokai/ ]; then
      git clone https://github.com/Oga-Jun/molokai.git $TMP_DIR/molokai/
    fi
    cp $TMP_DIR/molokai/colors/molokai.vim "$root/colors/molokai.vim"
  else
    echo "Molokai color scheme is already installed"
  fi
done

ln -sf "$DOTFILES_DIR/vimrc" ~/.vimrc
ln -sf "$DOTFILES_DIR/vimrc" "$NVIM_ROOT/init.vim"


#############################
## For zsh
if [ ! -e ~/.zplug ]; then
  echo 'Installing zplug...'
  git clone https://github.com/zplug/zplug "$HOME/.zplug"
fi

if [ ! -e ~/.zshrc ]; then
  ln -s "$DOTFILES_DIR/zshrc" ~/.zshrc
fi
if [ ! -e ~/.zshenv ]; then
  ln -s "$DOTFILES_DIR/.zshenv" ~/.zshenv
fi
if [ ! -e ~/.zsh ]; then
  ln -s "$DOTFILES_DIR/.zsh" ~/.zsh
fi

#############################
## Create machine specific zsh setting file
if [ ! -e ~/.zshenv.local ] ; then
  touch ~/.zshenv.local
fi

#############################
## anyenv
if [ ! -e ~/.anyenv ] ; then
  echo 'Installing anyenv'
  git clone https://github.com/riywo/anyenv ~/.anyenv
  {
    # shellcheck disable=SC2016
    echo 'export PATH="$HOME/.anyenv/bin:$PATH"'
    # shellcheck disable=SC2016
    echo 'eval "$(anyenv init -)"'
  } >> ~/.zshenv
  echo "*** Please restart your shell due to anyenv's installation.***"
  echo "After that, please re-run this script"
  echo '** remove working directory'
  rm -rf $TMP_DIR
  exit 0
fi


#############################
## pyenv
PYENV_ROOT=~/.anyenv/envs/pyenv
if [ ! -e $PYENV_ROOT ] ; then
  echo 'Installing pyenv'
  anyenv install pyenv
fi
# pyenv-virtualenv
PYENV_VIRTUALENV_ROOT=$PYENV_ROOT/plugins/pyenv-virtualenv
if [ ! -e $PYENV_VIRTUALENV_ROOT ]; then
  echo 'Installing pyenv-virtualenv'
  git clone https://github.com/yyuu/pyenv-virtualenv.git $PYENV_VIRTUALENV_ROOT

  {
    echo ''
    echo '# pyenv-virtualenv'
    # shellcheck disable=SC2016
    echo 'eval "$(pyenv virtualenv-init -)"'
  } >> ~/.zshenv

  echo "*** Please restart your shell due to pyenv-virtualenv's installation.***"
  echo "After that, please re-run this script"
  echo '** remove working directory'
  rm -rf $TMP_DIR
  exit 0
fi

# install python for neovim
PYENV_VENV_NEOVIM2=$PYENV_ROOT/versions/neovim2
PYENV_VENV_NEOVIM3=$PYENV_ROOT/versions/neovim3
if [ ! -e $PYENV_VENV_NEOVIM2 ]; then
  pyenv install -s $PYTHON2_VERSION # Skip installation if the version already exists.
  echo ">>> Please install neovim extension of python2. Execute following commands"
  echo ""
  echo "pyenv virtualenv $PYTHON2_VERSION neovim2 && pyenv activate neovim2 && pip install neovim && pyenv deactivate neovim2"
  echo ""
  echo "<<<"
fi

if [ ! -e $PYENV_VENV_NEOVIM3 ]; then
  pyenv install -s $PYTHON3_VERSION # Skip installation if the version already exists.
  echo ">>> Please install neovim extension of python3. Execute following commands"
  echo ""
  echo "pyenv virtualenv $PYTHON3_VERSION neovim3 && pyenv activate neovim3 && pip install neovim && pyenv deactivate neovim3"
  echo ""
  echo "<<<"
fi


#############################
## peco
if [ ! -e ~/.config/peco ] ; then
  ln -sf "$DOTFILES_DIR/peco" ~/.config/peco
fi


#############################
## VS Code
if [ $platform = 'OSX' ] ; then
  mkdir -p ~/Library/Application\ Support/Code/User/
  ln -sf "$DOTFILES_DIR/vscode/settings.json" ~/Library/Application\ Support/Code/User/settings.json
elif [ $platform = 'linux' ] ; then
  mkdir -p ~/.config/Code/User/
  ln -sf "$DOTFILES_DIR/vscode/settings.json" ~/.config/Code/User/settings.json
fi

#############################
## Copy .gitconfig template if not exist
if [ ! -e "$HOME/.gitconfig" ]; then
  cp -n "$DOTFILES_DIR/.gitconfig" "$HOME/.gitconfig"
fi


#############################
## Link Brewfile
if [ $platform = 'OSX' ] ; then
  mkdir -p ~/.config/brewfile
  ln -sf "$DOTFILES_DIR/homebrew/Brewfile" ~/.config/brewfile/Brewfile
fi


echo 'remove working directory'
rm -rf $TMP_DIR

echo "Finished!"
