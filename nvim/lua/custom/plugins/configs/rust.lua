local extension_path = vim.env.HOME .. "/.vscode/extensions/vadimcn.vscode-lldb-1.6.10/"
local codelldb_path = extension_path .. 'adapter/codelldb'
local liblldb_path = extension_path .. 'lldb/lib/liblldb.so'

local M = {
  tools = {
    autoSetHints = true,
    hover_with_actions = true,
    executor = require("rust-tools/executors").termopen,
  },
  server = {
    standalone = false,
    settings = {
      ["rust-analyzer"] = {}
    }
  },
  dap = {
    adapter = require('rust-tools.dap').get_codelldb_adapter(codelldb_path, liblldb_path)
  },
}

return M
