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

# create working directory
mkdir $TMP_DIR

# install xmonad's configuration
if [ `which xmonad` ] ; then
  if [ ! -e ~/.xmonad ] ; then
    mkdir ~/.xmonad
  fi
  ln -sf $DOTFILES_DIR/xmonad/* ~/.xmonad/
fi

# For vim
# install neobundle
if [ ! -e ~/.vim/bundle ] ; then
curl https://raw.githubusercontent.com/Shougo/neobundle.vim/master/bin/install.sh | sh
else
  echo "neobundle is already installed"
fi

# install Solarized color scheme for vim
if [ ! -e ~/.vim/colors/solarized.vim ] ; then
  git clone https://github.com/altercation/vim-colors-solarized.git $TMP_DIR/vim-colors-solarized/
  cp -r $TMP_DIR/vim-colors-solarized/* ~/.vim/
else
  echo "Solarized is already installed"
fi

# install molokai color scheme for vim
if [ ! -e ~/.vim/colors/molokai.vim ] ; then
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
  echo "*** Please restart your shell because of anyenv's installation.***"
fi

echo 'create symlinks'
ln -sf $DOTFILES_DIR/vimrc ~/.vimrc
ln -sf $DOTFILES_DIR/tmux.conf ~/.tmux.conf
ln -sf $DOTFILES_DIR/zshrc ~/.zshrc

if [ ! -e ~/.config ] ; then
  mkdir ~/.config
fi
ln -sf $DOTFILES_DIR/peco ~/.config/peco

echo 'remove working directory'
rm -rf $TMP_DIR

echo "Finished!"
