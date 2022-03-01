-- use a HTTP proxy for downloading the parsers
require("nvim-treesitter.install").command_extra_args = {
  curl = { "--proxy", "http://127.0.0.1:1087" },
}

-- vim.o.guifont = "Monaco, Symbols Nerd Font Mono Light 12"
-- vim.o.guifont = "Hurmit Nerd Font Mono 12"
-- vim.o.guifont = "Cascadia Code Light:h12"
vim.o.guifont = "Cascadia Code, Symbols Nerd Font Light:h12"

if vim.fn.exists("neovide") then
  -- vim.o.guifont = "Cascadia Code Light 11,Symbols Nerd Font 11"
  -- " Ctrl-ScrollWheel for zooming in/out
  --nnoremap <silent> <C-ScrollWheelUp> :set guifont=+<CR>
  --nnoremap <silent> <C-ScrollWheelDown> :set guifont=-<CR>

  vim.g.neovide_cursor_animation_length = 0.03
  vim.g.neovide_cursor_antialiasing = true
  vim.g.neovide_cursor_vfx_mode = "pixiedust"
  vim.g.neovide_floating_blur = false
  vim.g.neovide_floating_opacity = 0.93
  vim.g.neovide_no_idle = true
  vim.g.neovide_iso_layout = true
  vim.g.neovide_input_use_logo = true
  vim.g.neovide_refresh_rate = 60
  vim.g.neovide_remember_window_size = true
  vim.g.neovide_scroll_animation_length=0.1
  vim.g.neovide_transparency = 0.93

  --nnoremap <A-CR> :let g:neovide_fullscreen = !g:neovide_fullscreen<CR>
end

--[[
lvim is the global options object

Linters should be
filled in as strings with either
a global executable or a path to
an executable
]]
-- THESE ARE EXAMPLE CONFIGS FEEL FREE TO CHANGE TO WHATEVER YOU WANT

-- general
lvim.log.level = "warn"
lvim.format_on_save = true
lvim.colorscheme = "tokyonight"

-- keymappings [view all the defaults by pressing <leader>Lk]
lvim.leader = "space"
-- add your own keymapping
lvim.keys.normal_mode["<C-s>"] = ":w<cr>"
lvim.keys.normal_mode['<C-n>'] = '<cmd>NvimTreeToggle<CR>'
-- unmap a default keymapping
-- lvim.keys.normal_mode["<C-Up>"] = false
-- edit a default keymapping
-- lvim.keys.normal_mode["<C-q>"] = ":q<cr>"

-- Change Telescope navigation to use j and k for navigation and n and p for history in both input and normal mode.
-- we use protected-mode (pcall) just in case the plugin wasn't loaded yet.
local _, actions = pcall(require, "telescope.actions")
lvim.builtin.telescope.defaults.mappings = {
  -- for input mode
  i = {
    ["<C-j>"] = actions.move_selection_next,
    ["<C-k>"] = actions.move_selection_previous,
    ["<C-n>"] = actions.cycle_history_next,
    ["<C-p>"] = actions.cycle_history_prev,
  },
  -- for normal mode
  n = {
    ["<C-j>"] = actions.move_selection_next,
    ["<C-k>"] = actions.move_selection_previous,
  },
}

-- Use which-key to add extra bindings with the leader-key prefix
lvim.builtin.which_key.mappings["P"] = { "<cmd>Telescope projects<CR>", "Projects" }
lvim.builtin.which_key.mappings["t"] = {
  name = "+Trouble",
  r = { "<cmd>Trouble lsp_references<cr>", "References" },
  f = { "<cmd>Trouble lsp_definitions<cr>", "Definitions" },
  d = { "<cmd>Trouble lsp_document_diagnostics<cr>", "Diagnostics" },
  q = { "<cmd>Trouble quickfix<cr>", "QuickFix" },
  l = { "<cmd>Trouble loclist<cr>", "LocationList" },
  w = { "<cmd>Trouble lsp_workspace_diagnostics<cr>", "Diagnostics" },
}

--User Config for predefined plugins
-- After changing plugin config exit and reopen LunarVim, Run :PackerInstall :PackerCompile
lvim.builtin.dap.active = true
lvim.builtin.notify.active = true
lvim.builtin.lualine.active = true
lvim.builtin.terminal.active = true
lvim.builtin.dashboard.active = true
lvim.builtin.bufferline.active = true

