vim.api.nvim_create_autocmd(
  "BufReadPost",
  { pattern = "Cargo.toml", command = "set tabstop=4 shiftwidth=4" }
)

vim.api.nvim_create_autocmd(
  "BufEnter",
  {
  callback = function()
    if vim.api.nvim_buf_get_option(0, "buftype") ~= "terminal" then
      vim.cmd "lcd %:p:h"
    end
  end,
}
)

-- Highlight yanked text
vim.api.nvim_create_autocmd("TextYankPost", {
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
