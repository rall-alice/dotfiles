scriptencoding utf-8

" dein {{{
" プラグインが実際にインストールされるディレクトリ
let s:dein_dir = expand('~/.cache/dein')

let s:dein_root_dir = s:dein_dir . '/repos/github.com'

" dein.vim 本体
let s:dein_repo_dir = s:dein_root_dir . '/Shougo/dein.vim'

" dein.vim がなければ github から落としてくる
if &runtimepath !~# '/dein.vim'
	if !isdirectory(s:dein_repo_dir)
		execute '!git clone https://github.com/Shougo/dein.vim' s:dein_repo_dir
	endif
	execute 'set runtimepath^=' . fnamemodify(s:dein_repo_dir, ':p')
endif

" 設定開始
if dein#load_state(s:dein_dir)
	call dein#begin(s:dein_dir)

	" プラグインリストを収めた TOML ファイル
	" 予め TOML ファイル（後述）を用意しておく
	let g:rc_dir    = expand('~/.vim/rc')
	let s:toml      = g:rc_dir . '/dein_plugins.toml'
	let s:lazy_toml = g:rc_dir . '/dein_plugins_lazy.toml'

	" TOML を読み込み、キャッシュしておく
	call dein#load_toml(s:toml,      {'lazy': 0})
	call dein#load_toml(s:lazy_toml, {'lazy': 1})

	" 設定終了
	call dein#end()
	call dein#save_state()
endif

" もし、未インストールものものがあったらインストール
if dein#check_install()
	call dein#install()
endif
" }}}

" Plugin keymap {{{
" Unite
nnoremap <silent><space>G :Unite grep -buffer-name=search-buffer -no-quit -winheight=10<CR>
nnoremap <silent><space>r :<C-u>UniteResume search-buffer -no-quit -winheight=10<CR>
nnoremap <silent><space>o :Unite outline<CR>
nnoremap <silent><space>t :Unite tab<CR>
nnoremap <silent><space>b :Unite buffer<CR>
" Unite Yank
nnoremap <silent><space>y :Unite history/yank<CR>
" Unite giti
nnoremap <silent> <space>gs :Unite giti/status<CR>
nnoremap <silent> <space>gb :Unite giti/branch<CR>
nnoremap <silent> <space>gl :Unite giti/log<CR>
" Surround
nnoremap <C-S> <Nop>
nmap <C-S> ys
nmap <C-S><C-S> ysiw'
" }}}

" Unite {{{

let g:unite_enable_ignore_case = 1
let g:unite_enable_smart_case = 1

if executable('ag')
	let g:unite_source_grep_command = 'ag'
	let g:unite_source_grep_default_opts = '--nogroup --nocolor --hidden -S --ignore /.swp$/'
	let g:unite_source_grep_recursive_opt = ''
endif

" }}}

" lightline {{{
let g:lightline = {	
	\ 'separator': { 'left': "\u2b80", 'right': "\u2b81" },
	\ 'subseparator': { 'left': "\u2b81", 'right': "\u2b83" },
	\ 'active': {
		\  'left': [
			\ [ 'mode', 'paste' ],
			\ [ 'gitbranch', 'readonly', 'filename', 'modified' ]
		\ ]
	\ },
	\ 'component_function': {
	\   'gitbranch': 'fugitive#head'
	\ }
\ }
" }}}

" neocomplete {{{
:if version > 703

"-------------------------
" neocomplete
"-------------------------
"Note: This option must set it in .vimrc(_vimrc).  NOT IN .gvimrc(_gvimrc)!
" Disable AutoComplPop.
let g:acp_enableAtStartup = 0
" Use neocomplete.
let g:neocomplete#enable_at_startup = 1
" Use smartcase.
let g:neocomplete#enable_smart_case = 1
" Set minimum syntax keyword length.
let g:neocomplete#sources#syntax#min_keyword_length = 3
let g:neocomplete#lock_buffer_name_pattern = '\*ku\*'
" Define dictionary.
let g:neocomplete#sources#dictionary#dictionaries = {
			\ 'default' : '',
			\ 'php' : $HOME.'/.vim/dict/php.dict',
			\ 'perl': $HOME . '/.vim/dict/perl.dict'
			\ }
"   \ 'vimshell' : $HOME.'/.vimshell_hist',
"   \ 'scheme' : $HOME.'/.gosh_completions'

" Define keyword.
if !exists('g:neocomplete#keyword_patterns')
	let g:neocomplete#keyword_patterns = {}
endif
let g:neocomplete#keyword_patterns['default'] = '\h\w*'
inoremap <expr><C-g>     neocomplete#undo_completion()
inoremap <silent> <CR> <C-r>=<SID>my_cr_function()<CR>

