local M = {}

M.signs = {
  add          = { hl = 'GitSignsAdd', text = '│', numhl = 'GitSignsAddNr', linehl = 'GitSignsAddLn' },
  change       = { hl = 'GitSignsChange', text = '│', numhl = 'GitSignsChangeNr', linehl = 'GitSignsChangeLn' },
  delete       = { hl = 'GitSignsDelete', text = '', numhl = 'GitSignsDeleteNr', linehl = 'GitSignsDeleteLn' },
  topdelete    = { hl = 'GitSignsDelete', text = '‾', numhl = 'GitSignsDeleteNr', linehl = 'GitSignsDeleteLn' },
  changedelete = { hl = 'GitSignsChange', text = '', numhl = 'GitSignsChangeNr', linehl = 'GitSignsChangeLn' },
}

M.on_attach = function(bufnr)
  local gs = package.loaded.gitsigns

  local function map(mode, l, r, opts)
    opts = opts or {}
    opts.buffer = bufnr
    vim.keymap.set(mode, l, r, opts)
  end

  -- Navigation
  map('n', ']c', function()
    if vim.wo.diff then return ']c' end
    vim.schedule(function() gs.next_hunk() end)
    return '<Ignore>'
  end, { expr = true, desc = 'next hunk' })

  map('n', '[c', function()
    if vim.wo.diff then return '[c' end
    vim.schedule(function() gs.prev_hunk() end)
    return '<Ignore>'
  end, { expr = true, desc = 'prev hunk' })

  -- Actions
  map({ 'n', 'v' }, '<leader>gs', ':Gitsigns stage_hunk<CR>', { desc = "git stage hunk" })
  map({ 'n', 'v' }, '<leader>gr', ':Gitsigns reset_hunk<CR>', { desc = "git reset hunk" })
  map('n', '<leader>gS', gs.stage_buffer, { desc = "git stage buffer" })
  map('n', '<leader>gu', gs.undo_stage_hunk, { desc = "git undo stage hunk" })
  map('n', '<leader>gR', gs.reset_buffer, { desc = "git reset buffer" })
  map('n', '<leader>gp', gs.preview_hunk, { desc = "git preview hunk" })
  map('n', '<leader>gb', function() gs.blame_line { full = true } end, { desc = "git blame line" })
  map('n', '<leader>gB', gs.toggle_current_line_blame, { desc = "toggle current line blame" })
  map('n', '<leader>gd', gs.diffthis, { desc = "diff this" })
  map('n', '<leader>gD', function() gs.diffthis('~') end, { desc = "diff this ~" })
  -- map('n', '<leader>gD', gs.toggle_deleted)

  -- Text object
  map({ 'o', 'x' }, 'ih', ':<C-U>Gitsigns select_hunk<CR>', { desc = "select hunk" })
end

return M
