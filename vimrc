set smartcase
set ignorecase
set nofoldenable
set expandtab
set softtabstop=4
set tabstop=4

" https://github.com/ntpeters/vim-better-whitespace
highlight ExtraWhitespace ctermbg=blue

" https://github.com/tpope/vim-markdown
let g:markdown_fenced_languages = ['html', 'python', 'bash=sh']

" spell checker always on when editing git commit message
autocmd FileType gitcommit setlocal spell

" jump to the position in file where we were last time before closing
if has("autocmd")
  au BufReadPost * if line("'\"") > 0 && line("'\"") <= line("$")
    \| exe "normal! g'\"" | endif
endif

" https://github.com/flazz/vim-colorschemes
colorscheme molokai
