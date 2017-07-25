
"必須設定
set nocompatible
set ambiwidth=double
set noexpandtab
set autoread

"あると便利な設定
:if has("mouse")
set mouse=n
:endif

set history=2000
set autoindent
"set iskeyword-=_

"表示系
set number
set list
set listchars=tab:>-
set ruler
set nowrap
set cursorline
highlight CursorLine cterm=NONE ctermfg=NONE ctermbg=8
set background=dark
set ttyfast

"検索系
set incsearch
set smartcase
set ignorecase
set hlsearch
set showmatch
set grepprg=ag\ --vimgrep\ $*
set grepformat=%f:%l:%c:%m

:if version >= 800
set emoji
set breakindent
:endif

"折りたたみ 
:if version > 703
set foldmethod=manual
set foldcolumn=1
set viewoptions-=options
" Save fold settings.
autocmd BufWritePost * if expand('%') != '' && &buftype !~ 'nofile' | mkview | endif
autocmd BufRead * if expand('%') != '' && &buftype !~ 'nofile' | silent loadview | endif
:endif

set nf=
set commentstring=//%s

"マーク系
nnoremap Mn ]`
nnoremap Mp [`

" 一覧表示
nnoremap Ml :<C-u>marks<CR>

"表示サイズ系
set laststatus=2 
set showtabline=2
set shiftwidth=2
set tabstop=2

"分割ウィンドウ移動
nnoremap   <S-Up>    <C-W>k
nnoremap   <S-Down>  <C-W>j
nnoremap   <S-Left>  <C-W>h
nnoremap   <S-Right> <C-W>l

"タブ関係
nnoremap	<silent> <C-n> :tabnew<CR>
nnoremap	,s :tab split<CR>
nnoremap	<silent> <C-l> :tabnext<CR>
nnoremap	<silent> <C-h> :tabprevious<CR>

"バッファ系
nnoremap	Bu :Unite buffer<CR>

"括弧系
inoremap {} {}<C-g>U<LEFT>
inoremap [] []<C-g>U<LEFT>
inoremap () ()<C-g>U<LEFT>
inoremap "" ""<C-g>U<LEFT>
inoremap '' ''<C-g>U<LEFT>
inoremap <> <><C-g>U<LEFT>

"カーソル移動系
inoremap <C-j> <Nop>
inoremap <C-k> <Nop>
inoremap <C-h> <Nop>
inoremap <C-l> <Nop>
imap <C-j> <DOWN>
imap <C-k> <UP>
imap <C-h> <LEFT>
imap <C-l> <RIGHT>

inoremap <C-w> <Nop>
inoremap <C-b> <Nop>
imap <silent> <C-w> <C-o>w
imap <silent> <C-b> <C-o>b

inoremap <C-e> <Nop>
inoremap <C-a> <Nop>
imap <silent> <C-e> <End>
imap <silent> <C-a> <Home>

"コピペ系
nnoremap Y y$

"その他
nnoremap <silent><ESC><ESC>  :noh<CR>
nnoremap <M-i>  :set paste<CR>i
"ESC1回押した後にカーソルでおかしな挙動になるので矯正
nnoremap <silent><ESC><ESC>OA  <LEFT>
nnoremap <silent><ESC><ESC>OB  <DOWN>
nnoremap <silent><ESC><ESC>OC  <RIGHT>
nnoremap <silent><ESC><ESC>OD  <UP>

"gfと<C-w>gfを入れ替える
nnoremap gf  <C-w>gF
nnoremap gF  <C-w>gf
nnoremap <C-w>gf gF
nnoremap <C-w>gF gf
nnoremap J gJ
nnoremap gJ J

"便利設定
autocmd InsertLeave * set nopaste
autocmd QuickFixCmdPost *grep* cwindow
autocmd QuickFixCmdPost *ag* cwindow

nnoremap g<CR> g;
inoremap jj <ESC>

:source $VIMRUNTIME/macros/matchit.vim 
