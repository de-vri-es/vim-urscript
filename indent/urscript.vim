" Vim filetype plugin file
" Language:     urscript
" Maintainer:   Maarten de Vries <maarten@de-vri.es>
" Last Change:  2015 Jan 18
" License:      GPLv3
" Copyright:    2015 - Maarten de Vries <maarten@de-vri.es>
"
" This program is free software: you can redistribute it and/or modify
" it under the terms of the GNU General Public License as published by
" the Free Software Foundation, either version 3 of the License, or
" (at your option) any later version.

" This program is distributed in the hope that it will be useful,
" but WITHOUT ANY WARRANTY; without even the implied warranty of
" MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
" GNU General Public License for more details.

" You should have received a copy of the GNU General Public License
" along with this program.  If not, see <http://www.gnu.org/licenses/>.

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
		if prev_line !~ '^\s*\$'
			break
		endif
	endwhile

	let prev_indent = indent(prev_lnum)
	let line        = getline(a:lnum)

	" If this is the first line, use 0 indent.
	if prev_lnum == 0
		return 0
	endif

	" Extra indent to add.
	let add_indent = 0

	" Indent after lines ending in colon or containing 'enter_critical' keyword
	if prev_line =~ '^[^#]*:\s*\%(#.*\)\?$' || prev_line =~ '^\s*enter_critical\>'
		let add_indent = add_indent + shiftwidth()
	endif

	" Unindent elif/else/end/exit_critical.
	if line =~ '^\s*\(elif\|else\|end\|exit_critical\)\>'
		let add_indent = add_indent - shiftwidth()
	endif

	return prev_indent + add_indent
endfunction

let &cpo = s:keepcpo
unlet s:keepcpo
