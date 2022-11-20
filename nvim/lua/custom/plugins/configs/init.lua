local M = {}

M.comment = {
  pre_hook = function(ctx)
    local U = require 'Comment.utils'

    -- Determine whether to use linewise or blockwise commentstring
    local type = ctx.ctype == U.ctype.line and '__default' or '__multiline'

    local location = nil
    if ctx.ctype == U.ctype.block then
      location = require('ts_context_commentstring.utils').get_cursor_location()
    elseif ctx.cmotion == U.cmotion.v or ctx.cmotion == U.cmotion.V then
      location = require('ts_context_commentstring.utils').get_visual_start_location()
    end

    return require('ts_context_commentstring.internal').calculate_commentstring({
      key = type,
      location = location,
    })
  end,
}

M.treesitter = function()
  -- use a HTTP proxy for downloading the parsers
  require("nvim-treesitter.install").command_extra_args = {
    curl = { "--proxy", "http://127.0.0.1:1087" },
  }
  return {
    ensure_installed = {
      "c",
      "cpp",
      "go",
      "rst",
      "lua",
      "tsx",
      "vue",
      "vim",
      "css",
      "scss",
      "html",
      "yaml",
      "toml",
      "rust",
      "slint",
      "json",
      "jsonc",
      "python",
      "graphql",
      "markdown",
      "dockerfile",
      "javascript",
      "typescript",
    },
    indent = {
      enable = true
    },
    rainbow = {
      enable = true,
    },
    matchup = {
      enable = true,
    },
    highlight = {
      enable = true,
      use_languagetree = true,
    },
    textobjects = {
      select = {
        enable = true,
      },
      swap = {
        enable = true,
      },
      move = {
        enable = true,
        set_jumps = true, -- whether to set jumps in the jumplist
      }
    },
    context_commentstring = {
      enable = true,
      enable_autocmd = false,
    },
  }
end

M.bufferline = {
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

M.signature = {
  -- toggle_key = "<M-k>", -- toggle signature on and off in insert mode
  doc_lines = 10,
}

M.installer = {
  ensure_installed = { "lua-language-server", "rust_analyzer", "pyright", "jsonls" },
  automatic_installation = false,
}

M.whichkey = {
  triggers_blacklist = {
    -- list of mode / prefixes that should never be hooked by WhichKey
    -- this is mostly relevant for key maps that start with a native binding
    -- most people should not need to change this
    i = { "j", "k", "l", "h", "o" },
    n = { "j", "k", "l", "h", "o" },
    v = { "j", "k", "l", "h", "o" },
  },
}

return M
