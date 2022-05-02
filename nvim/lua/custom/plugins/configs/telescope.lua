local actions = require "telescope.actions"

return {
  defaults = {
    mappings = {
      i = {
        ["<C-j>"] = actions.move_selection_next,
        ["<C-k>"] = actions.move_selection_previous,

        ["<C-c>"] = actions.close,

        ["<Down>"] = actions.move_selection_next,
        ["<Up>"] = actions.move_selection_previous,

        ["<CR>"] = actions.select_default,
        ["<C-x>"] = actions.select_horizontal,
        ["<C-v>"] = actions.select_vertical,
        ["<C-t>"] = actions.select_tab,

        ["<C-u>"] = actions.preview_scrolling_up,
        ["<C-d>"] = actions.preview_scrolling_down,

        ["<PageUp>"] = actions.results_scrolling_up,
        ["<PageDown>"] = actions.results_scrolling_down,

        ["<Tab>"] = actions.toggle_selection + actions.move_selection_worse,
        ["<S-Tab>"] = actions.toggle_selection + actions.move_selection_better,
        ["<C-q>"] = actions.send_to_qflist + actions.open_qflist,
        ["<M-q>"] = actions.send_selected_to_qflist + actions.open_qflist,
        ["<C-l>"] = actions.complete_tag,
        ["<C-_>"] = actions.which_key, -- keys from pressing <C-/>
        ["<C-w>"] = { "<c-s-w>", type = "command" },
      },

      n = {
        ["<esc>"] = actions.close,
        ["<CR>"] = actions.select_default,
        ["<C-x>"] = actions.select_horizontal,
        ["<C-v>"] = actions.select_vertical,
        ["<C-t>"] = actions.select_tab,

        ["<Tab>"] = actions.toggle_selection + actions.move_selection_worse,
        ["<S-Tab>"] = actions.toggle_selection + actions.move_selection_better,
        ["<C-q>"] = actions.send_to_qflist + actions.open_qflist,
        ["<M-q>"] = actions.send_selected_to_qflist + actions.open_qflist,

        -- TODO: This would be weird if we switch the ordering.
        ["j"] = actions.move_selection_next,
        ["k"] = actions.move_selection_previous,
        ["H"] = actions.move_to_top,
        ["M"] = actions.move_to_middle,
        ["L"] = actions.move_to_bottom,

        ["<Down>"] = actions.move_selection_next,
        ["<Up>"] = actions.move_selection_previous,
        ["gg"] = actions.move_to_top,
        ["G"] = actions.move_to_bottom,

        ["<C-u>"] = actions.preview_scrolling_up,
        ["<C-d>"] = actions.preview_scrolling_down,

        ["<PageUp>"] = actions.results_scrolling_up,
        ["<PageDown>"] = actions.results_scrolling_down,

        ["?"] = actions.which_key,
      },
    },
  },
  extensions = {
    command_palette = {
      {"File",
        { "entire selection (C-a)", ':call feedkeys("GVgg")' },
        { "save current file (C-s)", ':w' },
        { "save all files (C-A-s)", ':wa' },
        { "quit (C-q)", ':qa' },
        { "file browser (C-i)", ":lua require'telescope'.extensions.file_browser.file_browser()", 1 },
        { "search word (A-w)", ":lua require('telescope.builtin').live_grep()", 1 },
        { "git files (A-f)", ":lua require('telescope.builtin').git_files()", 1 },
        { "files (C-f)",     ":lua require('telescope.builtin').find_files()", 1 },
      },
      {"Help",
        { "tips", ":help tips" },
        { "cheatsheet", ":help index" },
        { "tutorial", ":help tutor" },
        { "summary", ":help summary" },
        { "quick reference", ":help quickref" },
        { "search help(F1)", ":lua require('telescope.builtin').help_tags()", 1 },
      },
      {"Vim",
        { "reload vimrc", ":source $MYVIMRC" },
        { 'check health', ":checkhealth" },
        { "jumps (Alt-j)", ":lua require('telescope.builtin').jumplist()" },
        { "commands", ":lua require('telescope.builtin').commands()" },
        { "command history", ":lua require('telescope.builtin').command_history()" },
        { "registers (A-e)", ":lua require('telescope.builtin').registers()" },
        { "colorshceme", ":lua require('telescope.builtin').colorscheme()", 1 },
        { "vim options", ":lua require('telescope.builtin').vim_options()" },
        { "keymaps", ":lua require('telescope.builtin').keymaps()" },
        { "buffers", ":Telescope buffers" },
        { "search history (C-h)", ":lua require('telescope.builtin').search_history()" },
        { "paste mode", ':set paste!' },
        { 'cursor line', ':set cursorline!' },
        { 'cursor column', ':set cursorcolumn!' },
        { "spell checker", ':set spell!' },
        { "relative number", ':set relativenumber!' },
        { "search highlighting (F12)", ':set hlsearch!' },
      },
      -- {"Trouble",
      --   { "toggle trouble", ":TroubleToggle<cr>" },
      --   { "workspace diagnostics", ":Trouble workspace_diagnostics<cr>" },
      --   { "document diagnostics", ":Trouble document_diagnostics<cr>" },
      --   { "quickfix", ":Trouble quickfix<cr>" },
      --   { "locklist", ":Trouble locklist<cr>" },
      --   { "references", ":Trouble lsp_references<cr>" },
      -- },
      -- {"Dap",
      --   { "pause", ":lua require'dap'.pause()" },
      --   { "step into", ":lua require'dap'.step_into()" },
      --   { "step back", ":lua require'dap'.step_back()" },
      --   { "step over", ":lua require'dap'.step_over()" },
      --   { "step out", ":lua require'dap'.step_out()" },
      --   { "frames", ":lua require'telescope'.extensions.dap.frames{}" },
      --   { "current scopes", ":lua ViewCurrentScopes(); vim.cmd(\"wincmd w|vertical resize 40\")" },
      --   { "current scopes floating window", ":lua ViewCurrentScopesFloatingWindow()" },
      --   { "current value floating window", ":lua ViewCurrentValueFloatingWindow()" },
      --   { "commands", ":lua require'telescope'.extensions.dap.commands{}" },
      --   { "configurations", ":lua require'telescope'.extensions.dap.configurations{}" },
      --   { "repl", ":lua require'dap'.repl.open(); vim.cmd(\"wincmd w|resize 12\")" },
      --   { "close", ":lua require'dap'.close(); require'dap'.repl.close()" },
      --   { "run to cursor", ":lua require'dap'.run_to_cursor()" },
      --   { "continue", ":lua require'dap'.continue()" },
      --   { "clear breakpoints", ":lua require('dap.breakpoints').clear()" },
      --   { "brakpoints", ":lua require'telescope'.extensions.dap.list_breakpoints{}" },
      --   { "toggle breakpoint", ":lua require'dap'.toggle_breakpoint()" },
      -- },
      {"Git",
        { "next hunk", ":Gitsigns next_hunk<CR>" },
        { "prev hunk", ":Gitsigns prev_hunk<CR>" },
        { "stage hunk", ":Gitsigns stage_hunk<CR>" },
        { "reset hunk", ":Gitsigns reset_hunk<CR>" },
        { "stage buffer", ":Gitsigns stage_buffer<CR>" },
        { "undo stage buffer", ":Gitsigns undo_stage_hunk<CR>" },
        { "reset buffer", ":Gitsigns reset_buffer<CR>" },
        { "preview hunk", ":Gitsigns preview_hunk<CR>" },
        { "blame", ":lua require('gitsigns').blame_line{full=true}" },
        { "current line blame toggle", ":Gitsigns toggle_current_line_blame<CR>" },
        { "diff this", ":Gitsigns diffthis<CR>" },
        { "diff this ~", ":lua require('gitsigns').diffthis('~')<CR>" },
        { "toggle deleted", ":Gitsigns toggle_deleted<CR>" },
        { "select hunk", ":Gitsigns select_hunk<CR>" },
      }
    }
  }
}
