local telescope = require('telescope')
local actions = require('telescope.actions')

telescope.setup {
  extensions = { workspaces = {} },
  defaults = {
    file_ignore_patterns = { ".git" },
    mappings = {
      i = {
        ['<C-u>'] = false,
        ['<C-d>'] = actions.delete_buffer,
      },
      n = {
        ['<C-d>'] = actions.delete_buffer,
      }
    },
  },
}
telescope.load_extension('workspaces')

-- See `:help telescope.builtin`
vim.keymap.set('n', '<leader>?', require('telescope.builtin').oldfiles, { desc = '[?] Find recently opened files' })
vim.keymap.set('n', '<leader><space>', require('telescope.builtin').find_files, { desc = '[ ] Find files' })
vim.keymap.set('n', '<leader>/', function()
  -- You can pass additional configuration to telescope to change theme, layout, etc.
  require('telescope.builtin').current_buffer_fuzzy_find(require('telescope.themes').get_dropdown())
end, { desc = '[/] Fuzzily search in current buffer' })


