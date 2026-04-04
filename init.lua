function Reload(file)
  vim.cmd("source " .. vim.fn.stdpath('config') .. "/lua/cm/" .. vim.trim(file) .. ".lua")
end
vim.api.nvim_create_user_command(
  "Reload", -- Command name
  function(args) Reload(args.args) end, -- Command logic
  { nargs = 1 } -- Options: `?` means optional argument
)

vim.cmd([[
  if !executable("rg") && !has("win32")
    echo 'Installing ripgrep...'
    execute '!sudo apt-get install ripgrep'
  endif
]])

require("cm.options")
require("cm.keymap")
require("cm.lazy")
require("cm.diagnostics")
require("cm.au")

require("cm.cfg.telescope")
require("cm.lsp")
require("cm.cfg.cmp")

-- The line beneath this is called `modeline`. See `:help modeline`
-- vim: ts=2 sts=2 sw=2 et
