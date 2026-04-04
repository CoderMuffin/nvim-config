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
      vim.opt_local.foldmethod = "manual"
      vim.opt_local.spell = false
      vim.opt_local.wrap = false
    end
  end,
  group = vim.api.nvim_create_augroup('NoWrapBigFile', { clear = true }),
  pattern = '*'
})

vim.api.nvim_create_autocmd('FileType', {
  callback = function(args)
    if not vim.treesitter.language.get_lang(args.match) then
      return
    end

    vim.wo.foldmethod = 'expr'
    vim.wo.foldexpr = 'v:lua.vim.treesitter.foldexpr()'

    return vim.treesitter.start(args.buf)
  end,
  group = vim.api.nvim_create_augroup('YankHighlight', { clear = true }),
  pattern = '*',
})
