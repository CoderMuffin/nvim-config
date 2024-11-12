local color = require("cm.color")

-- Define color values
function hi(name, fg, bg, gui)
  vim.cmd("hi " .. name .. 
    (fg and (" guifg=" .. fg) or "") ..
    (bg and (" guibg=" .. bg) or "") .. 
    (gui and (" gui=" .. gui) or ""))
end

function link(name, to)
  vim.cmd("hi! link " .. name .. " " .. to)
end

hi("Normal", color.fg, color.bg)
hi("NormalLight", color.fg, color.bg_light_2)
hi("NormalDark", color.fg, color.bg_dark)
hi("NormalGrey", color.grey)
hi("NormalSemiLight", color.fg, color.bg_light_1)
hi("NormalVeryLight", color.fg, color.bg_light_3)

hi("Error", "#ff4455", "#403142", "none")
link("ErrorMsg", "Error")
link("DiagnosticError", "Error")

hi("DiagnosticWarn", "#ffaa00", "#3c3942", "none")
link("WarnMsg", "DiagnosticWarn")
link("DiagnosticUnnecessary", "NormalGrey")

link("WildMenu", "NormalLight")
link("Pmenu", "NormalLight")
link("PmenuSel", "NormalDark")
link("NormalFloat", "NormalLight")
link("SignColumn", "Normal")
link("LineNr", "NormalGrey")
link("NonText", "NormalGrey")
link("WhichKeyDesc", "NormalLight")
link("Directory", "Keyword")
link("Title", "String")

hi("htmlTag", "#adaeb5")
link("htmlEndTag", "htmlTag")
link("Question", "Keyword")

hi("VertSplit", color.bg_light_2, color.bg_light_2)
hi("WinSeparator", color.bg_light_2, color.bg_light_2)
hi("StatusLine", color.bg_light_2, color.bg_light_2)
hi("StatusLineNC", color.bg_light_2, color.bg_light_2)

link("GitGutterAdd", "String")
link("GitGutterChange", "Keyword")
link("GitGutterDelete", "Comment")

link("NvimTreeRootFolder", "String")
link("NvimTreeNormal", "NormalDark")
link("NvimTreeFileDirty", "Type")
link("NvimTreeFileNew", "NvimTreeFileDirty")
link("NvimTreeFolderDirty", "Keyword")
link("NvimTreeExecFile", "Constant")

hi("Comment", color.pink)
hi("String", color.green)
hi("Type", color.purple, nil, "none")
hi("Number", color.yellow)
hi("Keyword", color.blue)

link("Operator", "Keyword")
link("Constant", "Number")
link("PreProc", "Keyword")
link("Statement", "Keyword")
link("Function", "Type")
link("Identifier", "Normal")
link("Special", "Normal")

link("MoreMsg", "Keyword")

link("markdownCodeDelimiter", "Keyword")
link("markdownH1Delimiter", "Keyword")
link("markdownH2Delimiter", "Keyword")
link("markdownH3Delimiter", "Keyword")
link("markdownH4Delimiter", "Keyword")
link("markdownH5Delimiter", "Keyword")
link("markdownH6Delimiter", "Keyword")
link("markdownH6Delimiter", "Keyword")
link("markdownCodeBlock", "Type")
link("markdownItalicDelimiter", "Keyword")
link("markdownBoldDelimiter", "Keyword")

link("javaScopeDecl", "Keyword")
link("javaClassDecl", "Keyword")
link("javaStorageClass", "Keyword")

link("@constant.builtin", "Constant")
link("@function.builtin.python", "Keyword")
link("@string.escape", "Comment")
link("@variable.builtin", "Keyword")
link("@punctuation.delimiter", "Keyword")

link("xmlTagName", "Keyword")
link("xmlTag", "Keyword")
link("xmlAttribPunct", "Type")

hi("CmpItemKind", color.green, color.bg_light_3)
hi("CmpItemKindKeyword", color.blue, color.bg_light_3)
hi("CmpItemKindConstructor", color.blue, color.bg_light_3)
hi("CmpItemKindFunction", color.purple, color.bg_light_3)
hi("CmpItemKindMethod", color.purple, color.bg_light_3)
hi("CmpItemKindClass", color.purple, color.bg_light_3)
hi("CmpItemKindInterface", color.purple, color.bg_light_3)
hi("CmpItemKindEnumMember", color.yellow, color.bg_light_3)
hi("CmpItemKindSnippet", color.pink, color.bg_light_3)

-- syn match TrailingWhitespace "\s\+$"
-- hi! TrailingWhitespace guibg=#ff4455

