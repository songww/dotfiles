vim.o.guifont = "Monaco:h13"

vim.o.ruler = true
vim.o.clipboard = "unnamedplus"
vim.o.directory = "."
-- vim.o.shortmess:append({ c = true })

vim.g.python3_host_program = "python3"

-- AUTOCMDS
require("custom.autocmds")
