" Define color values
hi! Normal guifg=#eceff1 guibg=#283142
hi! NormalLight guifg=#eceff1 guibg=#404d64
hi! NormalDark guifg=#eceff1 guibg=#191f29
hi! NormalGrey guifg=#7d7e80
hi! NormalSemiLight guifg=#eceff1 guibg=#313c51
hi! NormalVeryLight guifg=#eceff1 guibg=#546279

let s:vs='#313c51'

hi! Error guifg=#ff4455 guibg=#403142 gui=none
hi! link ErrorMsg Error
hi! link DiagnosticError Error
hi! DiagnosticWarn guifg=#ffaa00 guibg=#3c3942 gui=none
hi! link WarningMsg Warn
hi! link DiagnosticUnnecessary NormalGrey

hi! link WildMenu NormalLight
hi! link Pmenu NormalLight
hi! link PmenuSel NormalDark
hi! link SignColumn Normal
hi! link LineNr NormalGrey
hi! link NonText NormalGrey
hi! link WhichKeyDesc NormalLight
hi! link Directory Keyword
hi! link Title String
hi! htmlTag guifg=#adaeb5
hi! link htmlEndTag htmlTag
hi! link Question Keyword
exe 'hi! VertSplit guifg=' . s:vs . ' guibg=' . s:vs
exe 'hi! StatusLine guifg=' . s:vs . ' guibg=' . s:vs
exe 'hi! StatusLineNC guifg=' . s:vs . ' guibg=' . s:vs

hi! link GitGutterAdd String
hi! link GitGutterChange Keyword
hi! link GitGutterDelete Comment

hi! link NvimTreeRootFolder String
hi! link NvimTreeNormal NormalDark
hi! link NvimTreeFileDirty Type
hi! link NvimTreeFileNew NvimTreeFileDirty
hi! link NvimTreeFolderDirty Keyword
hi! link NvimTreeExecFile Constant

hi! Comment guifg=#ff8bcb
hi! String guifg=#66ff8c
hi! Type guifg=#d7aefb gui=none
hi! Number guifg=#fbbc04
hi! Keyword guifg=#78d9ec

hi! link Operator Keyword
hi! link Constant Number
hi! link PreProc Keyword
hi! link Statement Keyword
hi! link Function Type
hi! link Identifier Normal
hi! link Special Normal

hi! link MoreMsg Keyword

hi! link markdownCodeDelimiter Keyword
hi! link markdownH1Delimiter Keyword
hi! link markdownH2Delimiter Keyword
hi! link markdownH3Delimiter Keyword
hi! link markdownH4Delimiter Keyword
hi! link markdownH5Delimiter Keyword
hi! link markdownH6Delimiter Keyword
hi! link markdownH6Delimiter Keyword
hi! link markdownCodeBlock Type
hi! link markdownItalicDelimiter Keyword
hi! link markdownBoldDelimiter Keyword

hi! link javaScopeDecl Keyword
hi! link javaClassDecl Keyword
hi! link javaStorageClass Keyword

hi! link @constant.builtin Constant
hi! link @function.builtin.python Keyword
hi! link @string.escape Comment
hi! link @variable.builtin Keyword
hi! link @punctuation.delimiter Keyword
hi! link xmlTagName Keyword
hi! link xmlTag Keyword
hi! link xmlAttribPunct Type

hi! Search cterm=reverse ctermbg=NONE ctermfg=NONE gui=reverse guibg=NONE guifg=NONE
hi! link Visual Search

