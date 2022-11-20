-- Just an example, supposed to be placed in /lua/custom/

local M = {}

-- make sure you maintain the structure of `core/default_config.lua` here,

local highlights = require("custom.highlights")
-- local ayu = require("custom.highlights.mayu")

M.ui = {
  theme = "tokyonight",
  transparency = false,
  -- theme = "ayu-dark",
  hl_override = highlights,
}

-- M.options = {}

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
    ["ray-x/lsp_signature.nvim"] = pluginConfs.signature,
    ["akinsho/bufferline.nvim"] = pluginConfs.bufferline,
    --[[ ["williamboman/mason.nvim"] = pluginConfs.installer, ]]
    ["folke/which-key.nvim"] = pluginConfs.whichkey,
    ["hrsh7th/nvim-cmp"] = function()
      return require("custom.plugins.configs.cmp")
    end,
    ["lewis6991/gitsigns.nvim"] = function()
      return require("custom.plugins.configs.gitsigns")
    end,

    ["neovim/nvim-lspconfig"] = function()
      require("plugins.configs.lspconfig")
      require("custom.plugins.configs.lspconfig").setup()
    end,
  },
  -- options = {},
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
