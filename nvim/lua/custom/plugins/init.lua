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
  ["nvim-treesitter/nvim-treesitter"] = {
    requires = {
      { "nvim-treesitter/nvim-treesitter-textobjects", opt = true },
      { "JoosepAlviste/nvim-ts-context-commentstring", opt = true },
      { "p00f/nvim-ts-rainbow", opt = true },
    },
    config = function()
      local lazy_load = require("core.utils").packer_lazy_load
      lazy_load('nvim-ts-rainbow')
      lazy_load('nvim-treesitter-textobjects')
      lazy_load('nvim-ts-context-commentstring')
      require "plugins.configs.treesitter"
    end,
  },
  ["lewis6991/gitsigns.nvim"] = {
    event = "BufReadPost",
    module = "gitsigns",
    config = function()
      local cfgs = require("custom.plugins.configs.gitsigns")
      local _, gitsigns = pcall(require, "gitsigns")
      gitsigns.setup(cfgs)
    end,
  },

  ["farmergreg/vim-lastplace"] = {
    event = "BufReadPre",
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
    setup = function()
      -- Unless you are still migrating, remove the deprecated commands from v1.x
      vim.g.neo_tree_remove_legacy_commands = 1
      vim.keymap.set('n', '\\', ':Neotree reveal<cr>')
      vim.keymap.set('n', '<C-n>', ':Neotree toggle<cr>', { silent = true })
    end,
    config = function()
      local lazy_load = require("core.utils").packer_lazy_load
      lazy_load('nui')
      lazy_load('plenary')
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
    module = "ts_context_commentstring",
  },
  ["romgrk/nvim-treesitter-context"] = {
    -- disable = true,
    requires = { "nvim-treesitter", opt = true },
    config = function()
      require 'treesitter-context'.setup({
        enable = false, -- Enable this plugin (Can be enabled/disabled later via commands)
        throttle = true, -- Throttles plugin updates (may improve performance)
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
  ['petobens/poet-v'] = {
    ft = { "python" }
  },
  ['simrat39/rust-tools.nvim'] = {
    -- ft = { "rust" },
    module = "rust-tools",
    before = { "nvim-lspconfig" },
    requires = {
      { "neovim/nvim-lspconfig" },
      { "mfussenegger/nvim-dap", opt = true }
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
      local lazy_load = require("core.utils").packer_lazy_load
      lazy_load("vim-dadbod")
      lazy_load('vim-dadbod-completion')
    end
  },
  ['kristijanhusak/vim-dadbod-completion'] = {
    ft = { "sql", "mysql", "plsql" },
    -- after = { "vim-dadbod-ui" },
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
  ["mfussenegger/nvim-dap"] = {
    opt = true,
    module = "dap",
    requires = {
      { "rcarriga/nvim-dap-ui", opt = true },
      { "nvim-dap-virtual-text", opt = true },
    },
    config = function()
      require("custom.plugins.configs.dap-config").setup()
      require("custom.plugins.configs.dapui-config").setup()
      require("custom.plugins.configs.dap-virtual-text").setup()
    end
  },
  ["rcarriga/nvim-dap-ui"] = {
    before = { "mfussenegger/nvim-dap" },
    module = "dapui",
  },
  ['theHamsta/nvim-dap-virtual-text'] = {
    before = { "mfussenegger/nvim-dap" },
    module = "nvim-dap-virtual-text",
  },
  ['rcarriga/cmp-dap'] = {
    opt = true,
    module = "cmp_dap",
  },
  ['hrsh7th/cmp-path'] = {
    opt = true,
    before = { 'hrsh7th/nvim-cmp' },
  },
  ['hrsh7th/cmp-cmdline'] = {
    before = { 'hrsh7th/nvim-cmp' },
  },
  ['hrsh7th/cmp-emoji'] = {
    before = { 'hrsh7th/nvim-cmp' },
  },
  ['tzachar/cmp-tabnine'] = {
    run = './install.sh',
    before = { 'hrsh7th/nvim-cmp' },
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
    before = { 'hrsh7th/nvim-cmp' },
  },

  ["mrjones2014/legendary.nvim"] = {
    before = "folke/which-key.nvim",
    config = function()
      local opts = require("custom.plugins.configs.whichkey")
      require('legendary').setup({
        autocmds = opts.autocmds,
        commands = opts.commands,
      })
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
  ["phaazon/hop.nvim"] = {
    event = "BufReadPost",
    setup = function()
      vim.api.nvim_set_keymap("n", "s", ":HopChar2<cr>", { silent = true })
      vim.api.nvim_set_keymap("n", "S", ":HopWord<cr>", { silent = true })
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
    disable = true,
    event = "BufReadPost",
    requires = { { 'nvim-lua/plenary.nvim', opt = true } },
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
    event  = "BufReadPost",
    setup  = function()
      vim.g.copilot_no_tab_map = true
    end,
    config = function()
      vim.keymap.set('i', '<C-x>', vim.fn['copilot#Accept']("<CR>"), { expr = true, silent = true })
      -- imap <silent><script><expr> <C-J> copilot#Accept("\<CR>")
    end
  }
}
