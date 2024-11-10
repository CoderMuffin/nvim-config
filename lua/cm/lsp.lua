-- vim.lsp.set_log_level("debug")

-- Diagnostic keymaps
vim.keymap.set('n', '[d', vim.diagnostic.goto_prev, { desc = 'Go to previous diagnostic message' })
vim.keymap.set('n', ']d', vim.diagnostic.goto_next, { desc = 'Go to next diagnostic message' })
vim.keymap.set('n', '<leader>e', vim.diagnostic.open_float, { desc = 'Open floating diagnostic message' })
vim.keymap.set('n', '<leader>q', vim.diagnostic.setloclist, { desc = 'Open diagnostics list' })

-- [[ Configure LSP ]]
--  This function gets run when an LSP connects to a particular buffer.
local on_attach = function(_, bufnr)
  local nmap = function(keys, func, desc)
    if desc then
      desc = 'LSP: ' .. desc
    end

    vim.keymap.set('n', keys, func, { buffer = bufnr, desc = desc })
  end

  nmap('<leader>rn', vim.lsp.buf.rename, '[R]e[n]ame')
  nmap('<leader>ca', vim.lsp.buf.code_action, '[C]ode [A]ction')

  nmap('gd', vim.lsp.buf.definition, '[G]oto [D]efinition')
  nmap('gr', require('telescope.builtin').lsp_references, '[G]oto [R]eferences')
  nmap('gI', require('telescope.builtin').lsp_implementations, '[G]oto [I]mplementation')
  nmap('<leader>D', vim.lsp.buf.type_definition, 'Type [D]efinition')
  nmap('<leader>ds', require('telescope.builtin').lsp_document_symbols, '[D]ocument [S]ymbols')
  nmap('<leader>ws', require('telescope.builtin').lsp_dynamic_workspace_symbols, '[W]orkspace [S]ymbols')

  -- See `:help K` for why this keymap
  nmap('K', vim.lsp.buf.hover, 'Hover Documentation')
  -- hover diagnostics if you please
  -- vim.api.nvim_create_augroup("lsp_diag_hold", { clear = true })
  -- vim.api.nvim_create_autocmd({ "CursorHold" }, {
    -- pattern = "*",
    -- buffer = "bufnr",
    -- callback = function()
      -- for _, winid in pairs(vim.api.nvim_tabpage_list_wins(0)) do
        -- if vim.api.nvim_win_get_config(winid).zindex then
          -- return
        -- end
      -- end
      -- vim.lsp.buf.hover()
    -- end
  -- })
  nmap('<C-k>', vim.lsp.buf.signature_help, 'Signature Documentation')

  -- Lesser used LSP functionality
  nmap('gD', vim.lsp.buf.declaration, '[G]oto [D]eclaration')
  nmap('<leader>wa', vim.lsp.buf.add_workspace_folder, '[W]orkspace [A]dd Folder')
  nmap('<leader>wr', vim.lsp.buf.remove_workspace_folder, '[W]orkspace [R]emove Folder')
  nmap('<leader>wl', function()
    print(vim.inspect(vim.lsp.buf.list_workspace_folders()))
  end, '[W]orkspace [L]ist Folders')

  -- Create a command `:Format` local to the LSP buffer
  vim.api.nvim_buf_create_user_command(bufnr, 'LSPFormat', function(_)
    vim.cmd(':w')
    if (vim.bo.filetype == "c" or vim.bo.filetype == "javascript") then
      vim.cmd(
        '!clang-format --style="{ InsertNewlineAtEOF: true, BasedOnStyle: LLVM, IndentWidth: 4, UseTab: Never, BreakBeforeBraces: Attach, AllowShortBlocksOnASingleLine: Empty, SortIncludes: false, ColumnLimit: 0 }" -i %')
    else
      vim.lsp.buf.format()
    end
  end, { desc = 'Format current buffer with LSP' })
end

-- all LSPs in `servers` will be auto installed and configured according to muffin magic
local ose = require("omnisharp_extended")

local servers = {
  clangd = {},
  pyright = {},
  rust_analyzer = {},
  html = {
    settings = {
      filetypes = { 'html', 'twig', 'hbs' }
    }
  },
  omnisharp = {
    handlers = {
      ["textDocument/definition"] = ose.definition_handler,
      ["textDocument/typeDefinition"] = ose.type_definition_handler,
      ["textDocument/references"] = ose.references_handler,
      ["textDocument/implementation"] = ose.implementation_handler,
    },
    settings = {
      filetypes = { 'cs', 'vb' }
    }
  },
  lua_ls = {
    settings = {
      Lua = {
        workspace = { checkThirdParty = false },
        telemetry = { enable = false },
      },
    }
  },
  quick_lint_js = {
    -- disable = true, -- THIS PLUGIN IS DISABLED THIS PLUGIN IS DISABLED THIS PLUGIN IS DISABLED THIS PLUGIN IS DISABLED THIS PLUGIN IS DISABLED
    handlers = {
      ['textDocument/publishDiagnostics'] = vim.lsp.with(vim.lsp.diagnostic.on_publish_diagnostics, {
        update_in_insert = true
      })
    },
    settings = {
      filetypes = { "javascript", "javascriptreact", "typescript", "typescriptreact" }
    }
  },
  eslint = {
    disable = true,
    settings = { filetypes = { "javascript" } }
  }
}

-- Setup neovim lua configuration
require('neodev').setup()

-- nvim-cmp supports additional completion capabilities, so broadcast that to servers
local capabilities = vim.lsp.protocol.make_client_capabilities()
capabilities = require('cmp_nvim_lsp').default_capabilities(capabilities)

-- Ensure the servers above are installed
local mason_lspconfig = require 'mason-lspconfig'
local lspconfig = require 'lspconfig'

mason_lspconfig.setup {
  ensure_installed = vim.tbl_keys(servers),
}

mason_lspconfig.setup_handlers {
  function(server_name)
    if servers[server_name].disable then
      return
    end
    lspconfig[server_name].setup(vim.tbl_deep_extend("error", servers[server_name], {
      capabilities = capabilities,
      on_attach = on_attach,
    }))
  end
}
