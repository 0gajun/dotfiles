#!/bin/sh
TMP_DIR=~/tmp-dotfiles
DOTFILES_DIR=$(cd $(dirname $0);pwd)

#作業ディレクトリ作成
mkdir $TMP_DIR

#シンボリックリンク作成
ln -sf $DOTFILES_DIR/vimrc ~/.vimrc
ln -sf $DOTFILES_DIR/tmux.conf ~/.tmux.conf
ln -sf $DOTFILES_DIR/zshrc ~/.zshrc

#For vim
#neobundleのインストール
if [ ! -e ~/.vim/bundle ] ; then
curl https://raw.githubusercontent.com/Shougo/neobundle.vim/master/bin/install.sh | sh
fi
#Solarizedのインストール
if [ ! -e ~/.vim/colors/solarized/vim ] ; then
git clone https://github.com/altercation/vim-colors-solarized.git $TMP_DIR/vim-colors-solarized/
cp -r $TMP_DIR/vim-colors-solarized/* ~/.vim/
fi

#For zsh
#oh-my-zshのインストール
curl -L http://install.ohmyz.sh | sh

# install zsh-theme
cp $DOTFILES_DIR/zsh-theme/honukai.zsh-theme ~/.oh-my-zsh/themes/

#作業ディレクトリの削除
rm -rf $TMP_DIR
