local M = {}

M.on_attach = function(bufnr)
  local gs = require("gitsigns")
  local wk = require("which-key")

  local function map(mode, l, r, opts)
    opts = opts or {}
    opts.buffer = bufnr
    vim.keymap.set(mode, l, r, opts)
  end

  -- Navigation
  map('n', ']c', "&diff ? ']c' : '<cmd>Gitsigns next_hunk<CR>'", { expr = true })
  map('n', '[c', "&diff ? '[c' : '<cmd>Gitsigns prev_hunk<CR>'", { expr = true })

  wk.register(
    {
      -- Actions
      h = {
        s = { ':Gitsigns stage_hunk<CR>', "gitsigns stage hunk" },
        r = { ':Gitsigns reset_hunk<CR>', "gitsigns reset hunk" },
      }
    },
    { mode = { 'n', 'v' }, prefix = "<leader>", buffer = bufnr }
  )
  wk.register(
    {
      -- Actions
      h = {
        S = { gs.stage_buffer, "gitsigns stage buffer" },
        u = { gs.undo_stage_hunk, "gitsigns undo stage hunk" },
        R = { gs.reset_buffer, "gitsigns reset buffer" },
        p = { gs.preview_hunk, "gitsigns preview hunk" },
        b = { function() gs.blame_line { full = true } end, "gitsigns blame" },
        d = { gs.diffthis, "gitsigns diffthis" },
        D = { function() gs.diffthis('~') end, "gitsigns diffthis(~)" }
      },
      t = {
        b = { gs.toggle_current_line_blame, "gitsigns toggle line blame" },
        d = { gs.toggle_deleted, "gitsigns toggle deleted" },
      }
    },
    { mode = 'n', prefix = "<leader>", buffer = bufnr }
  )
  wk.register(
    {
      i = {
        h = { ':<C-U>Gitsigns select_hunk<CR>', "gitsigns select hunk" }
      }
    },
    { mode = { 'o', 'x' }, buffer = bufnr }
  )
end
