local M = {}

M.setup = function()
  local dap, dapui = require("dap"), require("dapui")

  local api = vim.api
  local keymap_restore = {}
  dap.listeners.after['event_initialized']['me'] = function()
    for _, buf in pairs(api.nvim_list_bufs()) do
      local keymaps = api.nvim_buf_get_keymap(buf, 'n')
      for _, keymap in pairs(keymaps) do
        if keymap.lhs == "K" then
          table.insert(keymap_restore, keymap)
          api.nvim_buf_del_keymap(buf, 'n', 'K')
        end
      end
    end
    vim.keymap.set({ "n" }, "K", function() require("dap.ui.widgets").hover() end, { silent = true })
  end

  dap.listeners.after['event_terminated']['me'] = function()
    for _, keymap in pairs(keymap_restore) do
      api.nvim_buf_set_keymap(
        keymap.buffer,
        keymap.mode,
        keymap.lhs,
        keymap.rhs,
        { silent = keymap.silent == 1 }
      )
    end
    keymap_restore = {}
  end

  dap.listeners.after.event_initialized["dapui_config"] = function()
    dapui.open()
  end
  dap.listeners.before.event_terminated["dapui_config"] = function()
    dapui.close()
  end
  dap.listeners.before.event_exited["dapui_config"] = function()
    dapui.close()
  end

  vim.keymap.set(
    "n",
    "<Leader>dc",
    function() require "dap".continue() end,
    { noremap = true, silent = true, buffer = true }
  )

  vim.keymap.set(
    "v", "<M-k>",
    function()
      require("dapui").eval()
    end,
    { noremap = true, buffer = true }
  )

end

return M
