#!/bin/sh
TMP_DIR=~/tmp-dotfiles
DOTFILES_DIR=$(cd $(dirname $0);pwd)

# when error occurs, stop task
set -e

# create working directory
mkdir $TMP_DIR

# create symlinks
ln -sf $DOTFILES_DIR/vimrc ~/.vimrc
ln -sf $DOTFILES_DIR/tmux.conf ~/.tmux.conf
ln -sf $DOTFILES_DIR/zshrc ~/.zshrc

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

#For zsh
# install oh-my-zsh
if [ ! -e ~/.oh-my-zsh ] ; then
  curl -L http://install.ohmyz.sh | sh
else
  echo "oh-my-zsh is already installed"
fi

# install zsh-theme
cp $DOTFILES_DIR/zsh-theme/honukai.zsh-theme ~/.oh-my-zsh/themes/

# remove working directory
rm -rf $TMP_DIR

echo "Finished!"
