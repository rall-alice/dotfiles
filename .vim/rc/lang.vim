"php設定 {{{
augroup php
	autocmd!
	autocmd BufRead,BufNewFile *.tpl set filetype=php
	autocmd BufWrite *.php,*.tpl w !php -l
	"    autocmd FileType php :set dictionary+=~/.vim/dict/php.dict
	inoremap <?? <?php ; ?><LEFT><LEFT><LEFT><LEFT>
augroup END
"}}}

" fish設定 {{{
augroup sh 
"	autocmd BufRead *.fish set filetype=sh 
augroup END " }}}

" HTML設定 {{{
augroup html 
	autocmd BufRead *.tsv set filetype=html 
augroup END " }}}

