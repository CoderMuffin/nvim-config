local colors = require "cm.colors"
local win_id = vim.api.nvim_get_current_win()
local ns_id = vim.api.nvim_create_namespace("qf_highlight_" .. win_id)

vim.cmd("syntax clear qfFileName qfLineNr qfSeparator1")

vim.api.nvim_set_hl(ns_id, "qfFileName", { fg = colors.blue })
vim.api.nvim_set_hl(ns_id, "qfLineNr", { fg = colors.orange })
vim.api.nvim_set_hl(ns_id, "qfSeparator1", { fg = "#676767" })
vim.api.nvim_win_set_hl_ns(win_id, ns_id)

vim.fn.matchadd("qfFileName", [[^.\{-2,}\ze:]], 10, -1, { window = win_id })
vim.fn.matchadd("qfLineNr", [[^.\{-2,}:\zs\d\+\ze.\{-}|]], 10, -1, { window = win_id })
vim.fn.matchadd("qfSeparator1", [[^.\{-2,}\zs:\ze]], 10, -1, { window = win_id })
vim.fn.matchadd("qfSeparator1", [[^.\{-2,}:.\{-}\zs|\ze]], 10, -1, { window = win_id })
