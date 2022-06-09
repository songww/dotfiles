-- use a HTTP proxy for downloading the parsers
require("nvim-treesitter.install").command_extra_args = {
  curl = { "--proxy", "http://127.0.0.1:1087" },
}

vim.o.guifont = "Monaco:h13"

vim.o.ruler = true
vim.o.clipboard = "unnamedplus"
vim.o.directory = "."
vim.opt.shortmess:append({ c = true })

-- AUTOCMDS
require("custom.autocmds")
