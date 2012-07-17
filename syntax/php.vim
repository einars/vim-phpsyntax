"
" I scratch my own itches. This is my php syntax file, loosely based on the default php.vim.
"
" Einar Lielmanis, einar@spicausis.lv
"
"
" I don't need much. I don't care about built-in functions, or different colours for numbers,
" or actually nothing much: I need colouring to be able to provide subtle accents and get out of the way.
"
" For the best results, use together with the most excellent phpfolding plugin.
" I guess I will rip it apart somewhen, too.
"
" No configuration options are, or will be, exposed. Write and tweak it for your needs.
"

if exists("b:current_syntax")
  finish
endif

syn sync clear

"pure php for the win.
"runtime! syntax/html.vim

syn region phpComment  start="/\*" end="\*/" contained extend
syn region phpComment  start=/\/\// end=/$/ contained oneline extend
syn region phpComment  start=/#/ end=/$/ contained oneline extend

syn region phpFunctionDef matchgroup=phpKeyword start=/\vfunction\s/ end=/(/me=s-1 extend oneline contained
syn region phpFunctionDef matchgroup=phpKeyword start=/\vclass\s/ end=/ / contained oneline
syn region phpFunctionDef matchgroup=phpKeyword start=/\vextends / end=/\v$|\{/ contained oneline


" far from the comprehensive list. still, most of what I need

syn keyword phpKeyword if else while for switch elseif return die exit echo print static global private protected public list each array break continue and or not new null as true false

syn match phpFunction /\(\h\w*::\)\?\h\w*\s*(/me=e-1 contained display

syn match phpIdentifier /$\h\w*/ contained display
syn match phpIdentifierInString /\v\$\h\w*(\-\>\w+)*/ contained display

syn match phpSpecialChar  /\\[abcfnrtyv\\"$]/ contained display
syn match phpSpecialChar  /\\x\x\{2}/ contained display
syn match phpPrintfSpecifier /%[sSdx]/ contained display
syn cluster phpDQStringInside contains=phpIdentifierInString,phpSpecialChar,phpPrintfSpecifier
syn cluster phpSQStringInside contains=phpSpecialChar,phpPrintfSpecifier

syn region phpString matchgroup=phpString start=/"/ end=/"/ skip=/\\./ contains=@phpDQStringInside contained extend keepend
syn region phpString matchgroup=phpString start=/`/ end=/`/ skip=/\\./ contains=@phpDQStringInside contained extend keepend
syn region phpString matchgroup=phpString start=/'/ end=/'/ skip=/\\./ contains=@phpSQStringInside contained extend keepend
syn region phpString matchgroup=phpString start=/<<<\z([A-Z]\+\)/ end=/^\z1/ contains=@phpDQStringInside contained extend keepend
"
" indenting needs this
syn match phpParent "[({[\]})]" contained display


syn match phpCrapsticle /\v[;:]/ contained display

syn region phpRegion  matchgroup=phpTag start=/<?\(php\)\=/ end=/?>/
    \ contains=phpComment,phpParent,phpKeyword,phpFunction,phpString,phpFunctionDef,phpIdentifier,phpCrapsticle keepend


" region sync is sometimes messy with html.vim

"syn sync match phpRegionSync grouphere phpRegion /^\s*<?\(php\)\=\s*$/
"syn sync match phpRegionSync grouphere NONE /^\s*?>\s*$/
"" this (buggy, as it breaks javascript) line helps nice function folding and other redrawing glitches
"syn sync match phpRegionSync grouphere phpRegion "function\s.*(.*\$"


" or, if we're fast enough, just sync all
syn sync fromstart

syn cluster htmlPreproc add=phpRegion

hi def link phpComment            Comment

hi def link phpString             String

hi def link phpKeyword            Normal
hi def link phpCrapsticle         Normal
hi def link phpFunction           Statement
hi def link phpFunctionDef        Identifier
hi def link phpIdentifier         Normal
hi def link phpIdentifierInString Constant
hi def link phpSpecialChar        Constant
hi def link phpPrintfSpecifier    Constant
hi def link phpConstIdentifier    Constant

let b:current_syntax = "php"

" yes, that's really all.

