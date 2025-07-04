" Vim syntax file
" Language: Kanshi Configuration File
" Maintainer: Filippo Bonazzi <fbonazzi@suse.de>
" Last Change: 2025-05-22

if exists("b:current_syntax")
  finish
endif

" Keywords
syn keyword kanshiSection profile output
syn keyword kanshiKeyword mode position transform scale enable disable

" Operators/Punctuation
syn match kanshiDelimiter "{"
syn match kanshiDelimiter "}"
syn match kanshiDelimiter ","

" Strings (quoted output names, etc.)
syn region kanshiString start=/\v"/ end=/\v"/ contains=kanshiEscape skipwhite
syn region kanshiString start=/\v'/ end=/\v'/ contains=kanshiEscape skipwhite

" Escape sequences within strings
syn match kanshiEscape display contained /\v\\./

" Numbers (mode values, positions, scales)
syn match kanshiNumber /\v\d+(\.\d*)?/

" Comments
syn region kanshiComment start=/#/ end=/$/

" Link syntax groups to existing Vim highlight groups
hi def link kanshiSection   Statement
hi def link kanshiKeyword   Keyword
hi def link kanshiDelimiter Delimiter
hi def link kanshiString    String
hi def link kanshiEscape    Special
hi def link kanshiNumber    Number
hi def link kanshiComment   Comment

let b:current_syntax = "kanshi"
