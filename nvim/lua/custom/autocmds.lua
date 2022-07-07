vim.api.nvim_create_autocmd(
  "BufReadPost",
  { pattern = "Cargo.toml", command = "set expandtab tabstop=4 shiftwidth=4 softtabstop=4" }
)

-- vim.api.nvim_create_autocmd(
--   "BufEnter",
--   {
--   callback = function()
--     if vim.api.nvim_buf_get_option(0, "buftype") ~= "terminal" then
--       vim.cmd "lcd %:p:h"
--     end
--   end,
-- }
-- )

-- Highlight yanked text
vim.api.nvim_create_autocmd("TextYankPost", {
  pattern = "*",
  callback = function()
    vim.highlight.on_yank { higroup = "Visual", timeout = 200 }
  end,
})

-- Enable spellchecking in markdown, text and gitcommit files
vim.api.nvim_create_autocmd("FileType", {
  pattern = { "gitcommit", "markdown", "text" },
  callback = function()
    vim.opt_local.spell = true
  end,
})

-- vim.cmd [[
--   augroup NEOTREE_AUGROUP
--     autocmd!
--     au VimEnter * lua vim.defer_fn(function() vim.cmd("Neotree show left") end, 10)
--   augroup END
-- ]]


-- function leave_snippet()
--   if ((vim.v.event.old_mode == 's' and vim.v.event.new_mode == 'n') or vim.v.event.old_mode == 'i')
--       and require('luasnip').session.current_nodes[vim.api.nvim_get_current_buf()]
--       and not require('luasnip').session.jump_active
--   then
--     require('luasnip').unlink_current()
--   end
-- end

-- stop snippets when you leave to normal mode
-- vim.api.nvim_command([[
--     autocmd ModeChanged * lua leave_snippet()
-- ]])
