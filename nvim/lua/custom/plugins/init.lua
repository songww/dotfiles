return {
  ['akinsho/bufferline.nvim'] = {
    tag = "v2.*",
    requires = {
      { 'kyazdani42/nvim-web-devicons', opt = true }
    }
  },
  ["numToStr/Comment.nvim"] = {
    event = "BufReadPost",
    requires = {
      { "JoosepAlviste/nvim-ts-context-commentstring", opt = true },
    },
    config = function()
      local configs = require("custom.plugins.configs").comment
      local comment = require("Comment")
      comment.setup(configs)
    end
  },

  ["farmergreg/vim-lastplace"] = {
    setup = function()
      vim.g.lastplace_ignore = "gitcommit,gitrebase,svn,hgcommit"
      vim.g.lastplace_ignore_buftype = "quickfix,nofile,help"
    end
  },
  ["nvim-neo-tree/neo-tree.nvim"] = {
    branch = "v2.x",
    requires = {
      { "kyazdani42/nvim-web-devicons", opt = true }, -- not strictly required, but recommended
      { "nvim-lua/plenary.nvim", opt = true },
      { "MunifTanjim/nui.nvim", opt = true }
    },
    cmd = { 'Neotree' },
    wants = {
      'nui.nvim',
      'plenary.nvim',
    },
    setup = function()
      -- Unless you are still migrating, remove the deprecated commands from v1.x
      vim.g.neo_tree_remove_legacy_commands = 1
      vim.keymap.set('n', '\\', ':Neotree reveal<cr>')
      vim.keymap.set('n', '<C-n>', ':Neotree toggle<cr>', { silent = true })
    end,
    config = function()
      local configs = require("custom.plugins.configs.neotree")
      require("neo-tree").setup(configs)
    end
  },
  -- ["Luxed/ayu-vim"] = {
  --   event = "BufReadPost",
  --   setup = function()
  --     vim.o.background = "dark" -- for either mirage or dark version.
  --     vim.g.ayucolor = "mirage" -- for mirage version of theme
  --   end,
  --   config = function()
  --     -- vim.cmd [[colorscheme ayu]]
  --   end
  -- },
  ["JoosepAlviste/nvim-ts-context-commentstring"] = {
    before = { "nvim-treesitter" },
  },
  ['nvim-treesitter/nvim-treesitter-textobjects'] = {
    before = { "nvim-treesitter" },
  },
  ["p00f/nvim-ts-rainbow"] = {
    before = { "nvim-treesitter" },
  },
  ["romgrk/nvim-treesitter-context"] = {
    disable = true,
    before = { "nvim-treesitter" },
    config = function()
      require 'treesitter-context'.setup({
        enable = true, -- Enable this plugin (Can be enabled/disabled later via commands)
        -- throttle = true, -- Throttles plugin updates (may improve performance)
        patterns = { -- Match patterns for TS nodes. These get wrapped to match at word boundaries.
          -- For all filetypes
          -- Note that setting an entry here replaces all other patterns for this entry.
          -- By setting the 'default' entry below, you can control which nodes you want to
          -- appear in the context window.
          default = {
            'class',
            'function',
            'method',
            'while',
            'for',
            'if',
          },
          rust = {
            'impl_item',
            'match',
            'loop',
            'trait',
          },
        },
      })
    end
  },
  ['simrat39/symbols-outline.nvim'] = {
    cmd = { 'SymbolsOutline', 'SymbolsOutlineOpen' },
    requires = {
      { "kyazdani42/nvim-web-devicons", opt = true },
    },
    setup = function()
      vim.g.symbols_outline = {
        highlight_hovered_item = true,
        show_guides = true,
        auto_preview = true,
        position = 'right',
        relative_width = true,
        width = 25,
        auto_close = false,
        show_numbers = false,
        show_relative_numbers = false,
        show_symbol_details = true,
        preview_bg_highlight = 'Pmenu',
        keymaps = { -- These keymaps can be a string or a table for multiple keys
          close = { "<Esc>", "q" },
          goto_location = "<CR>",
          focus_location = "o",
          hover_symbol = "<M-x>",
          toggle_preview = "K",
          rename_symbol = "r",
          code_actions = "a",
        },
        lsp_blacklist = {},
        symbol_blacklist = {},
        symbols = {
          File = { icon = "", hl = "TSURI" },
          Module = { icon = "", hl = "TSNamespace" },
          Namespace = { icon = "", hl = "TSNamespace" },
          Package = { icon = "", hl = "TSNamespace" },
          Class = { icon = "𝓒", hl = "TSType" },
          Method = { icon = "ƒ", hl = "TSMethod" },
          Property = { icon = "", hl = "TSMethod" },
          Field = { icon = "", hl = "TSField" },
          Constructor = { icon = "", hl = "TSConstructor" },
          Enum = { icon = "ℰ", hl = "TSType" },
          Interface = { icon = "ﰮ", hl = "TSType" },
          Function = { icon = "", hl = "TSFunction" },
          Variable = { icon = "", hl = "TSConstant" },
          Constant = { icon = "", hl = "TSConstant" },
          String = { icon = "𝓐", hl = "TSString" },
          Number = { icon = "#", hl = "TSNumber" },
          Boolean = { icon = "⊨", hl = "TSBoolean" },
          Array = { icon = "", hl = "TSConstant" },
          Object = { icon = "⦿", hl = "TSType" },
          Key = { icon = "🔐", hl = "TSType" },
          Null = { icon = "NULL", hl = "TSType" },
          EnumMember = { icon = "", hl = "TSField" },
          Struct = { icon = "𝓢", hl = "TSType" },
          Event = { icon = "🗲", hl = "TSType" },
          Operator = { icon = "+", hl = "TSOperator" },
          TypeParameter = { icon = "𝙏", hl = "TSParameter" }
        }
      }
    end
  },
  ["folke/todo-comments.nvim"] = {
    event = "BufReadPost",
    config = function()
      require("todo-comments").setup()
    end,
  },
  ["tpope/vim-repeat"] = {
    event = "BufRead",
  },
  ["felipec/vim-sanegx"] = {
    event = "BufRead",
  },
  ["lilydjwg/fcitx.vim"] = {
    event = "BufReadPost",
    setup = function()
      vim.g.fcitx_remote = "/usr/bin/fcitx5-remote"
    end
  },
  ['stsewd/sphinx.nvim'] = {
    ft = "rst",
  },
  ["fladson/vim-kitty"] = {
    event = "BufRead *.conf",
  },
  ['rafi/vim-venom'] = {
    ft = { "python" },
    setup = function()
      vim.g.venom_loaded = 1 -- Before plugin loaded
      vim.g.venom_use_tools = 1
    end,
    config = function()
      require('venom').setup({
        symbol = ''
      }) -- After plugin loaded
    end
  },
  ['simrat39/rust-tools.nvim'] = {
    opt = true,
    after = "nvim-lspconfig",
    module = "rust-tools",
    requires = {
      { "neovim/nvim-lspconfig" },
      { "mfussenegger/nvim-dap" }
    },
  },
  ['p00f/clangd_extensions.nvim'] = {
    -- ft = { "c", "cpp", "objc", "objcpp", "cuda" },
    module = "clangd_extensions",
    requires = {
      { "neovim/nvim-lspconfig" },
      { "mfussenegger/nvim-dap", opt = true }
    },
  },
  ['tpope/vim-dadbod'] = {
    opt = true,
  },
  ['kristijanhusak/vim-dadbod-ui'] = {
    cmd = { "DBUI", "DBUIToggle", "DBUIAddConnection" },
    wants = {
      "vim-dadbod",
      "vim-dadbod-completion"
    },
    requires = { "tpope/vim-dadbod", 'kristijanhusak/vim-dadbod-completion' },
    setup = function()
      vim.g.db_ui_use_nerd_fonts = 1
      vim.g.db_ui_save_location = '~/Dropbox/dbui_queries'
      -- vim.g.db_ui_env_variable_url = 'DATABASE_URL'
      -- vim.g.db_ui_env_variable_name = 'DATABASE_NAME'
      vim.g.db_ui_dotenv_variable_prefix = 'DATABASE_'
      -- vim.g.dbs = {
      --   { name = 'dev', url = 'postgres://postgres:mypassword@localhost:5432/my-dev-db' },
      --   { name = 'staging', url = 'postgres://postgres:mypassword@localhost:5432/my-staging-db' },
      --   { name = 'wp', url = 'mysql://root@localhost/wp_awesome' },
      -- }
      vim.g.db_ui_table_helpers = {
        postgresql = {
          Count = 'select count(*) from "{table}"'
        }
      }
    end,
    config = function()
    end
  },
  ['kristijanhusak/vim-dadbod-completion'] = {
    ft = { "sql", "mysql", "plsql" },
    requires = { 'hrsh7th/nvim-cmp' },
  },
  ['folke/trouble.nvim'] = {
    event = "BufReadPost",
    cmd = { "Trouble", "TroubleToggle" },
    config = function()
      require("custom.plugins.configs.trouble").setup()
    end
  },
  ["jose-elias-alvarez/null-ls.nvim"] = {
    after = "nvim-lspconfig",
    config = function()
      require("custom.plugins.configs.null").setup()
    end,
  },
  ["williamboman/mason.nvim"] = {
    module = { "mason", "mason.core", "mason.registry" },
  },
  ["williamboman/mason-lspconfig.nvim"] = {
    after = "nvim-lspconfig",
    requires = { "williamboman/mason.nvim" },
    config = function ()
      require("mason").setup()
      require("mason-lspconfig").setup(require("custom.plugins.configs").installer)
    end
  },
  ["mfussenegger/nvim-dap"] = {
    opt = true,
    module = "dap",
    config = function()
      require("custom.plugins.configs.dap-config").setup()
      require("custom.plugins.configs.dapui-config").setup()
      require("custom.plugins.configs.dap-virtual-text").setup()
    end
  },
  ["rcarriga/nvim-dap-ui"] = {
    opt = true,
    module = "dapui",
    wants = {
      "nvim-dap",
      "nvim-dap-virtual-text",
    },
    requires = {
      { "mfussenegger/nvim-dap", opt = true },
      { "theHamsta/nvim-dap-virtual-text", opt = true },
    },
    config = function()
    end
  },
  ['theHamsta/nvim-dap-virtual-text'] = {
    module = "nvim-dap-virtual-text",
  },
  ['rcarriga/cmp-dap'] = {
    wants = 'nvim-cmp',
    module = "cmp_dap",
    event = 'InsertEnter',
    requires = { 'hrsh7th/nvim-cmp' },
  },
  ['hrsh7th/cmp-cmdline'] = {
    wants = 'nvim-cmp',
    event = 'InsertEnter',
    requires = { 'hrsh7th/nvim-cmp' },
  },
  ['hrsh7th/cmp-emoji'] = {
    wants = 'nvim-cmp',
    event = 'InsertEnter',
    requires = { 'hrsh7th/nvim-cmp' },
  },
  ['tzachar/cmp-tabnine'] = {
    run = './install.sh',
    after = { 'nvim-cmp' },
    requires = { 'hrsh7th/nvim-cmp' },
    config = function()
      local tabnine = require('cmp_tabnine.config')
      tabnine:setup({
        max_lines = 1000;
        max_num_results = 5;
        sort = true;
        run_on_every_keystroke = true;
        snippet_placeholder = '..';
        ignored_file_types = { -- default is not to ignore
          -- uncomment to ignore in lua:
          -- lua = true
        };
        show_prediction_strength = false;
      })
    end
  },
  ['ray-x/cmp-treesitter'] = {
    after = { 'nvim-cmp', 'nvim-treesitter' },
  },
  ['petertriho/cmp-git'] = {
    module = "cmp_git",
    ft = { "gitcommit", "octo" },
    wants = 'nvim-cmp',
    requires = "nvim-lua/plenary.nvim",
    config = function()
      require("cmp_git").setup({})
    end
  },
  ["folke/which-key.nvim"] = {
    disable = false,
  },
  ["mrjones2014/legendary.nvim"] = {
    opt = true,
    module = "legendary",
    before = "folke/which-key.nvim",
    config = function()
      local opts = require("custom.plugins.configs.whichkey")
      require('legendary').setup({
        autocmds = opts.autocmds,
        commands = opts.commands,
      })
      require("which-key")
    end
  },
  ['editorconfig/editorconfig-vim'] = {
    event = "BufReadPost",
    setup = function()
      vim.cmd [[ au FileType gitcommit let b:EditorConfig_disable = 1 ]]
    end
  },
  ['nvim-lualine/lualine.nvim'] = {
    after = "nvim-web-devicons",
    config = function()
      require("custom.plugins.configs.lualine").setup()
    end
  },
  ['arkav/lualine-lsp-progress'] = {
    before = "lualine.nvim",
  },
  ['SmiteshP/nvim-navic'] = {
    requires = "neovim/nvim-lspconfig",
  },
  ["phaazon/hop.nvim"] = {
    cmd = { "HopWord", "HopChar2" },
    module = "hop",
    setup = function()
      vim.keymap.set("n", "f", function() require('hop').hint_words() end, { silent = true })
      vim.keymap.set("n", "s", function() require('hop').hint_char2() end, { silent = true })
      vim.keymap.set("n", "<C-l>", function() require('hop').hint_lines() end, { silent = true })
    end,
    config = function()
      require("hop").setup()
    end,
  },
  ["nacro90/numb.nvim"] = {
    event = "BufReadPost",
    config = function()
      require("numb").setup({
        show_numbers = true, -- Enable 'number' for the window while peeking
        show_cursorline = true, -- Enable 'cursorline' for the window while peeking
        number_only = true, -- Peek only when the command is only a number instead of when it starts with a number
        centered_peeking = true, -- Peeked line will be centered relative to window
      })
    end,
  },
  ["beauwilliams/focus.nvim"] = {
    event = "BufReadPost",
    config = function()
      require("focus").setup({
        autoresize = true,
        winhighlight = false,
        excluded_buftypes = { "help", 'nofile', 'prompt', 'popup' },
        excluded_filetypes = { "toggleterm" },
        forced_filetypes = { "dan_repl" },
        compatible_filetrees = { "nvimtree", "neo-tree" },
      })
    end
  },
  ["luukvbaal/stabilize.nvim"] = {
    event = "BufReadPost",
    config = function()
      require("stabilize").setup()
    end
  },
  ['nvim-lua/popup.nvim'] = {
    event = "BufReadPost",
  },
  ['weilbith/nvim-code-action-menu'] = {
    cmd = 'CodeActionMenu'
  },
  ['MunifTanjim/nui.nvim'] = {
    module = "nui",
  },
  ['CosmicNvim/cosmic-ui'] = {
    event = "BufReadPost",
    requires = {
      { 'MunifTanjim/nui.nvim', opt = true },
      { 'nvim-lua/plenary.nvim', opt = true },
    },
    config = function()
      require('cosmic-ui').setup()
    end,
  },
  ['stevearc/dressing.nvim'] = {
    event = "BufEnter",
    config = function()
      require('dressing').setup({
        input = {
          -- Set to false to disable the vim.ui.input implementation
          enabled = true,
        },
        select = {
          -- Set to false to disable the vim.ui.select implementation
          enabled = true,
          backend = { "telescope", "nui", "builtin" },
        },
      })
    end
  },
  ["rcarriga/nvim-notify"] = {
    event = "BufEnter",
    config = function()
      vim.notify = require("notify")
    end
  },
  ['sindrets/diffview.nvim'] = {
    cmd = { "DiffviewOpen", 'DiffviewFileHistory' },
    requires = { { 'nvim-lua/plenary.nvim' } },
  },
  ['saecki/crates.nvim'] = {
    event = { "BufRead Cargo.toml" },
    requires = { 'nvim-lua/plenary.nvim' },
    config = function()
      require('crates').setup()
    end,
  },
  ["github/copilot.vim"] = {
    branch = "release",
    event  = "InsertEnter",
    setup  = function()
      vim.g.copilot_no_tab_map = true
    end,
    config = function()
      -- vim.keymap.set('i', '<C-M>', vim.fn['copilot#Accept']("<CR>"), { expr = true, silent = true })
      vim.cmd [[inoremap <silent><script><expr> <M-x> copilot#Accept("\<CR>")]]
    end
  }
}
