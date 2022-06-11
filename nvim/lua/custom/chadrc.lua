-- Just an example, supposed to be placed in /lua/custom/

local M = {}

-- make sure you maintain the structure of `core/default_config.lua` here,

local highlights = require("custom.highlights")
-- local ayu = require("custom.highlights.mayu")

M.ui = {
  theme = "tokyonight",
  -- theme = "ayu",
  hl_override = highlights,
}

M.options = {
  user = function()
    vim.opt.whichwrap = "<,>,[,],b,s"
    vim.opt.backspace = "indent,eol,start"
    vim.opt.signcolumn = "yes"
    vim.opt.pumheight = 10
    vim.opt.cursorline = true -- highlight the current line
    vim.opt.wrap = false -- display lines as one long line
    vim.opt.spell = false
    vim.opt.number = true
    vim.opt.relativenumber = true

    vim.opt.fileencoding = "utf-8" -- the encoding written to a file
    vim.opt.foldmethod = "manual" -- folding set to "expr" for treesitter based folding
    vim.opt.foldexpr = "nvim_treesitter#foldexpr()" -- for treesitter based folding
    vim.opt.splitbelow = true -- force all horizontal splits to go below current window
    vim.opt.splitright = true -- force all vertical splits to go to the right of current window
    vim.opt.swapfile = true -- creates a swapfile
    vim.opt.title = true -- set the title of window to the value of the titlestring
    vim.opt.undofile = false -- enable persistent undo
    vim.opt.expandtab = true -- convert tabs to spaces

    -- use filetype.lua instead of filetype.vim
    vim.g.do_filetype_lua = 1
    vim.g.did_load_filetypes = 0

    vim.g.matchup_matchparen_enabled = 1
    vim.g.matchup_matchparen_offscreen = { method = 'popup' }

    vim.cmd([[
      set cursorlineopt=both
      set cursorcolumn
    ]])
  end
}

local userPlugins = require("custom.plugins")
local pluginConfs = require("custom.plugins.configs")
pluginConfs.cmp = require("custom.plugins.configs.cmp")

M.plugins = {
  remove = {
    "feline-nvim/feline.nvim",
    "lukas-reineke/indent-blankline.nvim",
    "kyazdani42/nvim-tree.lua",
  },
  override = {
    ["folke/which-key.nvim"] = {
      triggers_blacklist = {
        -- list of mode / prefixes that should never be hooked by WhichKey
        -- this is mostly relevant for key maps that start with a native binding
        -- most people should not need to change this
        i = { "j", "k", "l", "h", "o" },
        n = { "j", "k", "l", "h", "o" },
        v = { "j", "k", "l", "h", "o" },
      },
    },
    ["hrsh7th/nvim-cmp"] = pluginConfs.cmp,
    ["nvim-treesitter/nvim-treesitter"] = pluginConfs.treesitter,
    ["williamboman/nvim-lsp-installer"] = {
      ensure_installed = { "sumneko_lua", "rust_analyzer", "pyright", "jsonls" },
      automatic_installation = false,
    },
    ["ray-x/lsp_signature.nvim"] = {
      -- timer_interval = 400, -- default timer check interval set to lower value if you want to reduce latency
      toggle_key = "<M>x", -- toggle signature on and off in insert mode
      doc_lines = 10,
    },
    ["akinsho/bufferline.nvim"] = {
      options = {
        offsets = {
          {
            filetype = "neo-tree",
            text = "Files",
            highlight = "Directory",
            text_align = "left"
          }
        }
      }
    }
  },
  options = {
    lspconfig = {
      setup_lspconf = "custom.plugins.configs.lspconfig"
    }
  },
  user = userPlugins,
}

M.mappings = {
  neotree = {
    n = {
      -- toggle
      ["<C-n>"] = { "<cmd> Neotree toggle<CR>", "   toggle neotree" },

      -- focus
      ["<leader>e"] = { "<cmd> Neotree reveal<CR>", "   focus neotree" },
    },
  },
  legendary = {
    n = {
      ["<C-p>"] = {
        function()
          require('legendary').find()
        end,
        "legendary - search keymaps, commands, and autocmds"
      },
      ["<leader>pk"] = {
        function()
          require('legendary').find('keymaps')
        end,
        "legendary - search keymaps"
      },
      ["<leader>pc"] = {
        function()
          require('legendary').find('commands')
        end,
        "legendary - search commands"
      },
      ["<leader>pa"] = {
        function()
          require('legendary').find('autocmds')
        end,
        "legendary - search autocmds"
      },
    },
  }
}

return M
