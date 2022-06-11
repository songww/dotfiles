local M = {}

M.setup = function()
  local trouble = require('trouble')
  trouble.setup({
    action_keys = { -- key mappings for actions in the trouble list
      -- map to {} to remove a mapping, for example:
      -- close = {},
      close = "q", -- close the list
      cancel = "<esc>", -- cancel the preview and get back to your last window / buffer / cursor
      refresh = "r", -- manually refresh
      jump = { "<cr>", "<tab>" }, -- jump to the diagnostic or open / close folds
      open_split = { "<c-x>" }, -- open buffer in new split
      open_vsplit = { "<c-v>" }, -- open buffer in new vsplit
      open_tab = { "<c-t>" }, -- open buffer in new tab
      jump_close = { "o" }, -- jump to the diagnostic and close the list
      toggle_mode = "m", -- toggle between "workspace" and "document" diagnostics mode
      toggle_preview = "P", -- toggle auto_preview
      hover = "K", -- opens a small popup with the full multiline message
      preview = "p", -- preview the diagnostic location
      close_folds = { "zM", "zm" }, -- close all folds
      open_folds = { "zR", "zr" }, -- open all folds
      toggle_fold = { "zA", "za" }, -- toggle fold of current file
      previous = "k", -- preview item
      next = "j" -- next item
    },
    indent_lines = false, -- add an indent guide below the fold icons
    auto_open = true, -- automatically open the list when you have diagnostics
    auto_close = false, -- automatically close the list when you have no diagnostics
    use_diagnostic_signs = true -- enabling this will use the signs defined in your lsp client
  })

  vim.keymap.set(
    "n",
    "<Leader>tr",
    function() trouble.toggle() end,
    { silent = true, noremap = true, desc = "toggle trouble" }
  )
  vim.keymap.set(
    "n",
    "<Leader>tw",
    function() trouble.open("workspace_diagnostics") end,
    { silent = true, noremap = true, desc = "trouble workspace diagnostics" }
  )
  vim.keymap.set(
    "n",
    "<Leader>td",
    function() trouble.open("document_diagnostics") end,
    { silent = true, noremap = true, desc = "trouble document diagnostics" }
  )
  vim.keymap.set(
    "n",
    "<Leader>tl",
    function() trouble.open("loclist") end,
    { silent = true, noremap = true, desc = "trouble loclist" }
  )
  vim.keymap.set(
    "n",
    "<Leader>tq",
    function() trouble.open("quickfix") end,
    { silent = true, noremap = true, desc = "trouble quickfix" }
  )
  vim.keymap.set(
    "n",
    "gR",
    function() trouble.open("lsp_references") end,
    { silent = true, noremap = true, desc = "trouble lsp references" }
  )
end

return M
