function Reload(file)
  vim.cmd("source " .. vim.fn.stdpath('config') .. "/lua/cm/" .. vim.trim(file) .. ".lua")
end
vim.api.nvim_create_user_command(
  "Reload", -- Command name
  function(args) Reload(args.args) end, -- Command logic
  { nargs = 1 } -- Options: `?` means optional argument
)

function Rename()
  local CR = vim.api.nvim_replace_termcodes("<C-R>", true, false, true)
  vim.api.nvim_feedkeys("gdva{:s/" .. CR .. "//", "n", false)
end
vim.cmd("command! Rename lua Rename()")

vim.g.gitgutter_sign_added = '+'
vim.g.gitgutter_sign_modified = '~'
vim.g.gitgutter_sign_removed = '-'

vim.cmd([[
  if !executable("rg") && !has("win32")
    echo 'Installing ripgrep...'
    execute '!sudo apt-get install ripgrep'
  endif
]])

require("cm.options")
require("cm.keymap")
require("cm.lazy")

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

-- [[ Detect file type ]]
-- local filetype_group = vim.api.nvim_create_augroup('SyntaxFromFiletype', { clear = true })
-- vim.api.nvim_create_autocmd('BufReadPost', {
  -- callback = function()
    -- vim.cmd("Reload options")
    -- if vim.bo.syntax == "" then
      -- vim.cmd("filetype detect")
      -- vim.bo.syntax = vim.bo.filetype
    -- end
  -- end,
  -- group = filetype_group,
  -- pattern = '*'
-- })

require("cm.cfg.telescope")
require("cm.lsp")
require("cm.cfg.cmp")
require("cm.cfg.treesitter")

-- The line beneath this is called `modeline`. See `:help modeline`
-- vim: ts=2 sts=2 sw=2 et
