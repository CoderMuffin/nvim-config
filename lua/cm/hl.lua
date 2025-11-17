vim.cmd([[
  " Telescope
  
  hi! link @type Constant
  hi! link @type.builtin Keyword

  hi! link @variable Normal
  hi! link @variable.builtin Keyword
  hi! link @variable.member Special

  hi! link @operator Keyword
  hi! link @parameter @variable
  hi! link @property Special
  hi! link @field @property
  hi! link @constructor @type

  hi! link @punctuation.bracket Normal
  hi! link @punctuation.delimiter Keyword

  hi! link @tag.attribute Number
  hi! link @tag.delimiter Normal

  hi! link @tag.jsx @type
  hi! link @tag.tsx @tag.jsx

  " LSP

  hi! link @lsp.type.class @type
  hi! link @lsp.type.property Special
  hi! link @lsp.type.member Special
  hi! link @lsp.type.enum @type
  hi! link @lsp.type.type Constant
  hi! link @lsp.type.parameter @variable
  hi! link @lsp.typemod.variable.defaultLibrary Keyword
  
  " General

  hi! Search cterm=reverse ctermbg=NONE ctermfg=NONE gui=reverse guibg=NONE guifg=NONE
  hi! link Visual Search
  hi! MatchParen guibg=#666666
]])

vim.cmd("command! FixHl source " .. vim.fn.stdpath('config') .. "/lua/cm/hl.lua");

function hi(name, fg, bg, gui)
  vim.cmd("hi! " .. name .. 
    (fg and (" guifg=" .. fg) or "") ..
    (bg and (" guibg=" .. bg) or "") .. 
    (gui and (" gui=" .. gui) or ""))
end

local colors = require("cm.colors")

hi("VertSplit", colors.bg1, "bg")
hi("WinSeparator", colors.bg1, "bg")
hi("StatusLine", colors.bg1, colors.bg1)
hi("StatusLineNC", colors.bg1, colors.bg1)

hi("DiagnosticSignError", colors.dark_red)
hi("DiagnosticSignWarn", colors.dark_yellow)
hi("DiagnosticSignInfo", colors.dark_blue)
hi("DiagnosticSignHint", colors.dark_purple)

