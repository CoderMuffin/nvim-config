vim.opt.sessionoptions = "buffers,curdir,tabpages,winsize,terminal"

local session_dir = vim.fn.stdpath("data") .. "/sessions/"
if not vim.fn.isdirectory(session_dir) then
    vim.fn.mkdir(session_dir, "p")
end

local function session_name(dir)
    if dir == "" or dir == nil then
        dir = vim.fn.getcwd()
    end

    return session_dir .. dir:gsub("_", "_1"):gsub("[:\\/]", "_2")
end

local function save_session(dir)
    vim.cmd { cmd = "mksession", args = { session_name(dir) }, bang = true }
end

local function load_session(dir)
    local session = session_name(dir)

    if vim.fn.filereadable(session) == 1 then
        vim.cmd { cmd = "source", args = { session } }
        local api = require("nvim-tree.api")
        api.tree.find_file { focus = false, open = true }
    end
end

vim.api.nvim_create_user_command("SaveSession", function(args) save_session(args.args) end, { nargs = "?" })
vim.api.nvim_create_user_command("LoadSession", function(args) load_session(args.args) end, { nargs = "?" })

vim.api.nvim_create_autocmd({"VimLeavePre", "FocusLost"}, {
    callback = function(data)
        save_session()
    end,
    group = vim.api.nvim_create_augroup("SessionPersist", { clear = true })
})
