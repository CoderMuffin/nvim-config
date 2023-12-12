" Vim syntax file
" Language:     Kotlin
" Maintainer:   Alexander Udalov
" URL:          https://github.com/udalov/kotlin-vim
" Last Change:  30 December 2022

if exists('b:current_syntax')
    finish
endif

syn keyword ktStatement break continue return
syn keyword ktConditional if else when
syn keyword ktRepeat do for while
syn keyword ktOperator in is by
syn keyword ktKeyword get set out super this where suspend
syn keyword ktException try catch finally throw

syn keyword ktInclude import package

syn match ktType "\v[a-z_0-9.]@<![A-Z][a-zA-Z0-9_]*"
syn match ktFunction "\v[A-Za-z_][A-Za-z0-9_]*\s*[({]@="

syn keyword ktModifier annotation companion enum inner abstract final open override sealed vararg dynamic expect actual suspend
syn keyword ktStructure class object interface typealias fun val var constructor init

syn keyword ktReservedKeyword typeof

syn keyword ktBoolean true false
syn keyword ktConstant null

syn keyword ktModifier reified external inline noinline crossinline

syn match ktModifier "\v<data>\ze\@=.*<(class|object)>"
syn match ktModifier "\v<value>\ze\@=.*<class>"
syn match ktModifier "\v<(tailrec|operator|infix)>\ze\@=.*<fun>"
syn match ktModifier "\v<const>\ze\@=.*<val>"
syn match ktModifier "\v<lateinit>\ze\@=.*<var>"
syn match ktModifier "\v<(internal|private|protected|public)>\ze\@=.*<(class|object|interface|typealias|fun|val|var|constructor|get|set)>"

syn match ktOperator "\v\?:|::|\<\=? | \>\=?|[!=]\=\=?|<as>\??|[-*+/%]\=?|[!&|=]"

syn keyword ktTodo TODO FIXME XXX contained
syn match ktShebang "\v^#!.*$"
syn match ktLineComment "\v//.*$" contains=ktTodo,@Spell
syn region ktComment matchgroup=ktCommentMatchGroup start="/\*" end="\*/" contains=ktComment,ktTodo,@Spell

syn region ktDocComment start="/\*\*" end="\*/" contains=ktDocTag,ktTodo,@Spell
syn match ktDocTag "\v\@(author|constructor|receiver|return|since|suppress)>" contained
syn match ktDocTag "\v\@(exception|param|property|throws|see|sample)>\s*\S+" contains=ktDocTagParam contained
syn match ktDocTagParam "\v(\s|\[)\S+" contained
syn match ktComment "/\*\*/"

syn match ktSpecialCharError "\v\\." contained
syn match ktSpecialChar "\v\\([tbnr'"$\\]|u\x{4})" contained
syn region ktString start='"' skip='\\"' end='"' contains=ktSimpleInterpolation,ktComplexInterpolation,ktSpecialChar,ktSpecialCharError,@Spell
syn region ktString start='"""' end='""""*' contains=ktSimpleInterpolation,ktComplexInterpolation,@Spell
syn match ktCharacter "\v'[^']*'" contains=ktSpecialChar,ktSpecialCharError
syn match ktCharacter "\v'\\''" contains=ktSpecialChar
syn match ktCharacter "\v'[^\\]'"

syn match ktAnnotation "\v(\w)@<!\@[[:alnum:]_.]*(:[[:alnum:]_.]*)?"
syn match ktLabel "\v\w+\@"
syn match ktLabel "\v(\w)@<=\@\w+"

syn match ktSimpleInterpolation "\v\$\h\w*" contained
syn region ktComplexInterpolation matchgroup=ktComplexInterpolationBrace start="\v\$\{" end="\v\}" contains=ALLBUT,ktSimpleInterpolation,ktTodo,ktSpecialCharError,ktSpecialChar,ktDocTag,ktDocTagParam

syn match ktNumber "\v<\d+[_[:digit:]]*(uL?|UL?|[LFf])?"
syn match ktNumber "\v<0[Xx]\x+[_[:xdigit:]]*(uL?|UL?|L)?"
syn match ktNumber "\v<0[Bb][01]+[_01]*(uL?|UL?|L)?"
syn match ktFloat "\v<\d*(\d[eE][-+]?\d+|\.\d+([eE][-+]?\d+)?)[Ff]?"

syn match ktEscapedName "\v`.*`"

syn match ktExclExcl "!!"
syn match ktArrow "->"

syn region ktFold start="{" end="}" transparent fold

exec "syntax sync ccomment ktComment minlines=10"

hi def link ktStatement Statement
hi def link ktConditional Conditional
hi def link ktRepeat Repeat
hi def link ktOperator Operator
hi def link ktKeyword Keyword
hi def link ktException Exception
hi def link ktReservedKeyword Error

hi def link ktInclude Include

hi def link ktFunction Function

hi def link ktType Type
hi def link ktModifier Keyword
hi def link ktStructure Keyword
hi def link ktTypedef Typedef

hi def link ktBoolean Boolean
hi def link ktConstant Boolean

hi def link ktTodo Todo
hi def link ktShebang Comment
hi def link ktLineComment Comment
hi def link ktComment Comment
hi def link ktCommentMatchGroup Comment
hi def link ktDocComment Comment
hi def link ktDocTag Special
hi def link ktDocTagParam Identifier

hi def link ktSpecialChar SpecialChar
hi def link ktSpecialCharError Error
hi def link ktString String
hi def link ktCharacter Character

hi def link ktAnnotation Constant
hi def link ktLabel Identifier

hi def link ktSimpleInterpolation Identifier
hi def link ktComplexInterpolationBrace Identifier

hi def link ktNumber Number
hi def link ktFloat Float

hi def link ktExclExcl Special
hi def link ktArrow Structure

let b:current_syntax = 'kotlin'

" vim:foldmethod=marker
