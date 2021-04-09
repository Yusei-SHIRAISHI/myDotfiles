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

  Plug 'mattn/emmet-vim'
  Plug 'scrooloose/nerdtree', { 'as': 'nerdtree' }
  Plug 'junegunn/fzf', { 'do': { -> fzf#install() } }
  Plug 'junegunn/fzf.vim'
call plug#end()

command! -nargs=0 SL :source %

"normal
noremap <ESC> <C-\>
nnoremap j gj
nnoremap k gk
nnoremap gj j
nnoremap gk k
nnoremap J <C-e>
nnoremap K <C-y>
nnoremap <C-e> $
nnoremap <C-a> ^
nnoremap <C-i> :LspPeekDefinition<CR>
nnoremap <silent> <C-u> :call StartReflex()<CR>
nnoremap <C-y> :Files<CR>
nnoremap <C-f> :Rg<CR>
nnoremap <C-k> :Buffers<CR>
nnoremap <C-d> :GFOpenDiff<CR>
nnoremap <C-x> :set paste<CR>
nnoremap <C-z> :set paste!<CR>
" recording off
nnoremap q <Nop>
nnoremap q: <Nop>

"検索結果ハイライト解除
nnoremap <ESC><ESC> :nohlsearch<CR>

"# buffer next/preview
nnoremap <silent> <Up> :bnext<CR>
nnoremap <silent> <Down> :bprevious<CR>
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
cnoremap <C-l> :Filetypes<Enter>
cnoremap <C-f> <Right>
cnoremap <C-b> <Left>
cnoremap <silent> <C-s> <C-u>terminal<Enter>

"# ESCの遅延防止
if has('unix') && !has('gui_running')
    inoremap <silent> <ESC> <ESC>
    inoremap <silent> <C-[> <ESC>
endif

set foldmethod=marker
set foldtext=FoldCCtext()

"title表示
set laststatus=2
set title
set showmode
set statusline=%t%y%=%m%r
"行数表示
set number
"操作行に色付け
set cursorline
"一時ファイルを生成しない
set noswapfile
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
set clipboard=unnamed

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

syntax on

"colorscheme
colorscheme murphy

highlight StatusLine
						\ term=bold
						\ ctermfg=16
						\ ctermbg=252
						\ guifg=#000000
						\ guibg=#dddddd

"全角スペース強調
highlight FullWidthSpace
	\ cterm=underline
	\ ctermfg=WHITE
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

function! GBranchList(A,L,P)
  return fzf#run(fzf#wrap({'source': 'git branch -a | sed -e "s/ //g" -e "s/remotes\///g" -e "s/\*//g"'}))
endfunction

function! GCurrentBranch()
  if !exists("g:current_branch")
    let g:current_branch = trim(system("git branch --show-current"))
  endif
  return g:current_branch
endfunction

command -nargs=? -bang -complete=customlist,GBranchList GFOpenDiff call GDiffFOpenFunc(<q-args>)
function! GDiffFOpenFunc(branch)
  let branch = a:branch == '' ? GCurrentBranch() : a:branch

  let diff_file_name_cmd = 'git diff ' . branch . ' --name-only'
  let file_path          = fzf#run(fzf#wrap({'source': diff_file_name_cmd}))[0]

  execute "edit " . file_path
endfunction

let g:diff_tmp_file_prefix = "vimdifftmp"
command -nargs=? -bang -complete=customlist,GBranchList GDiff call GDiffFunc(<q-args>)
function! GDiffFunc(branch)
  let g:is_created_diff_file = 1
  let branch = a:branch == '' ? GCurrentBranch() : a:branch

  let diff_file_name_cmd = 'git diff ' . branch . ' --name-only'
  let file_path          = fzf#run(fzf#wrap({'source': diff_file_name_cmd}))[0]

  let diff_id_cmd = 'git diff-index ' . branch . ' ' . file_path . " | awk '{print $3}'"
  let buff_index  = trim(system(diff_id_cmd))

  let file_base_name = fnamemodify(file_path, ':t')
  let tmp_file_path  = '/tmp/' . g:diff_tmp_file_prefix . buff_index . '_' . file_base_name
  let export_tmp_file_cmd  = 'git show ' . buff_index . ' > ' . tmp_file_path
  let _ = system(export_tmp_file_cmd)

  execute "edit " . file_path
  execute "vertical diffsplit" . tmp_file_path
endfunction

augroup GTmpFileRemove
  autocmd!
    autocmd VimLeave * call RemoveTmpFile()
augroup END
function RemoveTmpFile()
  if exists(g:is_created_diff_file)
    let cmd = 'rm /tmp/' . g:diff_tmp_file_prefix . '*'
    let _ = system(cmd)
  endif
endfunction

"NERD TREE
map <C-n> :NERDTreeToggle<CR>
augroup NERDTree
  autocmd!
    autocmd bufenter * if (winnr("$") == 1 && exists("b:NERDTree") && b:NERDTree.isTabTree()) | q | endif
augroup END

let g:NERDTreeDirArrowExpandable  = ''
let g:NERDTreeDirArrowCollapsible = ''

"LSP setting
let g:asyncomplete_auto_popup = 0

function! s:check_back_space() abort
    let col = col('.') - 1
    return !col || getline('.')[col - 1]  =~ '\s'
endfunction

inoremap <silent><expr> <TAB>
  \ pumvisible() ? "\<C-n>" :
  \ <SID>check_back_space() ? "\<TAB>" :
  \ asyncomplete#force_refresh()
inoremap <expr><S-TAB> pumvisible() ? "\<C-p>" : "\<C-h>"


" jump current dir
let g:vimstart_dir=$PWD
let g:vimhome_dir=g:vimstart_dir
command! -nargs=0 Home call s:HomeDir()
function! s:HomeDir()
  :execute 'cd ' . g:vimhome_dir
  if(exists("b:NERDTree"))
    NERDTree
  else
    NERDTree
    NERDTreeClose
  endif
endfunction

command! -nargs=? -complete=dir -bang CD  call s:ChangeCurrentDir('<args>', '<bang>')
function! s:ChangeCurrentDir(directory, bang)
    if a:directory ==# ''
        execute "cd " . expand("%:p:h")
    else
        execute 'cd ' . a:directory
    endif

    if a:bang ==# ''
        pwd
    endif

    if(exists("b:NERDTree"))
      NERDTree
    else
      NERDTree
      NERDTreeClose
    endif
endfunction