lvim.builtin.nvimtree.setup.view.side = "left"
lvim.builtin.nvimtree.show_icons.git = 1

-- if you don't want all the parsers change this to a table of the ones you want
lvim.builtin.treesitter.ensure_installed = {
  "bash",
  "c",
  "css",
  "json",
  "java",
  "javascript",
  "lua",
  "python",
  "rust",
  "typescript",
  "yaml",
}

lvim.builtin.treesitter.ignore_install = { "haskell" }
lvim.builtin.treesitter.highlight.enabled = true

lvim.builtin.treesitter.autotag.enable = true
lvim.builtin.treesitter.context_commentstring.enable = true
lvim.builtin.treesitter.indent.disable = {}
lvim.builtin.treesitter.matchup.enable = true
lvim.builtin.treesitter.rainbow.enable = true
lvim.builtin.treesitter.playground.enable = true
lvim.builtin.treesitter.textsubjects.enable = true

lvim.builtin.cmp.confirm_opts.select = true

-- generic LSP settings

---@usage disable automatic installation of servers
lvim.lsp.automatic_servers_installation = false

---@usage Select which servers should be configured manually. Requires `:LvimCacheRest` to take effect.
-- See the full default list `:lua print(vim.inspect(lvim.lsp.override))`
vim.list_extend(lvim.lsp.override, { "rust" })

vim.list_extend(lvim.lsp.override, { "clangd" })

-- some settings can only passed as commandline flags `clangd --help`
local clangd_flags = {
  "--all-scopes-completion",
  "--suggest-missing-includes",
  "--background-index",
  "--pch-storage=disk",
  "--cross-file-rename",
  "--log=info",
  "--completion-style=detailed",
  "--enable-config", -- clangd 11+ supports reading from .clangd configuration file
  "--clang-tidy",
  -- "--clang-tidy-checks=-*,llvm-*,clang-analyzer-*,modernize-*,-modernize-use-trailing-return-type",
  -- "--fallback-style=Google",
  -- "--header-insertion=never",
  -- "--query-driver=<list-of-white-listed-complers>"
}

local clangd_bin = "clangd"

local custom_on_attach = function(client, bufnr)
  require("lvim.lsp").common_on_attach(client, bufnr)
  local opts = { noremap = true, silent = true }
  vim.api.nvim_buf_set_keymap(bufnr, "n", "<leader>lh", "<Cmd>ClangdSwitchSourceHeader<CR>", opts)
end

local clangd_opts = {
  cmd = { clangd_bin, unpack(clangd_flags) },
  on_attach = custom_on_attach,
}

require("lvim.lsp.manager").setup("clangd", clangd_opts)

vim.list_extend(lvim.lsp.override, { "pyright" })

---@usage setup a server -- see: https://www.lunarvim.org/languages/#overriding-the-default-configuration
local pyright_opts = {} -- check the lspconfig documentation for a list of all possible options
require("lvim.lsp.manager").setup("pyright", pyright_opts)

-- you can set a custom on_attach function that will be used for all the language servers
-- See <https://github.com/neovim/nvim-lspconfig#keybindings-and-completion>
lvim.lsp.on_attach_callback = function(_, bufnr)
  local function buf_set_option(...)
    vim.api.nvim_buf_set_option(bufnr, ...)
  end
  --Enable completion triggered by <c-x><c-o>
  buf_set_option("omnifunc", "v:lua.vim.lsp.omnifunc")
end
-- you can overwrite the null_ls setup table (useful for setting the root_dir function)
lvim.lsp.null_ls.setup.root_dir = require("lspconfig").util.root_pattern("Makefile", ".git", "node_modules")
-- or if you need something more advanced
-- lvim.lsp.null_ls.setup.root_dir = function(fname)
--   if vim.bo.filetype == "javascript" then
--     return require("lspconfig/util").root_pattern("Makefile", ".git", "node_modules")(fname)
--       or require("lspconfig/util").path.dirname(fname)
--   elseif vim.bo.filetype == "php" then
--     return require("lspconfig/util").root_pattern("Makefile", ".git", "composer.json")(fname) or vim.fn.getcwd()
--   else
--     return require("lspconfig/util").root_pattern("Makefile", ".git")(fname) or require("lspconfig/util").path.dirname(fname)
--   end
-- end

