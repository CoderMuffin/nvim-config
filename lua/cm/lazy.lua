-- Install lazy if missing
local lazypath = vim.fn.stdpath 'data' .. '/lazy/lazy.nvim'
if not vim.loop.fs_stat(lazypath) then
  vim.fn.system {
    'git',
    'clone',
    '--filter=blob:none',
    'https://github.com/folke/lazy.nvim.git',
    '--branch=stable', -- latest stable release
    lazypath,
  }
end
vim.opt.rtp:prepend(lazypath)

function ThemeColor(name, field)
  local id = vim.fn.synIDtrans(vim.fn.hlID(name))
  local background_color = vim.fn.synIDattr(id, field, "gui")
  return background_color
end

require('lazy').setup({
  'tpope/vim-fugitive',
  'tpope/vim-surround',
  'tpope/vim-sleuth',

  'Hoffs/omnisharp-extended-lsp.nvim',

  { 'j-hui/fidget.nvim',                 opts = {} },
  {
    "folke/lazydev.nvim",
    ft = "lua", -- lua only
    opts = {
      library = {
        -- See the configuration section for more details
        -- Load luvit types when the `vim.uv` word is found
        { path = "${3rd}/luv/library", words = { "vim%.uv" } },
      },
    },
  },

  "github/copilot.vim",

  {
    "mason-org/mason-lspconfig.nvim",
    opts = {},
    dependencies = {
      { "mason-org/mason.nvim", opts = {} },
      "neovim/nvim-lspconfig",
    },
  },

  {
    'hrsh7th/nvim-cmp',
    dependencies = {
      'L3MON4D3/LuaSnip',
      'saadparwaiz1/cmp_luasnip',
      'hrsh7th/cmp-nvim-lsp',
      'hrsh7th/cmp-buffer',
      'hrsh7th/cmp-path',
      'hrsh7th/cmp-cmdline',
      'rafamadriz/friendly-snippets',
    },
  },

  { 'folke/which-key.nvim', opts = {} },

  {
    -- Adds git related signs to the gutter, as well as utilities for managing changes
    'lewis6991/gitsigns.nvim',
    opts = {
      on_attach = function(bufnr)
        -- don't override the built-in and fugitive keymaps
        local gs = package.loaded.gitsigns
        vim.keymap.set('n', '<leader>gd', gs.diffthis, { buffer = bufnr, desc = 'Preview git hunk' })
        vim.keymap.set('n', '<leader>ghp', gs.preview_hunk, { buffer = bufnr, desc = 'Preview git hunk' })
        vim.keymap.set('n', '<leader>ghs', gs.stage_hunk, { buffer = bufnr, desc = 'Stage/unstage git hunk' })
        vim.keymap.set('n', '<leader>ghr', gs.reset_hunk, { buffer = bufnr, desc = 'Reset git hunk' })
        vim.keymap.set('n', '<leader>gs', gs.stage_buffer, { buffer = bufnr, desc = 'Stage/unstage buffer' })
        vim.keymap.set('n', '<leader>gb', gs.toggle_current_line_blame, { buffer = bufnr, desc = 'Toggle blame' })

        vim.keymap.set({ 'n', 'v' }, 'ghn', function()
          if vim.wo.diff then return 'ghn' end
          vim.schedule(function() gs.next_hunk() end)
          return '<Ignore>'
        end, { expr = true, buffer = bufnr, desc = "Jump to next hunk" })
        vim.keymap.set({ 'n', 'v' }, 'ghp', function()
          if vim.wo.diff then return 'ghp' end
          vim.schedule(function() gs.prev_hunk() end)
          return '<Ignore>'
        end, { expr = true, buffer = bufnr, desc = "Jump to previous hunk" })
      end,
    },
  },

  {
    "nvim-tree/nvim-tree.lua",
    version = "*",
    lazy = false,
    dependencies = {
      "nvim-tree/nvim-web-devicons",
    },
    opts = {
      sync_root_with_cwd = true,
      view = {
        preserve_window_proportions = true
      },
      renderer = {
        highlight_git = true,
        indent_markers = { enable = true },
        icons = {
          git_placement = "signcolumn",
          show = {
            file = true,
            folder = true,
            folder_arrow = true,
            git = true,
          },
          padding = " ",
          glyphs = {
            default = "",
            symlink = "LN",
            git = {
              unstaged = "~",
              staged = "~",
              unmerged = "M!",
              renamed = "->",
              deleted = "-",
              untracked = "#",
              ignored = "#",
            }
          }
        }
      }
    }
  },

  {
    "navarasu/onedark.nvim",
    priority = 1000,
    config = function()
      require("onedark").setup {
        colors = require("cm.colors"),
        cmp_itemkind_reverse = true
      }

      vim.cmd.colorscheme 'onedark'

      require("cm.hl")

      local timer = vim.loop.new_timer()
      -- Delay 2000ms and 0 means "do not repeat"
      timer:start(2000, 0, vim.schedule_wrap(function()
        vim.cmd(":FixHl")
      end))
    end,
  },

  {
    -- Set lualine as statusline
    'nvim-lualine/lualine.nvim',
    -- See `:help lualine.txt`
    opts = {
      options = {
        icons_enabled = false,
        theme = 'onedark',
        -- theme = {
        -- inactive = {
        -- a = { fg = ThemeColor("NormalGrey", "fg"), bg = ThemeColor("NormalLight", "bg") },
        -- c = { fg = ThemeColor("NormalGrey", "fg"), bg = ThemeColor("NormalSemiLight", "bg") }
        -- },
        -- insert = { a = { fg = ThemeColor("Normal", "bg"), bg = ThemeColor("Keyword", "fg") } },
        -- normal = {
        -- a = { fg = ThemeColor("Normal", "bg"), bg = ThemeColor("String", "fg") },
        -- b = { fg = ThemeColor("NormalVeryLight", "fg"), bg = ThemeColor("NormalVeryLight", "bg") },
        -- y = { fg = ThemeColor("NormalVeryLight", "fg"), bg = ThemeColor("NormalVeryLight", "bg") },
        -- c = { fg = ThemeColor("NormalLight", "fg"), bg = ThemeColor("NormalLight", "bg") },
        -- },
        -- command = { a = { fg = ThemeColor("Normal", "bg"), bg = ThemeColor("Number", "fg") } },
        -- terminal = { a = { fg = ThemeColor("Normal", "bg"), bg = ThemeColor("Keyword", "fg") } },
        -- visual = { a = { fg = ThemeColor("Normal", "bg"), bg = ThemeColor("Type", "fg") } },
        -- replace = { a = { fg = ThemeColor("Normal", "bg"), bg = ThemeColor("Comment", "fg") } },
        -- },
        component_separators = '',
        section_separators = '',
      },
      sections = {
        lualine_a = {
          { 'mode', separator = { left = ' ', right = '' } },
        },
        lualine_b = { 'diff', { 'branch', separator = { left = '', right = '' } } },
        lualine_c = { 'filename' },
        lualine_x = { 'diagnostics' },
        lualine_y = { { 'fileformat', separator = { left = '', right = '' } }, 'filetype', 'progress' },
        lualine_z = {
          { 'location', separator = { left = '', right = ' ' } },
        },
      },
      inactive_sections = {
        lualine_a = {
          { 'mode', separator = { left = ' ', right = '' } },
        },
        lualine_b = {},
        lualine_c = { 'filename' },
        lualine_x = {},
        lualine_y = {},
        lualine_z = {
          { 'location', separator = { left = '', right = ' ' } },
        },
      },
    },
  },

  -- Fuzzy Finder (files, lsp, etc)
  {
    'nvim-telescope/telescope.nvim',
    dependencies = {
      'nvim-lua/plenary.nvim',
      -- Fuzzy Finder Algorithm which requires local dependencies to be built.
      -- Only load if `make` is available. Make sure you have the system
      -- requirements installed.
      {
        'nvim-telescope/telescope-fzf-native.nvim',
        -- NOTE: If you are having trouble with this installation,
        --       refer to the README for telescope-fzf-native for more instructions.
        build = 'make',
        cond = function()
          return vim.fn.executable 'make' == 1
        end,
      },
    },
  },

  {
    'natecraddock/workspaces.nvim',
    opts = {
      hooks = {
        open = { "LoadSession" },
      }
    }
  },

  {
    -- Highlight, edit, and navigate code
    'nvim-treesitter/nvim-treesitter',
    branch = "main",
    build = ':TSUpdate',
    lazy = false,
    opts = { }
  },
}, {})

-- Enable telescope fzf native, if installed
pcall(require('telescope').load_extension, 'fzf')
