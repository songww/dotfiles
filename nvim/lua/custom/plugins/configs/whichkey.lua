local M = {}

M.autocmds = {
  {
    'FileType',
    ':setlocal conceallevel=0',
    opts = {
      pattern = { 'json', 'jsonc' },
    },
  },
  {
    { 'BufRead', 'BufNewFile' },
    ':set filetype=jsonc',
    opts = {
      pattern = { '*.jsonc', 'tsconfig*.json', 'coc-settings.json' },
    },
  },
  -- {
  --   'BufWritePre',
  --   vim.lsp.buf.formatting_sync,
  --   -- include a description to execute it
  --   -- like a command on-demand from the finder
  --   description = 'Format on write with LSP',
  -- },
  {
    { "BufWinEnter", "BufRead", "BufNewFile" },
    ":setlocal formatoptions-=c formatoptions-=r formatoptions-=o",
    description = 'format options.',
  },
  -- {
  --   "DiagnosticChanged",
  --   [[ :lua require('trouble').refresh({ auto = true, provider = "diagnostics" }) ]],
  -- },
  {
    "TextYankPost",
    require("legendary.helpers").lazy(require('vim.highlight').on_yank, {higroup = 'Search', timeout = 200}),
  },
  { "VimResized", ":tabdo wincmd =", description = "will cause split windows to be resized evenly if main window is resized" },
  { "FileType", ":nnoremap <silent> <buffer> q :close<CR>", opts = { pattern = { "lspinfo", "lsp-installer", "null-ls-info" } }, description = "general lsp" },
}

M.commands = {
  { ':TroubleToggle', description = "toggle trouble" },
  { ':TroubleRefresh', description = "refresh trouble" },
  { ':Trouble', description = "Trouble <args>", unfinished = true },
  { ':RustToggleInlayHints', description = "toggle rust inlay hints" },
  { ':RustRunnables', description = "rust runnables" },
  { ':RustDebuggables', description = "rust debuggables" },
  { ':RustExpandMacro', description = "rust expand macro" },
  { ':RustOpenCargo', description = "rust open Cargo.toml" },
  { ':RustParentModule', description = "rust parent mod" },
  { ':RustHoverActions', description = "rust hover actions" },
  { ':RustViewCrateGraph', description = "crate graph" },
  { ':RustReloadWorkspace', description = "reload workspace" },
  { ':GitNextHunk', "&diff ? ']c' : '<cmd>Gitsigns next_hunk<CR>'", description = "gitsigns next hunk", {expr=true} },
  { ':GitPrevHunk', "&diff ? ']c' : '<cmd>Gitsigns prev_hunk<CR>'", description = "gitsigns prev hunk", {expr=true} },
  { ':GitStageHunk', ':Gitsigns stage_hunk<CR>', description = "gitsigns stage hunk" },
}

M.keymaps = {
  n = {
    ["<leader>pk"] = { [[ <cmd>lua require('legendary').find('keymaps')<CR> ]], "legendary - search keymaps" },
    ["<leader>pc"] = { [[ <cmd>lua require('legendary').find('commands')<CR> ]], "legendary - search commands" },
    ["<leader>pa"] = { [[ <cmd>lua require('legendary').find('autocmds')<CR> ]], "legendary - search autocmds" },
  },

  v = {
  },

  o = {
    -- Text object
  },

  x = {
    -- Text object
  }
}

return M