-- set a formatter, this will override the language server formatting capabilities (if it exists)
local formatters = require "lvim.lsp.null-ls.formatters"
formatters.setup {
  { exe = "black", filetypes = { "python" } },
  { exe = "isort", filetypes = { "python" } },
  { exe = "autopep8", filetypes = { "python" } },
  {
    exe = "prettier",
    ---@usage arguments to pass to the formatter
    -- these cannot contain whitespaces, options such as `--line-width 80` become either `{'--line-width', '80'}` or `{'--line-width=80'}`
    args = { "--print-with", "100" },
    ---@usage specify which filetypes to enable. By default a providers will attach to all the filetypes it supports.
    filetypes = { "typescript", "typescriptreact" },
  },
}

-- set additional linters
local linters = require "lvim.lsp.null-ls.linters"
linters.setup {
  { exe = "flake8", filetypes = { "python" } },
  {
    exe = "shellcheck",
    ---@usage arguments to pass to the formatter
    -- these cannot contain whitespaces, options such as `--line-width 80` become either `{'--line-width', '80'}` or `{'--line-width=80'}`
    args = { "--severity", "warning" },
  },
  {
    exe = "codespell",
    ---@usage specify which filetypes to enable. By default a providers will attach to all the filetypes it supports.
    filetypes = { "javascript", "python" },
  },
}

