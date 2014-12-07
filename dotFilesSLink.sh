#!/bin/sh
#作業ディレクトリ作成
mkdir ~/tmp

#シンボリックリンク作成
ln -sf ~/dotfiles/.vimrc ~/.vimrc
#For vim
#neobundleのインストール
curl https://raw.githubusercontent.com/Shougo/neobundle.vim/master/bin/install.sh | sh
#Solarizedのインストール
git clone https://github.com/altercation/vim-colors-solarized.git ~/tmp
cp ~/tmp/vim-colors-solarized/* ~/.vim/


#作業ディレクトリの削除
rm -rf ~/tmp
