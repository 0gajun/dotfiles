#!/bin/sh
TMP_DIR=~/tmp-dotfiles
DOTFILES_DIR=$(cd $(dirname $0);pwd)

# when error occurs, stop task
set -e

# Detect platform
platform='unknown'
unamestr=`uname`
case "$unamestr" in
  Darwin*) platform='OSX' ;;
  Linux*) platform='linux' ;;
esac

if [ ! `which zsh` ] ; then
  echo "Please install zsh before this installation"
  exit 1
fi

# create working directory
mkdir $TMP_DIR

# install xmonad's configuration
if [ `which xmonad` ] ; then
  if [ ! -e ~/.xmonad ] ; then
    mkdir ~/.xmonad
  fi
  ln -sf $DOTFILES_DIR/xmonad/* ~/.xmonad/
fi

# For tmux
# Install tmux plugin manager
if [ ! -e ~/.tmux/plugins/tpm ] ; then
  git clone https://github.com/tmux-plugins/tpm ~/.tmux/plugins/tpm
else
  echo "tpm is already installed"
fi

# For vim
# install vim-plug
if [ ! -e ~/.vim/autoload/plug.vim ] ; then
  curl -fLo ~/.vim/autoload/plug.vim --create-dirs \
        https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
else
  echo "vim-plug is already installed"
fi

# install Solarized color scheme for vim
if [ ! -e ~/.vim/colors/solarized.vim ] ; then
  echo "Install solalized color scheme"
  git clone https://github.com/altercation/vim-colors-solarized.git $TMP_DIR/vim-colors-solarized/
  cp -r $TMP_DIR/vim-colors-solarized/* ~/.vim/
else
  echo "Solarized is already installed"
fi

# install molokai color scheme for vim
if [ ! -e ~/.vim/colors/molokai.vim ] ; then
  echo "Install molokai color scheme"
  git clone https://github.com/Oga-Jun/molokai.git $TMP_DIR/molokai/
  cp $TMP_DIR/molokai/colors/molokai.vim ~/.vim/colors/molokai.vim
else
  echo "Molokai color scheme is already installed"
fi

#For zsh
echo 'install oh-my-zsh'
if [ ! -e ~/.oh-my-zsh ] ; then
  curl -L http://install.ohmyz.sh | sh || true
else
  echo "oh-my-zsh is already installed"
fi

# PATH problem workaround for OSX El Capitan.
if [ ! -e ~/.zshenv ] ; then
  touch ~/.zshenv
fi

if [ $platform = 'OSX' ] ; then
  # Checking whether zshenv is patched or not
  matched_line=`grep -c no_global_rcs ~/.zshenv` || true
  if [ $matched_line -eq 0 ] ; then
    echo "Patching zsh workaround for OSX El Capitan"
    TMP_ZSHENV=$TMP_DIR/zshenv
    cat ./osx/workaround_loading_path_in_el_capitan ~/.zshenv > $TMP_ZSHENV
    mv $TMP_ZSHENV ~/.zshenv
    rm $TMP_ZSHENV
  fi
fi

echo 'install zsh-theme'
cp $DOTFILES_DIR/zsh-theme/honukai.zsh-theme ~/.oh-my-zsh/themes/

echo 'install anyenv'
if [ ! -e ~/.anyenv ] ; then
  git clone https://github.com/riywo/anyenv ~/.anyenv
  echo 'export PATH="$HOME/.anyenv/bin:$PATH"' >> ~/.zshenv
  echo 'eval "$(anyenv init -)"' >> ~/.zshenv
  echo "*** Please restart your shell due to anyenv's installation.***"
fi

echo 'create symlinks'
ln -sf $DOTFILES_DIR/vimrc ~/.vimrc
ln -sf $DOTFILES_DIR/tmux.conf ~/.tmux.conf
ln -sf $DOTFILES_DIR/zshrc ~/.zshrc
ln -sf $DOTFILES_DIR/vim/filetype.vim ~/.vim/filetype.vim
if [ ! -e $DOTFILES_DIR/vim/ftplugin ]; then
  ln -sf $DOTFILES_DIR/vim/ftplugin ~/.vim/ftplugin
fi

if [ ! -e ~/.config ] ; then
  mkdir ~/.config
fi
if [ ! -e ~/.config/peco ] ; then
  ln -sf $DOTFILES_DIR/peco ~/.config/peco
fi

echo 'remove working directory'
rm -rf $TMP_DIR

echo "Finished!"
