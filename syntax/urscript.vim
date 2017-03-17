" Vim syntax file
" Language:    urscript
" Maintainer:  Maarten de Vries <maarten@de-vri.es>
" Last Change: 2015 Jan 18
" License:     GPLv3
" Copyright:   2015 - Maarten de Vries <maarten@de-vri.es>
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


if exists("b:current_syntax")
  finish
endif

" Comment
syn match urscriptComments "#.*" contains=urscriptTodo

" Todo
syn keyword urscriptTodo TODO contained

" Identifiers.
syn match urscriptIdentifier "\<[a-zA-Z_][a-zA-Z0-9_]*\>" contained

" Keywords.
syn keyword urscriptKeywords thread run join kill return halt break continue
syn keyword urscriptKeywords while if else elif end
syn keyword urscriptKeywords local global
syn keyword urscriptKeywords def thread nextgroup=urscriptIdentifier skipwhite

" Operators
syn keyword urscriptOperators or and xor not

" Program labels.
syn region urscriptLabelText      start="\"" skip="\\" end="\""  contained
syn match  urscriptLabelNumber     "\d\+"     contained nextgroup=urscriptLabelText skipwhite
syn match  urscriptLabel           "^[$]"     nextgroup=urscriptLabelNumber skipwhite
syn match  urscriptLabelError      "^\s\+[$]" nextgroup=urscriptLabelNumber skipwhite

" Strings.
syn region  urscriptString start="\"" skip="\\" end="\""

" Literal boolean values.
syn keyword urscriptBool True False

" Integer with - + or nothing in front.
syn match urscriptNumber '\<\d\+'
syn match urscriptNumber '\<[-+]\d\+'

" Floating point number with decimal no E or e (+,-).
syn match urscriptNumber '\<\d\+\.\d*'
syn match urscriptNumber '\<[-+]\d\+\.\d*'

" Floating point like number with E and no decimal point (+,-).
syn match urscriptNumber '\<[-+]\=\d[[:digit:]]*[eE][\-+]\=\d\+'
syn match urscriptNumber '\<\d[[:digit:]]*[eE][\-+]\=\d\+'

" Floating point like number with E and decimal point (+,-).
syn match urscriptNumber '\<[-+]\=\d[[:digit:]]*\.\d*[eE][\-+]\=\d\+'
syn match urscriptNumber '\<\d[[:digit:]]*\.\d*[eE][\-+]\=\d\+'

" Erronous semicolon at the end of a line.
syn match urscriptSemicolonError ";\s*$"


" Link urscript groups to default groups.
hi def link urscriptComments    Comment
hi def link urscriptTodo        Todo
hi def link urscriptKeywords    Keyword
hi def link urscriptOperators   Operator
hi def link urscriptIdentifier  Identifier

hi def link urscriptLabelText   String
hi def link urscriptLabelNumber Number
hi def link urscriptLabel       PreProc
hi def link urscriptLabelError  Error

hi def link urscriptString      String
hi def link urscriptBool        Constant
hi def link urscriptNumber      Number

hi def link urscriptSemicolonError Error

let b:current_syntax = "urscript"