function! s:my_cr_function()
	return neocomplete#close_popup() . "\<CR>"
endfunction

inoremap <expr><TAB>  pumvisible() ? "\<C-n>" : "\<TAB>"
inoremap <expr><S-TAB>  pumvisible() ? "\<C-p>" : "\<S-TAB>"
inoremap <expr><CR>  neocomplete#close_popup()
inoremap <expr><C-f>  pumvisible() ? "\<C-n>" . neocomplete#close_popup() : neocomplete#close_popup()
inoremap <expr><Left>  neocomplete#close_popup() . "\<Left>"
inoremap <expr><Right> neocomplete#close_popup() . "\<Right>"
inoremap <expr><Up>    neocomplete#close_popup() . "\<Up>"
inoremap <expr><Down>  neocomplete#close_popup() . "\<Down>"
let g:neocomplete#enable_auto_select = 0
let g:neocomplete#text_mode_filetypes = get(g:, 'neocomplete#text_mode_filetypes', {})
let g:neocomplete#text_mode_filetypes.php = 1
let g:neocomplete#text_mode_filetypes.tpl = 1

autocmd FileType css setlocal omnifunc=csscomplete#CompleteCSS
autocmd FileType html,markdown setlocal omnifunc=htmlcomplete#CompleteTags
autocmd FileType javascript setlocal omnifunc=javascriptcomplete#CompleteJS

" }}}
:endif

" neosnippet {{{
let g:neosnippet#snippets_directory = s:dein_root_dir . '/Shougo/neosnippet-snippets/snippets/'
let g:neosnippet#enable_snipmate_compatibility = 1

" SuperTab like snippets behavior.
imap <expr><TAB> pumvisible() ? "\<C-n>" : neosnippet#expandable_or_jumpable() ? "\<Plug>(neosnippet_expand_or_jump)" : "\<TAB>"
imap <expr><CR> neosnippet#expandable_or_jumpable() ?  "\<Plug>(neosnippet_expand_or_jump)" : pumvisible() ? "\<C-y>" : "\<CR>"
smap <expr><TAB> neosnippet#expandable_or_jumpable() ?  "\<Plug>(neosnippet_expand_or_jump)" : "\<TAB>"

" For snippet_complete marker.
if has('conceal')
	set conceallevel=2 concealcursor=i
endif
" }}}

" syntastic {{{
"set statusline+=%#warningmsg#
"set statusline+=%{SyntasticStatuslineFlag()}
"set statusline+=%*
"
"let g:syntastic_enable_perl_checker = 1
"
"let g:syntastic_php_checkers=['php','tpl']
"let g:syntastic_always_populate_loc_list = 1
"let g:syntastic_check_on_open = 1
"let g:syntastic_check_on_wq = 0
"let g:syntastic_enable_signs = 1
"let g:syntastic_echo_current_error = 1
"let g:syntastic_auto_loc_list = 2
"let g:syntastic_enable_highlighting = 1
" }}}

" ctrlp {{{
let g:ctrlp_follow_symlinks = 2
let g:ctrlp_clear_cache_on_exit = 0 
let g:ctrlp_mruf_max = 1500 
let g:ctrlp_working_path_mode = 'ra'
let g:ctrlp_max_height = 20
let g:ctrlp_lazy_update = 120
let g:ctrlp_show_hidden = 1
let g:ctrlp_extensions = ['tag', 'funcky', 'quickfix', 'mixed']
let g:ctrlp_match_window = 'bottom,order:ttb,min:1,max:20,results:50'

let g:ctrlp_custom_ignore = {
\ 'file': '\v\.swp$',
\ 'dir': '\v.*(node_modules|build|\.git)'
\ }

if executable('ag')
	let g:ctrlp_use_caching=0
	"let g:ctrlp_user_command='ag %s -l -S --nocolor --nogroup -g ""'

	let g:ctrlp_user_command='ag %s -l -U --hidden --nocolor --ignore "\v\.(png|jpg|gif|zip|tgz)$" --nogroup -g ""'
endif

let g:ctrlp_funky_matchtype = 'path'

""}}}

" vim-ref {{{
let g:ref_use_vimproc=0
let g:ref_cache_dir=$HOME . '/.vim/vim-ref/cache'
let g:ref_phpmanual_path=$HOME . '/.vim/vim-ref/php-chunked-xhtml'
autocmd FileType ref-* nnoremap <buffer> <silent> q :<C-u>close<CR>
"}}}

let g:netrw_liststyle=3

