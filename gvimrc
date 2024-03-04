" VARIABLES ----------------------------------------{{{
let comment = #{python: "# ", scheme: "; ", vim: '" ', javascript: "// "}
let fn_def = #{python: "def", vim: "function"}
"}}}
" SET COMMANDS ------------------{{{
set number

syntax on

set tabstop=4

set autoindent
set cursorline
set wrap

set gfn=Monospace\ 15

"}}}
" PYTHON FILE SETTING --------------------------------------------------{{{
augroup file_python

	autocmd FileType python :iabbrev <buffer> iff if:<left>

	autocmd FileType python :iabbrev <buffer> frlst for item in lst:

	" wrap line in print statement
	autocmd FileType python :nmap <Leader>pl Iprint(<esc>A)

	" run current file through bash command 'python3'
	autocmd FileType python :nmap <f3> :!python3 %<cr>

	" wrap current line in parentheses and enter insert at beginning of line
	autocmd FileType python :nmap <Leader>fn A)<esc>I(<esc>I

	autocmd FileType python :nmap <Leader>qpl I"<esc>A"<esc><Leader>pl


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

" open .gvimrc in new split
nmap -orc :split ~/.gvimrc<cr>

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
	autocmd FileType scheme set lisp
augroup END

augroup file_vim
	autocmd FileType vim nmap <F3> :source %<cr>
augroup END

" FUNCTIONS -------------------------------------{{{
function C_printl(nb, ne)
	if &ft == "python"
			:execute ":normal " . a:nb . "G"
			let l:cn = a:nb
			while l:cn != a:ne + 1
				:normal -pl
				let l:cn = l:cn + 1
				:normal j
			endwhile
	endif
endfunction

function C_qprintl(nb, ne)
	if &ft == "python"
			:execute ":normal " . a:nb . "G"
			let l:cn = a:nb
			while l:cn != a:ne + 1
				:normal -qpl
				let l:cn = l:cn + 1
				:normal j
			endwhile
	endif
endfunction


function Get_Line_Col()
	return #{line: getcurpos('.')[1], col: getcurpos('.')[4]}
endfunction

function Comment_Line(cursor_reset)
	let l:beginning_pos = Get_Line_Col()

	:execute ":normal I" . g:comment[&filetype]

	if a:cursor_reset
		call cursor(beginning_pos['line'], beginning_pos['col'] + strlen(g:comment[&filetype]))
	endif
endfunction

function Comment_Lines(start, end)
    let l:beginning_cp = Get_Line_Col()
	:execute ":normal " . a:start . "G"
	for line in range(a:start, a:end)
		call Comment_Line(0)
		:normal j
	endfor
	call cursor(beginning_cp['line'], beginning_cp['col'] + strlen(g:comment[&filetype]))
endfunction

function Goto_def()
    :execute ':normal "ayaw'
    :execute ":split"
    :execute "?" . g:fn_def[&ft] . @a
endfunction


"}}}
" COMMANDS -----------------------------------------{{{
" Wrap Range of Lines in Print statement
command -range Cpl call C_printl(<line1>,<line2>)
" Wrap Range of Lines in String within Print statement
command -range Cqpl call C_qprintl(<line1>, <line2>)
"}}}


command -nargs=0 Cmtln call Comment_Line(1)
command -range Cmtrng call Comment_Lines(<line1>,<line2>)

nmap <leader>c :Cmtln<cr>



