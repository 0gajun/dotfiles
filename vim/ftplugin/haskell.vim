setlocal tabstop=4
setlocal softtabstop=4
setlocal shiftwidth=4

" Disable haskell-vim omnifunc
let g:haskellmode_completion_ghc = 0
autocmd FileType haskell setlocal omnifunc=necoghc#omnifunc