-- Additional Plugins
lvim.plugins = {
  { "folke/tokyonight.nvim" },
  --{
  --  "farmergreg/vim-lastplace",
  --  config = function ()
  --    vim.g.lastplace_ignore = "gitcommit,gitrebase,svn,hgcommit"
  --    vim.g.lastplace_ignore_buftype = "quickfix,nofile,help"
  --  end
  --},
  {
    "folke/trouble.nvim",
    cmd = "TroubleToggle",
  },
  {
    "simrat39/rust-tools.nvim",
      config = function()
      require("rust-tools").setup({
        tools = {
          autoSetHints = true,
          hover_with_actions = true,
          runnables = {
            use_telescope = true,
          },
        },
        server = {
          cmd = { "rust-analyzer" },
          on_attach = require("lvim.lsp").common_on_attach,
          on_init = require("lvim.lsp").common_on_init,
        },
      })
    end,
    ft = { "rust", "rs" },
  },
  {
    "phaazon/hop.nvim",
    event = "BufRead",
    config = function()
      require("hop").setup()
      vim.api.nvim_set_keymap("n", "s", ":HopChar2<cr>", { silent = true })
      vim.api.nvim_set_keymap("n", "S", ":HopWord<cr>", { silent = true })
    end,
  },
  {
    "nacro90/numb.nvim",
    event = "BufRead",
    config = function()
    require("numb").setup {
      show_numbers = true, -- Enable 'number' for the window while peeking
      show_cursorline = true, -- Enable 'cursorline' for the window while peeking
    }
    end,
  },
  {
    "kevinhwang91/nvim-bqf",
    event = { "BufRead", "BufNew" },
    config = function()
    require("bqf").setup({
      auto_enable = true,
      preview = {
        win_height = 12,
        win_vheight = 12,
        delay_syntax = 80,
        border_chars = { "┃", "┃", "━", "━", "┏", "┓", "┗", "┛", "█" },
      },
      func_map = {
        vsplit = "",
        ptogglemode = "z,",
        stoggleup = "",
      },
      filter = {
        fzf = {
          action_for = { ["ctrl-s"] = "split" },
          extra_opts = { "--bind", "ctrl-o:toggle-all", "--prompt", "> " },
        },
      },
    })
    end,
  },
  {
    "windwp/nvim-spectre",
    event = "BufRead",
    config = function()
      require("spectre").setup()
      local opts = { noremap = true, silent = true }
      vim.api.nvim_set_keymap("n", "<leader>R", "<cmd>lua require 'spectre'.open()<CR>", opts) -- Open
      vim.api.nvim_set_keymap("n", "<leader>rw", "<cmd>lua require 'spectre'.open_visual({select_word=true})<CR>", opts) -- Current word
      vim.api.nvim_set_keymap("n", "<leader>r", "<cmd>lua require 'spectre'.open_visual()<CR>", opts) -- Search all files
      vim.api.nvim_set_keymap("n", "<leader>rp", "<cmd>lua require 'spectre'.open_file_search()<CR>", opts) -- Search in current file
    end,
  },
  {
    "andymass/vim-matchup",
    event = "CursorMoved",
    config = function()
      vim.g.matchup_matchparen_offscreen = { method = "popup" }
    end,
  },
	{
	  "windwp/nvim-ts-autotag",
	  event = "InsertEnter",
	  config = function()
	    require("nvim-ts-autotag").setup()
	  end,
	},
  {
    "p00f/nvim-ts-rainbow",
    event = "BufRead",
  },
  {
    "folke/lsp-colors.nvim",
    event = "BufRead",
  },
  {
    "ahmedkhalf/lsp-rooter.nvim",
    event = "BufRead",
    config = function()
      require("lsp-rooter").setup()
    end,
  },
  {
    "ray-x/lsp_signature.nvim",
    event = "BufRead",
    config = function()
      require "lsp_signature".setup()
    end
  },
  {
    "ethanholz/nvim-lastplace",
    event = "BufRead",
    config = function()
      require("nvim-lastplace").setup({
        lastplace_ignore_buftype = { "quickfix", "nofile", "help" },
        lastplace_ignore_filetype = {
        "gitcommit", "gitrebase", "svn", "hgcommit",
        },
        lastplace_open_folds = true,
      })
    end,
  },
  {
    "folke/todo-comments.nvim",
    event = "BufRead",
    config = function()
      require("todo-comments").setup()
    end,
  },
  {
    "tpope/vim-repeat",
    event = "BufRead",
  },
  {
    "felipec/vim-sanegx",
    event = "BufRead",
  },
  {
    "jackguo380/vim-lsp-cxx-highlight",
    ft = { "c", "cpp", "objc" }
  },
  {
    "fladson/vim-kitty",
    ft = { "kitty"}
  },
  --[[ {
    'rafi/vim-venom',
    ft = { 'python' },
    config = function()
      require("venom").setup()
    end
  }]]--
  {
    'petobens/poet-v',
    ft = { "python" }
  },
  {
    'saecki/crates.nvim',
    event = "BufRead Cargo.toml",
    config = function()
      require('crates').setup()
      -- require('crates').setup()
    end,
  },
  {
    'sudormrfbin/cheatsheet.nvim',
    config = function ()
      require("cheatsheet").setup({
        -- Whether to show bundled cheatsheets

        -- For generic cheatsheets like default, unicode, nerd-fonts, etc
        -- bundled_cheatsheets = {
        --     enabled = {},
        --     disabled = {},
        -- },
        bundled_cheatsheets = true,

        -- For plugin specific cheatsheets
        -- bundled_plugin_cheatsheets = {
        --     enabled = {},
        --     disabled = {},
        -- }
        bundled_plugin_cheatsheets = true,

        -- For bundled plugin cheatsheets, do not show a sheet if you
        -- don't have the plugin installed (searches runtimepath for
        -- same directory name)
        include_only_installed_plugins = true,

        -- Key mappings bound inside the telescope window
        telescope_mappings = {
            ['<C-CR>'] = require('cheatsheet.telescope.actions').select_or_fill_commandline,
            ['<CR>'] = require('cheatsheet.telescope.actions').select_or_execute,
            ['<C-Y>'] = require('cheatsheet.telescope.actions').copy_cheat_value,
            ['<C-E>'] = require('cheatsheet.telescope.actions').edit_user_cheatsheet,
        }
      })
    end
  },
  {
    'stevearc/dressing.nvim',
    event = "VimEnter",
    config = function ()
      require('dressing').setup()
    end
  },
  {
    's1n7ax/nvim-terminal',
    event = "VimEnter",
    config = function()
      local Terminal = require('nvim-terminal.terminal')
      local Window = require('nvim-terminal.window')

      local window = Window:new({
      	position = 'botright',
      	split = 'sp',
      	width = 50,
      	height = 15
      })

      terminal = Terminal:new(window)

      local silent = { silent = true }

      vim.api.nvim_set_keymap('n', '<M-T>', ':lua terminal:toggle()<cr>', silent)
      vim.api.nvim_set_keymap('n', '<leader>1', ':lua terminal:open(1)<cr>', silent)
      vim.api.nvim_set_keymap('n', '<leader>2', ':lua terminal:open(2)<cr>', silent)
      vim.api.nvim_set_keymap('n', '<leader>3', ':lua terminal:open(3)<cr>', silent)
      vim.api.nvim_set_keymap('n', '<leader>4', ':lua terminal:open(4)<cr>', silent)
    end,
  },
  {
    'sindrets/diffview.nvim',
    event = "VimEnter",
  },
  {
    "McAuleyPenney/tidy.nvim",
    event = "BufWritePre"
  },
  {
    "lilydjwg/fcitx.vim",
    event = "BufReadPost",
    config = function ()
      vim.g.fcitx_remote = "/usr/bin/fcitx5-remote"
    end
  },
  {
    "beauwilliams/focus.nvim",
    config = function()
      require("focus").setup({
        autoresize = true,
        excluded_buftypes = {"help"},
        excluded_filetypes = {"toggleterm"},
      })
    end
  }
}

