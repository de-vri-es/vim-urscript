" File type detection for URSCript
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

au BufRead,BufNewFile *.{ur,urs,urscript} set filetype=urscript
