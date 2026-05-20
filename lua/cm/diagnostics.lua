local icon_table = {
  [vim.diagnostic.severity.ERROR] = "",
  [vim.diagnostic.severity.WARN] = "",
  [vim.diagnostic.severity.INFO] = "",
  [vim.diagnostic.severity.HINT] = ""
}

vim.diagnostic.config({
  virtual_text = {
    prefix = function(diagnostic, i, total)
      return icon_table[diagnostic.severity]
    end
  },
  signs = {
    text = icon_table
  }
})
