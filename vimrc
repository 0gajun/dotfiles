""""""""""""""""""""""""
"" python path for neovim
""""""""""""""""""""""""
let g:python_host_prog = expand("~/.anyenv/envs/pyenv/versions/neovim2/bin/python")
let g:python3_host_prog = expand("~/.anyenv/envs/pyenv/versions/neovim3/bin/python")

""""""""""""""""""""""""
""Plugins(vim-plug)
""""""""""""""""""""""""
if has('nvim')
  call plug#begin('~/.config/nvim/plugged')
else
  call plug#begin('~/.vim/plugged')
endif
Plug 'Shougo/vimproc.vim', { 'do': 'make' }
Plug 'Shougo/denite.nvim', { 'do': ':UpdateRemotePlugins' }
Plug 'Shougo/neomru.vim'
Plug 'itchyny/lightline.vim'
Plug 'tomtom/tcomment_vim'
Plug 'xolox/vim-misc' | Plug 'xolox/vim-session'
Plug 'kana/vim-submode'
Plug 'nathanaelkane/vim-indent-guides'
Plug 'tpope/vim-fugitive'
Plug 'tpope/vim-surround'
Plug 'thinca/vim-quickrun'
Plug 'Shougo/deoplete.nvim', { 'do': ':UpdateRemotePlugins' }
Plug 'rking/ag.vim'
Plug 'powerline/powerline'
Plug 'editorconfig/editorconfig-vim'
Plug 'scrooloose/nerdtree', { 'on':  'NERDTreeToggle' }
Plug 'SirVer/ultisnips'
Plug 'honza/vim-snippets'
Plug 'airblade/vim-gitgutter'
Plug 'jiangmiao/auto-pairs'
Plug 'w0rp/ale'

" Language specific plugins
"" Python
Plug 'hdima/python-syntax', { 'for': 'python' }
Plug 'hynek/vim-python-pep8-indent', { 'for': 'python' }
Plug 'davidhalter/jedi-vim', { 'for': 'python' }
"" C++
Plug 'octol/vim-cpp-enhanced-highlight', { 'for': 'cpp' }
Plug 'justmao945/vim-clang', { 'for': ['c', 'cpp'] }
"" Scala
Plug 'derekwyatt/vim-scala', { 'for': 'scala' }
"" Jinja
Plug 'Glench/Vim-Jinja2-Syntax', { 'for': 'jinja' }
"" Haskell
Plug 'kana/vim-filetype-haskell', { 'for': 'haskell' }
"" Go
Plug 'fatih/vim-go', { 'do': ':GoInstallBinaries', 'for': 'go', 'tag': '*' }
Plug 'zchee/deoplete-go', { 'do': 'make', 'for': 'go' }
"" cofee-script
Plug 'kchmck/vim-coffee-script', { 'for': 'cofee' }
"" Terraform
Plug 'hashivim/vim-terraform', { 'for': 'terraform' }
"" Rust
Plug 'rust-lang/rust.vim', { 'for': 'rust' }
Plug 'racer-rust/vim-racer', { 'for': 'rust' }
"" Haskell
Plug 'eagletmt/neco-ghc', { 'for': 'haskell'}
Plug 'dag/vim2hs', { 'for': 'haskell'}
"" Toml
Plug 'cespare/vim-toml', { 'for': 'toml' }

call plug#end()

syntax on

