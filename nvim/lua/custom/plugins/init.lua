return {
  ["goolord/alpha-nvim"] = {
    disable = false,
  },
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
    }
  },
  ["lewis6991/gitsigns.nvim"] = {
    after = { "folke/which-key.nvim" },
    config = function()
      local cfgs = require("custom.plugins.configs.gitsigns")
      require("gitsigns").setup(cfgs)
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
      local configs = require("custom.plugins.configs.neotree")
      require("neo-tree").setup(configs)
    end
  },
  ["JoosepAlviste/nvim-ts-context-commentstring"] = {
    module = "ts_context_commentstring",
  },
  ["romgrk/nvim-treesitter-context"] = {
    disable = true,
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
  ["folke/which-key.nvim"] = {
    config = function()
      local opts = require("custom.plugins.configs.whichkey")
      require("which-key").setup({
        -- your configuration comes here
        -- or leave it empty to use the default settings
        -- refer to the configuration section below
        triggers_blacklist = {
          -- list of mode / prefixes that should never be hooked by WhichKey
          -- this is mostly relevant for key maps that start with a native binding
          -- most people should not need to change this
          i = { "j", "k", "l", "h", "o" },
          n = { "j", "k", "l", "h", "o" },
          v = { "j", "k", "l", "h", "o" },
        },
      })
      require('legendary').setup({
        autocmds = opts.autocmds,
        commands = opts.commands,
      })
      vim.keymap.set(
        { "n", "v", 'o', 'x' },
        "<C-p>",
        ":lua require('legendary').find()<CR>",
        { desc = "legendary - search keymaps, commands, and autocmds" }
      )
      require("which-key").register(opts.keymaps.n, { mode = "n" })
    end
  },
  ["mrjones2014/legendary.nvim"] = {
    before = "folke/which-key.nvim",
  },
  ['editorconfig/editorconfig-vim'] = {
    event = "BufReadPost",
    config = function()
      vim.cmd [[ au FileType gitcommit let b:EditorConfig_disable = 1 ]]
    end
  },
  ['nvim-lualine/lualine.nvim'] = {
    after = "nvim-web-devicons",
    requires = {
      { 'arkav/lualine-lsp-progress', opt = true },
    },
    config = function()
      require("custom.plugins.configs.lualine").setup()
    end
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
    event = "BufReadPost",
    requires = { { 'nvim-lua/plenary.nvim', opt = true } },
  },
  ['mhinz/vim-grepper'] = {
    opt = true,
    before = "kevinhwang91/nvim-bqf",
    setup = function()
      vim.cmd(([[
        aug Grepper
          au!
          au User Grepper ++nested %s
        aug END
      ]]):format([[call setqflist([], 'r', {'context': {'bqf': {'pattern_hl': '\%#' . getreg('/')}}})]]))

      -- try `gsiw` under word
      vim.cmd([[
        nmap gs <plug>(GrepperOperator)
        xmap gs <plug>(GrepperOperator)
      ]])
    end
  },
  ["kevinhwang91/nvim-bqf"] = {
    event = "BufReadPost",
    commands = { "BqfToggle", "BqfAutoToggle" },
    requires = {
      { 'nvim-treesitter/nvim-treesitter', opt = true },
      { 'neoclide/coc.nvim', opt = true },
      { 'mhinz/vim-grepper', opt = true },
    },
    setup = function()
      local jump_to_localtion = function(locs)
        locs = locs or vim.g.coc_jump_locations
        vim.fn.setloclist(0, {}, ' ', { title = 'CocLocationList', items = locs })
        local winid = vim.fn.getloclist(0, { winid = 0 }).winid
        if winid == 0 then
          vim.cmd('abo lw')
        else
          vim.api.nvim_set_current_win(winid)
        end
      end

      local diagnostic = function()
        vim.fn.CocActionAsync('diagnosticList', '', function(err, res)
          if err == vim.NIL then
            local items = {}
            for _, d in ipairs(res) do
              local text = ('[%s%s] %s'):format((d.source == '' and 'coc.nvim' or d.source),
                (d.code == vim.NIL and '' or ' ' .. d.code), d.message:match('([^\n]+)\n*'))
              local item = {
                filename = d.file,
                lnum = d.lnum,
                end_lnum = d.end_lnum,
                col = d.col,
                end_col = d.end_col,
                text = text,
                type = d.severity
              }
              table.insert(items, item)
            end
            vim.fn.setqflist({}, ' ', { title = 'CocDiagnosticList', items = items })

            vim.cmd('bo cope')
          end
        end)
      end

      _G.jump_to_localtion = jump_to_localtion
      vim.cmd([[
        aug Coc
            au!
            au User CocLocationsChange lua _G.jump_to_localtion()
        aug END
      ]])
      vim.keymap.set("n", "<leader>qd", diagnostic, { silent = true, noremap = true })
    end,
    config = function()
      require("bqf").setup({
        auto_enable = true,
        auto_resize_height = true, -- highly recommended enable
      })
    end,
  },
  ['gelguy/wilder.nvim'] = {
    disable = true,
    requires = {
      { "kyazdani42/nvim-web-devicons" },
      { 'romgrk/fzy-lua-native' },
    },
    event = "BufReadPost",
    config = function()
      vim.cmd [[
        call wilder#setup({
          \ 'modes': [':'],
          \ 'next_key': '<Tab>',
          \ 'previous_key': '<S-Tab>',
          \ 'accept_key': '<Down>',
          \ 'reject_key': '<Up>',
          \ })

        let s:highlighters = [
          \ wilder#pcre2_highlighter(),
          \ wilder#lua_fzy_highlighter(),
          \ ]

        let s:popupmenu_renderer = wilder#popupmenu_renderer(wilder#popupmenu_border_theme({
          \ 'empty_message': wilder#popupmenu_empty_message_with_spinner(),
          \ 'highlighter': s:highlighters,
          \ 'max_height': 20,
          \ 'left': [
          \   ' ',
          \   wilder#popupmenu_devicons(),
          \   wilder#popupmenu_buffer_flags({
          \     'flags': ' a + ',
          \     'icons': {'+': '', 'a': '', 'h': ''},
          \   }),
          \ ],
          \ 'right': [
          \   ' ',
          \   wilder#popupmenu_scrollbar(),
          \ ],
          \ }))

        let s:wildmenu_renderer = wilder#wildmenu_renderer({
          \ 'highlighter': s:highlighters,
          \ 'separator': ' · ',
          \ 'left': [' ', wilder#wildmenu_spinner(), ' '],
          \ 'right': [' ', wilder#wildmenu_index()],
          \ })

        call wilder#set_option('renderer', wilder#renderer_mux({
          \ ':': s:popupmenu_renderer,
          \ '/': s:wildmenu_renderer,
          \ 'substitute': s:wildmenu_renderer,
          \ }))
      ]]
    end
  },
  ['saecki/crates.nvim'] = {
    event = { "BufRead Cargo.toml" },
    requires = { 'nvim-lua/plenary.nvim' },
    config = function()
      require('crates').setup()
    end,
  },
  ["neoclide/coc.nvim"] = {
    branch = 'release',
    event = "BufReadPost",
    requires = {
      -- vim
      { 'Shougo/neco-vim', opt = true },
      { 'neoclide/coc-neco', opt = true },
      -- snippet
      { 'SirVer/ultisnips', opt = true },
      { 'honza/vim-snippets', opt = true },
      { 'neoclide/coc-snippets', opt = true },
    },
    setup = function()
      require("custom.plugins.configs.coc").setup()
    end
  }
}
