-- use a HTTP proxy for downloading the parsers
require("nvim-treesitter.install").command_extra_args = {
  curl = { "--proxy", "http://127.0.0.1:1087" },
}

-- MAPPINGS
local map = require("core.utils").map

map("n", "<leader>cc", ":Telescope <CR>")
map("n", "<leader>q", ":q <CR>")

-- AUTOCMDS
require("custom.autocmds")
