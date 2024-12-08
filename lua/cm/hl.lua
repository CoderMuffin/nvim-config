vim.cmd([[
  " Telescope
  
  hi! link @type Constant
  hi! link @type.builtin Keyword
  hi! link @type.qualifier.c_sharp Keyword

  hi! link @operator Keyword
  hi! link @parameter @variable
  
  hi! link @property Special
  hi! link @field @property

  hi! link @constructor @type

  hi! link @punctuation.bracket Normal

  hi! link @variable.builtin Keyword

  " Language specific

  hi! link @property.javascript @property
  hi! link @method.call.javascript @method.call
  hi! link @punctuation.delimiter Keyword
  hi! link @variable.builtin.javascript Keyword

  hi! link @type.css Keyword

  " LSP

  hi! link @lsp.type.property Special
  hi! link @lsp.type.enum @type
  hi! link @lsp.type.parameter @variable
  
  " General

  hi! Search cterm=reverse ctermbg=NONE ctermfg=NONE gui=reverse guibg=NONE guifg=NONE
  hi! link Visual Search
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

local function diagnostic_sign(name, text, color)
  hi("DiagnosticSign" .. name, color)
  vim.cmd("sign define DiagnosticSign" .. name .. " text=" .. text .. " texthl=DiagnosticSign" .. name)
end

diagnostic_sign("Error", "", colors.dark_red)
diagnostic_sign("Warn", "", colors.dark_yellow)
diagnostic_sign("Info", "", colors.dark_blue)
diagnostic_sign("Hint", "", colors.dark_purple)

