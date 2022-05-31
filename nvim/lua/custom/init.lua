-- use a HTTP proxy for downloading the parsers
require("nvim-treesitter.install").command_extra_args = {
  curl = { "--proxy", "http://127.0.0.1:1087" },
}

vim.o.clipboard = "unnamedplus"
vim.o.directory = "."
vim.o.shortmess:append("c")

vim.o.guifont = "Monaco:h11"

-- AUTOCMDS
require("custom.autocmds")
