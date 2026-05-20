vim.api.nvim_create_autocmd('TextYankPost', {
  callback = function()
    vim.hl.on_yank()
  end,
  group = vim.api.nvim_create_augroup('YankHighlight', { clear = true }),
  pattern = '*',
})

vim.api.nvim_create_autocmd('BufReadPre', {
  callback = function()
    if vim.fn.strwidth(vim.fn.getline('.')) > 1000 or vim.fn.getfsize(vim.fn.expand('%')) > 1024 * 1024 then
      vim.b.large_buf = true
      vim.cmd("syntax off")
      vim.opt_local.spell = false
      vim.opt_local.wrap = false
    end
  end,
  group = vim.api.nvim_create_augroup('NoWrapBigFile', { clear = true }),
  pattern = '*'
})

vim.api.nvim_create_autocmd('FileType', {
  callback = function(args)
    local parser, err = vim.treesitter.get_parser(args.buf)
    if not parser then
      return
    end

    vim.wo.foldmethod = 'expr'
    vim.wo.foldexpr = 'v:lua.vim.treesitter.foldexpr()'

    vim.treesitter.start(args.buf)

    if args.match == "cs" then
      local ose = require("omnisharp_extended")
      vim.keymap.set('n', '<leader>ld', ose.lsp_definition, { noremap = true, silent = true, desc = "LSP definition" })
      vim.keymap.set('n', '<leader>lD', ose.lsp_type_definition, { noremap = true, silent = true, desc = "LSP declaration" })
      vim.keymap.set('n', '<leader>li', ose.lsp_implementation, { noremap = true, silent = true, desc = "LSP implementation" })
      vim.keymap.set('n', '<leader>lu', ose.lsp_references, { noremap = true, silent = true, desc = "LSP uses" })
    end
  end,
  group = vim.api.nvim_create_augroup('TsEnabling', { clear = true }),
  pattern = '*',
})
