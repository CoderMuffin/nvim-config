hi! link csStorage Keyword
hi! link csAccessModifier Keyword
hi! link csModifier Keyword

syn keyword csBuiltin class void int float double decimal bool string
hi def link csBuiltin Keyword

syn match csFunction "\v[A-Za-z_][A-Za-z0-9_]*\s*[({]@="
syn match csClass "\v[a-z_0-9]@<![A-Z][a-zA-Z0-9_]*"
hi def link csFunction Type
hi def link csClass Type

