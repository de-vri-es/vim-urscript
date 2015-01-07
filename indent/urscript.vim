" Vim filetype plugin file
" Language:     urscript
" Maintainer:   Maarten de Vries <maarten@de-vri.es>
" Last Change:  2015 Jan 07

if exists("b:did_indent") | finish | endif
let b:did_indent = 1

setlocal nolisp
setlocal indentexpr=GetURScriptIndent(v:lnum)
setlocal indentkeys=:0$,o,O,=else,=elif,=end
setlocal nosmartindent

if exists("*GetURScriptIndent")
	finish
endif

let s:keepcpo= &cpo
set cpo&vim

function GetURScriptIndent(lnum)
	" Search backwards for the previous non-empty line that is not a program label.
	let prev_lnum = a:lnum
	while prev_lnum >= a:lnum - 50 && prev_lnum >= 0
		let prev_lnum = prevnonblank(prev_lnum - 1)
		let prev_line = getline(prev_lnum)
		if prev_line !~ '^\$'
			break
		endif
	endwhile

	let prev_indent = indent(prev_lnum)
	let line        = getline(a:lnum)

	" Program labels may not be indented.
	if line =~ '^\s*\$'
		return 0
	endif

	" If this is the first line, use 0 indent.
	if prev_lnum == 0
		return 0
	endif

	" Extra indent to add.
	let add_indent = 0

	" Indent after lines ending in colon.
	if prev_line =~ ':\s*$'
		let add_indent = add_indent + shiftwidth()
	endif

	" Unindent elif/else/end.
	if line =~ '^\s*\(elif\|else\|end\)\>'
		let add_indent = add_indent - shiftwidth()
	endif

	return prev_indent + add_indent
endfunction

let &cpo = s:keepcpo
unlet s:keepcpo
