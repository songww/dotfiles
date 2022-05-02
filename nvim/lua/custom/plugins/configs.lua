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

M.treesitter = {
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

M.nvimtree = {
  git = {
    enable = true,
  },
}

M.gitsigns = {
  signs = {
    add = { hl = "DiffAdd", text = "▎", numhl = "GitSignsAddNr", linehl = "GitSignsAddLn" },
    change = { hl = "DiffChange", text = "▎", numhl = "GitSignsChangeNr", linehl = "GitSignsChangeLn" },
    delete = { hl = "DiffDelete", text = "契", numhl = "GitSignsDeleteNr", linehl = "GitSignsDeleteLn" },
    topdelete = { hl = "DiffDelete", text = "契", numhl = "GitSignsDeleteNr", linehl = "GitSignsDeleteLn" },
    changedelete = { hl = "DiffChangeDelete", text = "▎", numhl = "GitSignsChangeNr", linehl = "GitSignsChangeLn" },
  },
  signcolumn = true,
  current_line_blame = true,
  current_line_blame_opts = {
    virt_text = true,
    virt_text_pos = 'eol', -- 'eol' | 'overlay' | 'right_align'
    delay = 1000,
    ignore_whitespace = false,
  },
}

--[[
local _, cmp = pcall(require, "cmp")

M.cmp = {
  mapping = {
    ["C-p"] = nil,
    ["C-n"] = nil,
    ["C-Space"] = nil,
    ["<C-k>"] = cmp.mapping.select_prev_item(),
    ["<C-j>"] = cmp.mapping.select_next_item(),
    ["<C-P>"] = cmp.mapping.complete(),
  },
  sources = {
    { name = "nvim_lsp" },
    { name = "luasnip" },
    { name = "path" },
    { name = "buffer" },
    { name = "cmdline" },
    { name = "nvim_lua" },
    { name = "cmp_tabnine" },
    { name = "emoji" },
    { name = "treesitter" },
    { name = "crates" },
  },
}
]] --

return M
