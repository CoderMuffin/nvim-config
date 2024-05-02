vim.keymap.set({ 'n', 'v' }, '<Space>', '<Nop>', { silent = true })

-- Remap for dealing with word wrap
vim.keymap.set('n', '<Up>', "v:count == 0 ? 'gk' : 'k'", { expr = true, silent = true })
vim.keymap.set('n', '<Down>', "v:count == 0 ? 'gj' : 'j'", { expr = true, silent = true })

vim.api.nvim_set_keymap('i', '<C-D>', '<ESC><S-V>yp<ESC>i', { noremap = true })
vim.api.nvim_set_keymap('n', '<C-D>', '<S-V>yp<ESC>', { noremap = true })
vim.api.nvim_set_keymap('n', '<Tab>', '<C-W>l', { noremap = true, silent = true })
vim.api.nvim_set_keymap('n', '<S-Tab>', '<C-W>h', { noremap = true, silent = true })
vim.api.nvim_set_keymap('n', '<S-T>', '<C-W>200h', { noremap = true })
vim.api.nvim_set_keymap('n', '<C-S>', ':w<CR>', { noremap = true })
vim.api.nvim_set_keymap('i', '<C-S>', '<ESC>:w<CR>', { noremap = true })
vim.api.nvim_set_keymap('i', '<C-Z>', '<ESC>ui', { noremap = true })
-- vim.api.nvim_set_keymap('i', '<C-V>', '<ESC>pi', { noremap = true })
vim.api.nvim_set_keymap('t', '<Esc>', '<C-\\><C-n>', { noremap = true })
vim.api.nvim_set_keymap('n', '<C-_>', ':norm gcc<CR>', { noremap = true, silent = true })
vim.api.nvim_set_keymap('i', '<C-_>', '<ESC>:norm gcc<CR>2li', { noremap = true, silent = true })
vim.api.nvim_set_keymap('v', '<C-_>', ':\'<,\'>norm gcc<CR>', { noremap = true, silent = true })

-- wrap <left> and <right> to next line
vim.cmd('set whichwrap+=<,>,[,]')

