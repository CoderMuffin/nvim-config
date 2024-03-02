syn match javaFunction "\v[A-Za-z_][A-Za-z0-9_]*\s*[({]@=" containedin=javaParenT,javaParenT1,javaParenT2
syn match javaClass "\v[a-z_0-9.]@<![A-Z][a-zA-Z0-9_]*" containedin=javaParenT,javaParenT1,javaParenT2
syn match javaOp "\v[<>&|!?:]|\+\+|--|[+-/%]?\=" containedin=javaParenT,javaParenT1,javaParenT2
syn keyword javaThis this

hi def link javaOp Operator
hi def link javaClass Type
hi def link javaFunction Function
hi def link javaThis Keyword
hi! link javaType Keyword

