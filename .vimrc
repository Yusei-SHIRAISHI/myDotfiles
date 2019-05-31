
map <Space> <Plug>(mykey)

filetype indent on
filetype plugin on
call plug#begin('~/.vim/plugged')
Plug 'scrooloose/nerdtree'
call plug#end()

set noswapfile
set number

nnoremap j gj
nnoremap k gk
nnoremap gj j
nnoremap gk k
nnoremap dt <C-d>
nmap <D-d> x

nmap <Esc><Esc> :nohlsearch<CR><Esc>

set expandtab
set tabstop=2
set shiftwidth=2

set ignorecase
set smartcase
set wrapscan
set hlsearch

"### complation {{{
set complete+=k
set completeopt=menuone
set infercase
set pumheight=10

"# keybind
inoremap <C-j> <C-x><C-n>
inoremap <C-k> <C-x><C-o>
inoremap <C-l> <C-x><C-k>
inoremap <C-_> <C-x><C-f>
inoremap <C-d> <Del>

inoremap <C-p> <Up>
inoremap <C-n> <Down>
inoremap <C-b> <Left>
inoremap <C-f> <Right>


for key in split("abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ_-$@",'\zs')
      exec printf("inoremap %s %s<Left><Right><C-x><C-n><C-p>", key, key)
endfor
inoremap ./ ./<C-x><C-f><C-p>
inoremap / /<C-x><C-f><C-p>
inoremap ~/ ~/<C-x><C-f><C-p>


"Nerdtree {{{

"# NERDTreeToggle wrapper
nnoremap <silent> <Plug>(mykey)n :call <SID>MY_NERDTreeToggle()<CR>
nnoremap <silent> <Plug>(mykey)i :call <SID>MY_NERDTreeRefresh()<CR>
let g:my_nerdtree_status=0

function! s:MY_NERDTreeRefresh()
  NERDTreeFocus
  normal R
  wincmd l
  let g:my_nerdtree_status = 1
endfunction

function! s:MY_NERDTreeToggle()
  :NERDTreeToggle
  if g:my_nerdtree_status == 0
    wincmd l
  endif
  let g:my_nerdtree_status = g:my_nerdtree_status ==# 1 ? 0 : 1
endfunction

let g:NERDTreeHijackNetrw=1
let g:NERDTreeWinSize=(&columns / 5)
"}}}
