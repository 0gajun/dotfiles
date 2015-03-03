""""""""""""""""""""""""
""Plugins(NeoBundle)
""""""""""""""""""""""""
filetype off
if has('vim_starting')
	set nocompatible
	set runtimepath+=~/.vim/bundle/neobundle.vim/
endif

call neobundle#begin(expand('~/.vim/bundle/'))

NeoBundleFetch 'Shougo/neobundle.vim'
NeoBundleFetch 'Shougo/vimproc'
NeoBundle 'Shougo/unite.vim'
NeoBundle 'itchyny/lightline.vim'
NeoBundle 'tomtom/tcomment_vim'
NeoBundle 'xolox/vim-session', {
            \ 'depends' : 'xolox/vim-misc',
          \ }
NeoBundle 'kana/vim-submode'
NeoBundle 'nathanaelkane/vim-indent-guides'
NeoBundle 'scrooloose/syntastic.git'

call neobundle#end()

filetype plugin indent on
NeoBundleCheck

""""""""""
""Plugins(NeoBundle end)
""""""""""

syntax on
syntax enable
colorscheme solarized

set background=dark

set number
set cursorline
set laststatus=2

set ts=4 sw=4 et
set autoindent
set cindent 
set smarttab

set incsearch
set ignorecase
set hlsearch

"enable scrolling with mouse
set mouse=a
set ttymouse=xterm2

"Keymap
nnoremap sj <C-w>j
nnoremap sk <C-w>k
nnoremap sl <C-w>l
nnoremap sh <C-w>h
nnoremap sn gt
nnoremap sp gT
nnoremap uf :<C-u>Unite file<CR>
nnoremap ub :<C-u>Unite buffer<CR>
inoremap <silent> jk <ESC>

"LightLine
let g:lightline = {
	\	'colorscheme': 'wombat',
	\}

"vim-session
" 現在のディレクトリ直下の .vimsessions/ を取得 
let s:local_session_directory = xolox#misc#path#merge(getcwd(), '.vimsessions')
" 存在すれば
if isdirectory(s:local_session_directory)
  " session保存ディレクトリをそのディレクトリの設定
  let g:session_directory = s:local_session_directory
  " vimを辞める時に自動保存
  let g:session_autosave = 'yes'
  " 引数なしでvimを起動した時にsession保存ディレクトリのdefault.vimを開く
  let g:session_autoload = 'yes'
  " 1分間に1回自動保存
  let g:session_autosave_periodic = 1
else
  let g:session_autosave = 'no'
  let g:session_autoload = 'no'
endif
unlet s:local_session_directory

"submode
call submode#enter_with('winsize', 'n', '', 's>', '<C-w>>')
call submode#enter_with('winsize', 'n', '', 's<', '<C-w><')
call submode#map('winsize', 'n', '', '>', '<C-w>>')
call submode#map('winsize', 'n', '', '<', '<C-w><')

"vim-indent-guides
let g:indent_guides_enable_on_vim_startup=1
let g:indent_guides_guide_size=1
let g:indent_guides_start_level=2

"syntastic
let g:syntastic_mode_map = { 'mode': 'passive',
            \ 'active_filetypes': ['c', 'python'] }
