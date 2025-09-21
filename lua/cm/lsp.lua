local function trim_log_file()
    local LOG_FILE = require('vim.lsp.log').get_filename()

    local f = io.open(LOG_FILE, "r")
    if f == nil then
        return
    end

    local len = f:seek("end")
    local start = len - 1000000
    if start <= 0 then
        f:close()
        return
    end

    f:seek("set", start)
    local text = f:read("*a"):gsub('^[^\n]*\n', '')
    f:close()

    f = assert(io.open(LOG_FILE, "w"))
    f:write(text)
    f:close()
end
trim_log_file()

local capabilities = require('cmp_nvim_lsp').default_capabilities(vim.lsp.protocol.make_client_capabilities())

vim.lsp.config("*", {
  capabilities = capabilities
})
