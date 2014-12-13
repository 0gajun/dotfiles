#!/bin/sh
#作業ディレクトリ作成
mkdir ~/tmp-dotfiles

#シンボリックリンク作成
ln -sf ~/dotfiles/.vimrc ~/.vimrc
#For vim
#neobundleのインストール
if [ ! -e ~/.vim/bundle ] ; then
curl https://raw.githubusercontent.com/Shougo/neobundle.vim/master/bin/install.sh | sh
fi
#Solarizedのインストール
if [ ! -e ~/.vim/colors/solarized/vim ] ; then
git clone https://github.com/altercation/vim-colors-solarized.git ~/tmp-dotfiles/vim-colors-solarized/
cp -r ~/tmp-dotfiles/vim-colors-solarized/* ~/.vim/
fi

#For zsh
#oh-my-zshのインストール
curl -L http://install.ohmyz.sh | sh

#作業ディレクトリの削除
rm -rf ~/tmp-dotfiles