""""""""""
" ColorSchemeSetting
if has('mac')
  colorscheme solarized
else
  colorscheme molokai
endif

set background=dark

set number
set cursorline
set laststatus=2

set ts=2 sw=2 et
set autoindent
set cindent
set smarttab

set incsearch
set ignorecase
set hlsearch
set list
set listchars=tab:▸\ ,trail:-,eol:¬

:command Path echo expand("%:p")

"enable scrolling with mouse
set mouse=a
if !has('nvim')
  set ttymouse=xterm2
endif

"Keymap
nnoremap sj <C-w>j
nnoremap sk <C-w>k
nnoremap sl <C-w>l
nnoremap sh <C-w>h
nnoremap sn gt
nnoremap sp gT
nnoremap suf :<C-u>call DispatchUniteFileRecAsyncOrGit()<CR>
nnoremap sug :<C-u>Denite grep<CR>
nnoremap sub :<C-u>Denite buffer<CR>
nnoremap <C-]> g<C-]>
inoremap <silent> jk <ESC>
tnoremap <silent> jk <C-\><C-n>

set backspace=indent,eol,start

autocmd BufWritePre * :%s/\s\+$//ge

" For vimgrep
autocmd QuickFixCmdPost *grep* cwindow

"LightLine
set noshowmode
let g:lightline = {
  \ 'colorscheme': 'wombat',
  \ 'active': {
  \   'left': [ [ 'mode', 'paste' ],
  \             [ 'fugitive', 'filename'] ]
  \ },
  \ 'component_function': {
  \   'fugitive': 'FugitiveHeadBranch'
  \ },
  \ 'separator': {
  \     'left': "\ue0b0", 'right': "\ue0b2"
  \ },
  \ 'subseparator':{
  \     'left': "\ue0b1", 'right': "\ue0b3"
  \ }
  \}

function! FugitiveHeadBranch()
  if &ft !~? 'vimfiler\|gundo' && exists("*fugitive#head")
    let _ = fugitive#head()
    return strlen(_) ? "\ue0a0 "._ : ''
  endif
  return ''
endfunction

call denite#custom#alias('source', 'file_rec/git', 'file_rec')
call denite#custom#var('file_rec/git', 'command',
  \ ['git', 'ls-files', '-co', '--exclude-standard'])

function! DispatchUniteFileRecAsyncOrGit()
  if isdirectory(getcwd()."/.git")
    :Denite file_rec/git
  else
    :Denite file_rec
  endif
endfunction
" denite.nvim
call denite#custom#map('insert', "jk", '<denite:enter_mode:normal>', 'noremap')

"vim-session
" Get .vimsessions/ in current directory
let s:local_session_directory = xolox#misc#path#merge(getcwd(), '.vimsessions')
if isdirectory(s:local_session_directory)
  let g:session_directory = s:local_session_directory
  " Auto save when exiting
  let g:session_autosave = 'yes'
  " Auto load
  let g:session_autoload = 'yes'
  " Automatically save once a minute
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
let g:indent_guides_enable_on_vim_startup = 1
let g:indent_guides_guide_size = 1
let g:indent_guides_start_level = 2

" Deoplete.nvim
let g:deoplete#enable_at_startup = 1
let g:deoplete#enable_ignore_case = 1
let g:deoplete#enable_smart_case = 1
if !exists('g:deoplete#keyword_patterns')
  let g:deoplete#keyword_patterns = {}
endif
let g:deoplete#keyword_patterns._ = '\h\w*' " Ignore Japanese
inoremap <expr><TAB>  pumvisible() ? "\<C-n>" : "\<TAB>"

" jedi-vim
autocmd FileType python setlocal completeopt-=preview

"vim-go
let g:go_fmt_command = "goimports"
let g:go_highlight_functions = 1
let g:go_highlight_methods = 1
let g:go_highlight_fields = 1
let g:go_highlight_types = 1
let g:go_highlight_operators = 1
let g:go_highlight_build_constraints = 1
let g:go_metalinter_enabled = ['vet', 'golint', 'errcheck']
let g:go_metalinter_autosave = 1

if executable("opam")
  " merlin (For OCaml
  let g:opamshare = substitute(system('opam config var share'),'\n$','','''')
  execute "set rtp+=" . g:opamshare . "/merlin/vim"
  if !exists('g:neocomplete#sources#omni#input_patterns')
    let g:neocomplete#sources#omni#input_patterns = {}
  endif
  let g:neocomplete#sources#omni#input_patterns.ocaml = '[^. *\t]\.\w*\|\h\w*|#'

  " ocp-indent (For OCaml
  execute 'set rtp^=' . g:opamshare . '/ocp-indent/vim'
endif

" racer-rust/vim-racer
let g:racer_cmd = "~/.cargo/bin/racer"
au FileType rust nmap gd <Plug>(rust-def)
"" And please set $RUST_SRC_PATH as environment variable
let g:racer_experimental_completer = 1
"" rust-fmt
let g:rustfmt_autosave = 1

" ultisnips
let g:UltiSnipsExpandTrigger = "<tab>"
let g:UltiSnipsJumpForwardTrigger = "<c-b>"
let g:UltiSnipsJumpBackwardTrigger = "<c-z>"

" ale
let g:ale_sign_error = '⤫'
let g:ale_sign_warning = '⚠'
let g:ale_sign_column_always = 1
