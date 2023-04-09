"plugin
syntax on filetype plugin indent on

call plug#begin('~/.vim/plugged')
  "lsp
  Plug 'prabirshrestha/vim-lsp'
  Plug 'mattn/vim-lsp-settings'
  Plug 'prabirshrestha/asyncomplete.vim'
  Plug 'prabirshrestha/asyncomplete-lsp.vim'
  Plug 'mattn/vim-lsp-icons'
  Plug 'hrsh7th/vim-vsnip'

  Plug 'vim-jp/vimdoc-ja'
  Plug 'itchyny/lightline.vim'
  Plug 'nanotech/jellybeans.vim'
  Plug 'cohama/lexima.vim'
  Plug 'scrooloose/nerdtree', { 'as': 'nerdtree' }
  Plug 'junegunn/fzf', { 'do': { -> fzf#install() } }
  Plug 'junegunn/fzf.vim'
  Plug 'tpope/vim-fugitive'
call plug#end()

"normal
noremap <ESC> <C-\>
nnoremap j gj
nnoremap k gk
nnoremap gj j
nnoremap gk k
nnoremap J <C-e>
nnoremap K <C-y>
nnoremap <C-n> :NERDTreeToggle<CR>
nnoremap <C-e> $
nnoremap <C-a> ^
nnoremap <C-i> :LspDefinition<CR>
nnoremap <C-k> :Buffers<CR>
nnoremap <C-l><C-l> :LspDocumentFormat<CR>
nnoremap f :LspHover<CR>
nnoremap F :LspReferences<CR>
"検索結果ハイライト解除
nnoremap <ESC><ESC> :nohlsearch<CR>
"# buffer next/preview
nnoremap <silent> <Up> :bnext<CR>
nnoremap <silent> <Down> :bprevious<CR>
"# tab next/previous
nnoremap <silent> <Right> :tabnext<CR>
nnoremap <silent> <Left> :tabprevious<CR>
" recording off
nnoremap q <Nop>
nnoremap q: <Nop>
" save off
nnoremap ZZ <Nop>
nnoremap ZQ <Nop>
" ex mode off
nnoremap Q <Nop>

"insert
inoremap <C-d> <Del>
inoremap <C-k> <Up>
inoremap <C-j> <Down>
inoremap <C-b> <Left>
inoremap <C-f> <Right>

"visual
vnoremap J <C-e>
vnoremap K <C-y>
vnoremap <C-e> $
vnoremap <C-a> ^
"sneak_case to pascal case
vnoremap <C-u> :substitute/\v(<\|_)(.)/\u\2/ge<CR>
"pascal case to sneak_case
vnoremap <C-y> :substitute/\v([a-z]\@=)([A-Z])/\1_\2/ge<CR>:*substitute/\v(\u)/\l\1/ge<CR>

"command
cnoremap <C-p> <C-r>"
cnoremap <C-f> <Right>
cnoremap <C-b> <Left>

"terminal
tnoremap <C-p> <C-w>""

"alias
command Sjis edit ++enc=cp932
command Utf8 edit ++enc=utf-8
command CC set cursorcolumn!

set encoding=utf-8
set fileencodings=utf-8,iso-2022-jp,euc-jp,sjis
set helplang=ja,en

packadd termdebug
let g:termdebugger = 'rust-gdb'

"# ESCの遅延防止
if has('unix') && !has('gui_running')
    inoremap <silent> <ESC> <ESC>
    inoremap <silent> <C-[> <ESC>
endif

"title表示
set laststatus=2
set title
set showmode
"tab表示
set showtabline=2
"行数表示
set number
"操作行に色付け
set cursorline
" swpファイル出力先
silent !mkdir ~/.vim/swp -p >/dev/null 2>&1
set directory=~/.vim/swp/
" undo 永続化
silent !mkdir ~/.vim/undo -p >/dev/null 2>&1
if has('persistent_undo')
  set undodir=~/.vim/undo
  set undofile
endif
"括弧入力時に対応する括弧を表示
set showmatch

set showcmd

"ビープ音消去
set visualbell t_vb=
set noerrorbells

"大文字小文字を区別しない
set ignorecase
set smartcase

" バックスペースでインデントや改行を削除できるようにする
set backspace=indent,eol,start

set ambiwidth=double

set wildmenu
set wildmode=longest,full

"検索など
"検索時大文字小文字を区別する
set smartcase
" 検索がファイル末尾まで進んだら、ファイル先頭から再び検索する。
set wrapscan
" 前回の検索パターンが存在するとき、それにマッチするテキストを全て強調表示する。
set hlsearch
set incsearch

"clipboard
set clipboard+=unnamed

"TODO format設定
set ruler

"リスト表示最大数
set pumheight=10
"補完時大文字小文字のなんやかんや
set infercase

"default indent
set tabstop=2
set expandtab
set shiftwidth=2
set autoindent
set smartindent

syntax on

"colorscheme
colorscheme jellybeans

highlight Visual ctermbg=darkgrey

"全角スペース強調
highlight FullWidthSpace
  \ cterm=underline
  \ ctermfg=199
  \ gui=underline
  \ guifg=WHITE
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
  autocmd VimEnter,WinEnter * match EndSpace /\s\+$/
augroup END

highlight Normal ctermbg=none
highlight NonText ctermbg=none
highlight LineNr ctermbg=none
highlight Folded ctermbg=none
highlight EndOfBuffer ctermbg=none

"LSP setting
let g:asyncomplete_auto_popup = 0
let g:lsp_log_verbose = 1  " デバッグ用ログを出力
let g:lsp_log_file = expand('~/.cache/tmp/vim-lsp.log')  " ログ出力のPATHを設定
let g:lsp_diagnostics_enabled = 1                        " Diagnosticsを有効にする
let g:lsp_diagnostics_echo_cursor = 1                    " カーソル下のエラー、警告、情報、ヒントを画面下部のコマンドラインに表示
let g:lsp_diagnostics_echo_delay = 50                    " Diagnosticsの表示の遅延を50msに設定
let g:lsp_diagnostics_float_cursor = 0                   " カーソル下のエラー、警告、情報、ヒントをフロート表示
let g:lsp_diagnostics_signs_enabled = 0                  " 画面左端のサイン列にエラー、警告、情報、ヒントのアイコンを非表示
let g:lsp_diagnostics_signs_insert_mode_enabled = 0      " 挿入モード時、Diagnosticsのサイン列を表示しない
let g:lsp_diagnostics_highlights_delay = 50              " Diagnosticsの指摘箇所自体の文字ハイライト表示の遅延を50msに設定
let g:lsp_diagnostics_highlights_insert_mode_enabled = 0 " 挿入モード時、Diagnosticsの指摘箇所自体の文字ハイライトを表示しない
let g:lsp_document_code_action_signs_enabled = 0         " 画面左端のサイン列にコードアクションのアイコン非表示
let g:lsp_document_highlight_enabled = 1                 " カーソル移動時にハイライトをon
highlight lspReference ctermfg=darkcyan guifg=darkcyan

let g:lsp_settings_filetype_ruby = 'solargraph'
let g:lsp_settings_filetype_rust = 'rust-analyzer'
