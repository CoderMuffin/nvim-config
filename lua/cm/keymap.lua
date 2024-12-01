-- Remap for dealing with word wrap
-- vim.keymap.set('n', '<Up>', "v:count == 0 ? 'gk' : 'k'", { expr = true, silent = true })
-- vim.keymap.set('n', '<Down>', "v:count == 0 ? 'gj' : 'j'", { expr = true, silent = true })

vim.api.nvim_set_keymap('n', '<Tab>', '<C-W>l', { noremap = true, silent = true })
vim.api.nvim_set_keymap('n', '<S-Tab>', '<C-W>h', { noremap = true, silent = true })
vim.api.nvim_set_keymap('n', '<S-T>', '<C-W>200h', { noremap = true })
-- vim.api.nvim_set_keymap('n', '<C-S>', ':w<CR>', { noremap = true })
-- vim.api.nvim_set_keymap('i', '<C-S>', '<ESC>:w<CR>', { noremap = true })
-- vim.api.nvim_set_keymap('i', '<C-Z>', '<ESC>ui', { noremap = true })
vim.api.nvim_set_keymap('t', '<Esc>', '<C-\\><C-n>', { noremap = true })
vim.api.nvim_set_keymap('n', '<C-_>', ':norm gcc<CR>', { noremap = true, silent = true })
vim.api.nvim_set_keymap('i', '<C-_>', '<ESC>:norm gcc<CR>2li', { noremap = true, silent = true })
vim.api.nvim_set_keymap('v', '<C-_>', ':\'<,\'>norm gcc<CR>', { noremap = true, silent = true })

vim.keymap.set('n', '<leader>i', ':Inspect<CR>')

vim.keymap.set('n', '<leader>tq', ':Telescope quickfix<CR>', { noremap = true, silent = true })
vim.keymap.set('n', '<leader>td', ':Telescope diagnostics<CR>', { noremap = true, silent = true })
vim.keymap.set('n', '<leader>tf', ':Telescope fd<CR>', { noremap = true, silent = true, desc = "Telescope files" })
vim.keymap.set('n', '<leader>tg', ':Telescope live_grep<CR>', { noremap = true, silent = true, desc = "Telescope grep" })
vim.keymap.set('n', '<leader>ta', ':Telescope<CR>', { noremap = true, silent = true, desc = "Telescope view all" })

vim.keymap.set('n', '<leader>la', ':lua vim.lsp.buf.code_action()<CR>', { noremap = true, silent = true, desc = "LSP code action" })
vim.keymap.set('n', '<leader>lA', ':lua vim.lsp.buf.code_action({ apply = true })<CR>', { noremap = true, silent = true, desc = "LSP apply code action" })
vim.keymap.set('n', '<leader>ld', ':lua vim.lsp.buf.definition()<CR>', { noremap = true, silent = true, desc = "LSP definition" })
vim.keymap.set('n', '<leader>lD', ':lua vim.lsp.buf.declaration()<CR>', { noremap = true, silent = true, desc = "LSP declaration" })
vim.keymap.set('n', '<leader>lh', ':lua vim.lsp.buf.hover()<CR>', { noremap = true, silent = true, desc = "LSP hover" })
vim.keymap.set('n', '<leader>li', ':lua vim.lsp.buf.implementation()<CR>', { noremap = true, silent = true, desc = "LSP implementation" })
vim.keymap.set('n', '<leader>ls', ':lua vim.lsp.buf.signature_help()<CR>', { noremap = true, silent = true, desc = "LSP signature" })
vim.keymap.set('n', '<leader>lr', ':lua vim.lsp.buf.rename()<CR>', { noremap = true, silent = true, desc = "LSP rename" })
vim.keymap.set('n', '<leader>lt', ':lua vim.lsp.buf.type_definition()<CR>', { noremap = true, silent = true, desc = "LSP type definition" })

-- wrap <left> and <right> to next line
vim.cmd('set whichwrap+=<,>,[,]')

