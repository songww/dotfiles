vim.g.python3_host_program = "python3"

vim.o.guifont = "Monaco:h13"

vim.o.ruler = true
vim.o.clipboard = "unnamedplus"
vim.o.directory = "."
-- vim.o.shortmess:append({ c = true })

vim.o.whichwrap = "<,>,[,],b,s"
vim.o.backspace = "indent,eol,start"
vim.o.signcolumn = "yes"
vim.o.pumheight = 10
vim.o.cursorline = true -- highlight the current line
vim.o.wrap = false -- display lines as one long line
vim.o.spell = false
vim.o.number = true
vim.o.relativenumber = true

vim.o.fileencoding = "utf-8" -- the encoding written to a file
vim.o.foldmethod = "manual" -- folding set to "expr" for treesitter based folding
vim.o.foldexpr = "nvim_treesitter#foldexpr()" -- for treesitter based folding
vim.o.splitbelow = true -- force all horizontal splits to go below current window
vim.o.splitright = true -- force all vertical splits to go to the right of current window
vim.o.swapfile = true -- creates a swapfile
vim.o.title = true -- set the title of window to the value of the titlestring
vim.o.undofile = false -- enable persistent undo
vim.o.expandtab = true -- convert tabs to spaces

-- use filetype.lua instead of filetype.vim
vim.g.do_filetype_lua = 1
vim.g.did_load_filetypes = 0

vim.g.matchup_matchparen_enabled = 1
vim.g.matchup_matchparen_offscreen = { method = 'popup' }

vim.cmd([[
  set cursorlineopt=both
  set cursorcolumn
]])

-- AUTOCMDS
require("custom.autocmds")
