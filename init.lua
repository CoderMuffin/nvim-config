function Reload()
  vim.cmd("source ~/.config/nvim/init.lua")
end
vim.cmd("command! Reload lua Reload()")

function Rename()
  local CR = vim.api.nvim_replace_termcodes("<C-R>", true, false, true)
  vim.api.nvim_feedkeys("gdva{:s/" .. CR .. "//", "n", false)
end
vim.cmd("command! Rename lua Rename()")

vim.g.gitgutter_sign_added = '+'
vim.g.gitgutter_sign_modified = '~'
vim.g.gitgutter_sign_removed = '-'

function ThemeColor(name, field)
  local id = vim.fn.synIDtrans(vim.fn.hlID(name))
  local background_color = vim.fn.synIDattr(id, field, "gui")
  return background_color
end

function FormatCommand()
  local filetype = vim.bo.filetype
  if filetype == "rust" then
    vim.cmd('!rustfmt --edition 2018 -i %')
  elseif filetype == "c" or filetype == "cs" or filetype == "javascript" or filetype == "java" then
    vim.cmd(
      '!clang-format --style="{ BasedOnStyle: LLVM, InsertNewlineAtEOF: true, IndentWidth: 4, UseTab: Never, BreakBeforeBraces: Attach, AllowShortBlocksOnASingleLine: Empty, SortIncludes: false, ColumnLimit: 0 }" -i %')
  else
    print("Unknown filetype " .. filetype .. ", using LSP instead")
    vim.cmd(":LSPFormat")
  end
end

vim.cmd('command! Format lua FormatCommand()')

vim.cmd([[
  if !executable("rg")
    echo 'Installing ripgrep...'
    execute '!sudo apt-get install ripgrep'
  endif
]])

require("cm.lazy")
require("cm.options")
require("cm.keymap")

-- [[ Highlight on yank ]]
-- See `:help vim.highlight.on_yank()`
local highlight_group = vim.api.nvim_create_augroup('YankHighlight', { clear = true })
vim.api.nvim_create_autocmd('TextYankPost', {
  callback = function()
    vim.highlight.on_yank()
  end,
  group = highlight_group,
  pattern = '*',
})

require("cm.cfg.telescope")
require("cm.lsp")
require("cm.cfg.cmp")

-- The line beneath this is called `modeline`. See `:help modeline`
-- vim: ts=2 sts=2 sw=2 et
