vim.cmd([[
  " Telescope
  
  hi! link @type Constant
  hi! link @type.builtin Keyword
  hi! link @type.qualifier.c_sharp Keyword

  hi! link @operator Keyword
  hi! link @parameter @variable
  
  hi! link @property Special
  hi! link @field @property

  " Language specific

  hi! link @property.javascript @property
  hi! link @method.call.javascript @method.call
  hi! link @punctuation.delimiter Keyword

  " LSP

  hi! link @lsp.type.property Special
  hi! link @lsp.type.enum @type
  hi! link @lsp.type.parameter @variable
  
  " General

  hi! Search cterm=reverse ctermbg=NONE ctermfg=NONE gui=reverse guibg=NONE guifg=NONE
  hi! link Visual Search
]])

function hi(name, fg, bg, gui)
  vim.cmd("hi " .. name .. 
    (fg and (" guifg=" .. fg) or "") ..
    (bg and (" guibg=" .. bg) or "") .. 
    (gui and (" gui=" .. gui) or ""))
end

bg = require("cm.colors").bg1

hi("VertSplit", bg, bg)
hi("WinSeparator", bg, bg)
hi("StatusLine", bg, bg)
hi("StatusLineNC", bg, bg)

