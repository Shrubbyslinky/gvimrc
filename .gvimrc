" SET COMMANDS ------------------{{{
set relativenumber number

syntax on

set ai
set cursorline
set wrap

set gfn=Monospace\ 15

"}}}
" PYTHON FILE SETTING --------------------------------------------------{{{
augroup file_python
	autocmd FileType python nnoremap <Leader>c I#<esc>

	autocmd FileType python :iabbrev <buffer> iff if:<left>
	autocmd FileType python :iabbrev <buffer> frlst for item in lst:
	" wrap line in print statement
	autocmd FileType python :nmap <Leader>pl Iprint(<esc>A)
	" run current file through bash command 'python3'
	autocmd FileType python :nmap <f3> :!python3 %<cr>
	" wrap current line in parentheses and enter insert at beginning of line
	autocmd FileType python :nmap <Leader>fn A)<esc>I(<esc>I
augroup END
"}}}
" VIMSCRIPT FILE SETTINGS -----------------------------{{{
augroup filetype_vim 
autocmd!
autocmd FileType vim setlocal foldmethod=marker
augroup END
"}}}
" MAPPINGS -----------------------------------------------------------{{{
let mapleader = "-"
let maplocalleader = "\\"

" NORMAL ------------------------{{{
" move left three characters
noremap H 3h
"move right three characters
noremap L 3l

" move line down
noremap <Leader>j ddjP

" move line up
noremap <Leader>k ddkP

" capitalize word behind cursor
noremap <Leader>u vbUe

" reload vimrc
nnoremap <Leader>sv :source $MYGVIMRC<cr>

" enter next set of parentheses
nnoremap <Leader>(  t)T(


"next tab
nnoremap <Left> :tabp<cr>

" previous tab
nnoremap <Right> :tabn<cr>

" paste right after cursor
nnoremap <Leader>p pi<BS><esc>$

" paste right before cursor
nnoremap <Leader>P Pji<BS><esc>$

" toggle relative number
nmap <f2> :set relativenumber!<cr>:echo &relativenumber<cr>

" quickly enter 'execute external command'
nmap ! :!
"}}}
" INSERT ------------------------------{{{
" capitalize word behind cursor
noremap <Leader>u <esc>vbUea
"}}}
"}}}
" ABBERVIATIONS " ---------------------------{{{
iabbrev rtn return
" }}}
augroup file_scheme
	autocmd FileType scheme nmap <F3> :!mit-scheme < %<cr>
augroup END