-- vim.cmd([[
--  "let &t_SI = "\<Esc>]50;CursorShape=1\x7"
--  "let &t_SR = "\<Esc>]50;CursorShape=1\x7"
--  "let &t_EI = "\<Esc>]50;CursorShape=1\x7"
--
--  set guicursor=n-v-c-sm:block,i-ci-ve:ver25-Cursor,r-cr-o:hor20
-- ]])

-- Autocommands (https://neovim.io/doc/user/autocmd.html)
lvim.autocommands.custom_groups = {
  { "BufEnter", "*.lua", "setlocal ts=2 sw=2" },
  { "VimEnter", "*", "startinsert | stopinsert" },
  { "VimEnter", "*", "normal! :startinsert :stopinsert" },
  { "VimEnter", "*", ":normal :startinsert :stopinsert" },
  { "VimEnter", "*", "redraw!" },
  { "VimEnter", "*", [[ silent !echo -ne "\e[2 q" ]] },
  { "VimLeave", "*", [[ silent !echo -ne "\e[6 q" ]] },
}

vim.opt.completeopt = { "menuone", "preview" }
vim.opt.fileencoding = "utf-8" -- the encoding written to a file
vim.opt.foldmethod = "manual" -- folding set to "expr" for treesitter based folding
vim.opt.foldexpr = "nvim_treesitter#foldexpr()" -- for treesitter based folding
vim.opt.hidden = true -- required to keep multiple buffers and open multiple buffers
vim.opt.hlsearch = true -- highlight all matches on previous search pattern
vim.opt.ignorecase = true -- ignore case in search patterns
vim.opt.mouse = "a" -- allow the mouse to be used in neovim
vim.opt.pumheight = 10 -- pop up menu height
vim.opt.showmode = true -- we don't need to see things like -- INSERT -- anymore
vim.opt.showtabline = 2 -- always show tabs
vim.opt.smartcase = true -- smart case
vim.opt.smartindent = true -- make indenting smarter again
vim.opt.splitbelow = true -- force all horizontal splits to go below current window
vim.opt.splitright = true -- force all vertical splits to go to the right of current window
vim.opt.swapfile = true -- creates a swapfile
vim.opt.termguicolors = true -- set term gui colors (most terminals support this)
vim.opt.timeoutlen = 100 -- time to wait for a mapped sequence to complete (in milliseconds)
vim.opt.title = true -- set the title of window to the value of the titlestring
-- vim.opt.titlestring = "%<%F%=%l/%L - nvim" -- what the title of the window will be set to
-- vim.opt.undodir = vim.fn.stdpath "cache" .. "/undo"
vim.opt.undofile = false -- enable persistent undo
vim.opt.updatetime = 300 -- faster completion
vim.opt.writebackup = false -- if a file is being edited by another program (or was written to file while editing with another program) it is not allowed to be edited
vim.opt.expandtab = true -- convert tabs to spaces
vim.opt.shiftwidth = 4 -- the number of spaces inserted for each indentation
vim.opt.tabstop = 4 -- insert 2 spaces for a tab
vim.opt.cursorline = true -- highlight the current line
vim.opt.number = true -- set numbered lines
vim.opt.relativenumber = true -- set relative numbered lines
vim.opt.numberwidth = 4 -- set number column width to 2 {default 4}
vim.opt.signcolumn = "yes" -- always show the sign column otherwise it would shift the text each time
vim.opt.wrap = false -- display lines as one long line
vim.opt.spell = false
vim.opt.scrolloff = 8 -- is one of my fav
vim.opt.sidescrolloff = 8
vim.opt.whichwrap = "<,>,[,],b,s"
