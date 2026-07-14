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
    local session = session_name(dir)

    for _, buf in ipairs(vim.api.nvim_list_bufs()) do
        if vim.api.nvim_buf_is_valid(buf) and vim.bo[buf].buftype == "terminal" then
            local content = vim.api.nvim_buf_get_lines(buf, 0, -1, false)
        end
    end

    vim.cmd { cmd = "mksession", args = { session }, bang = true }

    local file = io.open(session .. "_3_3winsz", "w") or error()
    file:write(vim.fn.winrestcmd())
    file:close()
end

local function load_session(dir)
    local session = session_name(dir)

    if vim.fn.filereadable(session) == 1 then
        vim.cmd { cmd = "source", args = { session } }

        local api = require("nvim-tree.api")
        api.tree.find_file { focus = false, open = true }

        local file = io.open(session .. "_3_3winsz", "r")
        if file then
            vim.cmd(file:read("*a"))
            file:close()
        end

        return true
    else
        return false
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

return {
    load_session=load_session,
    save_session=save_session
}
