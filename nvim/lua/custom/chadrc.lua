-- Just an example, supposed to be placed in /lua/custom/

local M = {}

-- make sure you maintain the structure of `core/default_config.lua` here,

-- local highlights = require("custom.highlights")
-- local ayu = require("custom.highlights.mayu")

M.ui = {
  theme = "tokyonight",
  -- theme = "ayu-dark",
  -- hl_override = highlights,
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

M.plugins = {
  remove = {
    "feline-nvim/feline.nvim",
    "lukas-reineke/indent-blankline.nvim",
    "kyazdani42/nvim-tree.lua",
  },
  override = {
    ["nvim-treesitter/nvim-treesitter"] = pluginConfs.treesitter,
    ["williamboman/nvim-lsp-installer"] = pluginConfs.installer,
    ["ray-x/lsp_signature.nvim"] = pluginConfs.signature,
    ["akinsho/bufferline.nvim"] = pluginConfs.bufferline,
    ["folke/which-key.nvim"] = pluginConfs.whichkey,
    ["hrsh7th/nvim-cmp"] = function()
      return require("custom.plugins.configs.cmp")
    end,
    ["lewis6991/gitsigns.nvim"] = function()
      return require("custom.plugins.configs.gitsigns")
    end,
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
