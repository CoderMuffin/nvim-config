-- Install lazy if missing
-- `:help lazy.nvim.txt` for more info
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
  -- Git related plugins
  'tpope/vim-fugitive',
  'tpope/vim-rhubarb',

  -- Detect tabstop and shiftwidth automatically
  'tpope/vim-sleuth',

  'ThePrimeagen/vim-be-good',

  {
    -- LSP Configuration & Plugins
    'neovim/nvim-lspconfig',
    dependencies = {
      -- Automatically install LSPs to stdpath for neovim
      { 'williamboman/mason.nvim', config = true },
      'williamboman/mason-lspconfig.nvim',

      -- Useful status updates for LSP
      -- NOTE: `opts = {}` is the same as calling `require('fidget').setup({})`
      { 'j-hui/fidget.nvim',       tag = 'legacy', opts = {} },

      -- Additional lua configuration, makes nvim stuff amazing!
      'folke/neodev.nvim',
    },
  },

  {
    -- Autocompletion
    'hrsh7th/nvim-cmp',
    dependencies = {
      -- Snippet Engine & its associated nvim-cmp source
      'L3MON4D3/LuaSnip',
      'saadparwaiz1/cmp_luasnip',

      -- Adds LSP completion capabilities
      'hrsh7th/cmp-nvim-lsp',
      'hrsh7th/cmp-buffer',
      'hrsh7th/cmp-path',
      'hrsh7th/cmp-cmdline',

      -- Adds a number of user-friendly snippets
      'rafamadriz/friendly-snippets',
    },
  },

  --[[{
    'rmagatti/auto-session',
    lazy = false,
    opts = {
      auto_restore_last_session = true,
      post_restore_cmds = {
        "NvimTreeOpen"
      }
    }
  },]]--

  -- Useful plugin to show you pending keybinds.
  { 'folke/which-key.nvim', opts = {} },

  {
    -- Adds git related signs to the gutter, as well as utilities for managing changes
    'lewis6991/gitsigns.nvim',
    opts = {
      -- See `:help gitsigns.txt`
      signs = {
        add = { text = '+' },
        change = { text = '~' },
        delete = { text = '-' },
        topdelete = { text = '-' },
        changedelete = { text = '~' },
        untracked = { text = '#' },
      },
      on_attach = function(bufnr)
        vim.keymap.set('n', '<leader>hp', require('gitsigns').preview_hunk,
          { buffer = bufnr, desc = 'Preview git hunk' })

       -- don't override the built-in and fugitive keymaps
        local gs = package.loaded.gitsigns
        vim.keymap.set({ 'n', 'v' }, ']c', function()
          if vim.wo.diff then return ']c' end
          vim.schedule(function() gs.next_hunk() end)
          return '<Ignore>'
        end, { expr = true, buffer = bufnr, desc = "Jump to next hunk" })
        vim.keymap.set({ 'n', 'v' }, '[c', function()
          if vim.wo.diff then return '[c' end
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
    config = function()
      require("nvim-tree").setup {
        renderer = {
          highlight_git = true,
          -- indent_width = 4,
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
          },
        }
      }
    end,
  },

  {
    -- Theme inspired by Atom
    'navarasu/onedark.nvim',
    priority = 1000,
    config = function()
      -- vim.cmd.colorscheme 'onedark'
    end,
  },

  {
    -- Set lualine as statusline
    'nvim-lualine/lualine.nvim',
    -- See `:help lualine.txt`
    opts = {
      options = {
        icons_enabled = false,
        -- theme = 'onedark',
        theme = {
          inactive = {
            a = { fg = ThemeColor("NormalGrey", "fg"), bg = ThemeColor("NormalLight", "bg") },
            c = { fg = ThemeColor("NormalGrey", "fg"), bg = ThemeColor("NormalSemiLight", "bg") }
          },
          insert = { a = { fg = ThemeColor("Normal", "bg"), bg = ThemeColor("Keyword", "fg") } },
          normal = {
            a = { fg = ThemeColor("Normal", "bg"), bg = ThemeColor("String", "fg") },
            b = { fg = ThemeColor("NormalVeryLight", "fg"), bg = ThemeColor("NormalVeryLight", "bg") },
            y = { fg = ThemeColor("NormalVeryLight", "fg"), bg = ThemeColor("NormalVeryLight", "bg") },
            c = { fg = ThemeColor("NormalLight", "fg"), bg = ThemeColor("NormalLight", "bg") },
          },
          command = { a = { fg = ThemeColor("Normal", "bg"), bg = ThemeColor("Number", "fg") } },
          terminal = { a = { fg = ThemeColor("Normal", "bg"), bg = ThemeColor("Keyword", "fg") } },
          visual = { a = { fg = ThemeColor("Normal", "bg"), bg = ThemeColor("Type", "fg") } },
          replace = { a = { fg = ThemeColor("Normal", "bg"), bg = ThemeColor("Comment", "fg") } },
        },
        component_separators = '',
        section_separators = '',
      },
      sections = {
        lualine_a = {
          { 'mode', separator = { left = ' ', right = '' } },
        },
        lualine_b = { 'diff', { 'branch', separator = { left = '', right = ''} } },
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

  -- "gc" to comment visual regions/lines
  { 'numToStr/Comment.nvim', opts = {} },

  { 'Hoffs/omnisharp-extended-lsp.nvim', opts = {}, config = function() end },

  -- Fuzzy Finder (files, lsp, etc)
  {
    'nvim-telescope/telescope.nvim',
    branch = '0.1.x',
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
    -- Highlight, edit, and navigate code
    'nvim-treesitter/nvim-treesitter',
    dependencies = {
      'nvim-treesitter/nvim-treesitter-textobjects',
    },
    build = ':TSUpdate',
  },

  -- nice tabs
  -- {'akinsho/bufferline.nvim', version = "*", dependencies = 'nvim-tree/nvim-web-devicons', config=function()
    -- require("bufferline").setup{}
  -- end}
}, {})

-- Enable telescope fzf native, if installed
pcall(require('telescope').load_extension, 'fzf')

