"plugin
syntax on filetype plugin indent on
call plug#begin('~/.vim/plugged')
Plug 'dracula/vim', { 'as': 'dracula' }
Plug 'scrooloose/nerdtree', { 'as': 'nerdtree' }
call plug#end()

"keybind
"normal
nnoremap j gj
nnoremap k gk
nnoremap gj j
nnoremap gk k
nnoremap J <C-e>
nnoremap K <C-y>
nnoremap <C-e> $
nnoremap <C-a> ^
nnoremap <C-f> l
nnoremap <C-b> h
nnoremap <silent> <C-y> :call StartReflex()<Enter>
"insert
inoremap <C-d> <Del>
inoremap <C-p> <Up>
inoremap <C-n> <Down>
inoremap <C-b> <Left>
inoremap <C-f> <Right>
"visual
vnoremap <C-e> $
vnoremap <C-a> ^
"command
cnoremap <C-p> <C-r>"
cnoremap <C-c> <C-u>set filetype=
cnoremap <C-f> <Right>
cnoremap <C-b> <Left>
cnoremap <silent> <C-s> <C-u>terminal<Enter>

"title表示
set laststatus=2
set title
"行数表示
set number
"操作行に色付け
set cursorline
"一時ファイルを生成しない
set noswapfile
"括弧入力時に対応する括弧を表示
set showmatch

"ビープ音消去
set visualbell t_vb=
set noerrorbells

"大文字小文字を区別しない
set ignorecase

" バックスペースでインデントや改行を削除できるようにする
set backspace=indent,eol,start

"検索など
"検索結果ハイライト
nnoremap <ESC><ESC> :nohlsearch<CR>
"検索時大文字小文字を区別する
set smartcase
" 検索がファイル末尾まで進んだら、ファイル先頭から再び検索する。
set wrapscan
" 前回の検索パターンが存在するとき、それにマッチするテキストを全て強調表示する。
set hlsearch

"TODO format設定
set ruler

"clipboard
set clipboard=unnamed

"補完機能
set completeopt=menuone
for key in split("abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ_-$@",'\zs')
	exec printf("inoremap %s %s<Left><Right><C-x><C-n><C-p>", key, key)
endfor
"path 補完
inoremap ./ ./<C-x><C-f><C-p>
inoremap / /<C-x><C-f><C-p>
inoremap ~/ ~/<C-x><C-f><C-p>
"リスト表示最大数
set pumheight=10
"補完時大文字小文字のなんやかんや
set infercase

"tabをスペースにする
set expandtab

"
syntax on

"default
autocmd!
autocmd FileType ruby setlocal tabstop=2 shiftwidth=2

"ファイル別設定
"c,c++
augroup c_cpp_setting
        autocmd!
        autocmd FileType c,cpp setlocal tabstop=2 shiftwidth=2
augroup END

"ruby
augroup ruby_setting
        autocmd!
        autocmd FileType ruby setlocal tabstop=2 shiftwidth=2
augroup END

"colorscheme
colorscheme dracula

"全角スペース強調
highlight FullWidthSpace
	\ cterm=underline
	\ ctermfg=LightGreen
	\ gui=underline
	\ guifg=LightGreen
augroup FullWidthSpace
	autocmd!
	autocmd VimEnter,WinEnter * call matchadd("FullWidthSpace", "　")
augroup END

"末尾スペース可視化
highlight EndSpace
	\ ctermbg=199
	\ guibg=Cyan
augroup EndSpace
	autocmd!
"	autocmd VimEnter,WinEnter * call matchadd("EndSpace", "\s\+$")
	autocmd VimEnter,WinEnter * match EndSpace /\s\+$/
augroup END

"tag jump
set tags=.tags
let g:reflex_job = 0
function! StartReflex()
	!ctags -R -f .tags
	let reflex_job = job_start(["reflex", "-r", "/*", "ctags", "-R", "-f"])
endfunction
function! EndReflex()
	call job_stop(reflex_job)
endfunction
augroup CloseReflex
	autocmd!
        autocmd VimLeave * call EndReflex()
augroup END

"NERD TREE
map <C-n> :NERDTreeToggle<CR>
augroup NERDTree
	autocmd!
        autocmd bufenter * if (winnr("$") == 1 && exists("b:NERDTree") && b:NERDTree.isTabTree()) | q | endif
augroup END
