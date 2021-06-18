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

" https://stackoverflow.com/a/38258720
" do not indent when pasting code
let &t_SI .= "\<Esc>[?2004h"
let &t_EI .= "\<Esc>[?2004l"
inoremap <special> <expr> <Esc>[200~ XTermPasteBegin()
function! XTermPasteBegin()
  set pastetoggle=<Esc>[201~
  set paste
  return ""
endfunction
