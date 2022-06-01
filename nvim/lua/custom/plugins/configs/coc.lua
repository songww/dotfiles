local M = {}

M.setup = function()
  vim.g.coc_enable_locationlist = 0

  vim.g.coc_global_extensions = {
    'coc-json',
    'coc-prettier',
    'coc-calc',
    'coc-clangd',
    'coc-pyright',
    'coc-cmake',
    'coc-sh',
    'coc-rust-analyzer',
    'coc-sumneko-lua',
    'coc-tabnine',
    'coc-toml',
    'coc-yaml',
    'coc-yank',
    'coc-esbonio',
  }

  vim.g.coc_status_error_sign = ''
  vim.g.coc_status_warning_sign = ''

  vim.cmd [[
    " Use tab for trigger completion with characters ahead and navigate.
    " NOTE: Use command ':verbose imap <tab>' to make sure tab is not mapped by
    " other plugin before putting this into your config.
    " inoremap <silent><expr> <TAB>
    "       \ pumvisible() ? "\<C-n>" :
    "       \ Helper_check_backspace() ? "\<TAB>" :
    "       \ coc#refresh()
    " inoremap <expr><S-TAB> pumvisible() ? "\<C-p>" : "\<C-h>"
    "inoremap <silent><expr> <TAB>
    "  \ pumvisible() ? coc#_select_confirm() :
    "  \ coc#expandableOrJumpable() ? "\<C-r>=coc#rpc#request('doKeymap', ['snippets-expand-jump',''])\<CR>" :
    "  \ Helper_check_backspace() ? "\<TAB>" :
    "  \ coc#refresh()
    
    function! Helper_check_backspace() abort
      let col = col('.') - 1
      return !col || getline('.')[col - 1]  =~# '\s'
    endfunction
    
  ]]

  vim.g.coc_snippet_next = '<C-n>'
  vim.g.coc_snippet_prev = '<C-p>'

  -- Use <cr> to confirm completion
  --[[
  vim.cmd [[
        " Make <CR> auto-select the first completion item and notify coc.nvim to
        " format on enter, <cr> could be remapped by other vim plugin
        inoremap <silent><expr> <CR> pumvisible() ? coc#_select_confirm() : "\<C-g>u\<CR>\<c-r>=coc#on_enter()\<CR>"
      ]] --
  vim.keymap.set(
    "i",
    "<CR>",
    [[pumvisible() ? coc#_select_confirm() : "<C-g>u<CR><c-r>=coc#on_enter()<CR>"]],
    { expr = true, silent = true, noremap = true }
  )

  -- use <C-p>for trigger completion
  -- vim.cmd [[
  -- inoremap <silent><expr> <C-p> coc#refresh()
  -- ]]
  vim.keymap.set("i", "<C-p>", "coc#refresh()", { expr = true, silent = true, noremap = true })

  vim.cmd [[
    " Use `[g` and `]g` to navigate diagnostics
    " Use `:CocDiagnostics` to get all diagnostics of current buffer in location list.
    nmap <silent> [g <Plug>(coc-diagnostic-prev)
    nmap <silent> ]g <Plug>(coc-diagnostic-next)

    " GoTo code navigation.
    nmap <silent> gd <Plug>(coc-definition)
    nmap <silent> gD <Plug>(coc-type-definition)
    nmap <silent> gI <Plug>(coc-implementation)
    nmap <silent> gr <Plug>(coc-references)

    " Use K to show documentation in preview window.
    nnoremap <silent> K :call Helper_show_documentation()<CR>

    function! Helper_show_documentation()
      if CocAction('hasProvider', 'hover')
        call CocActionAsync('doHover')
      else
        call feedkeys('K', 'in')
      endif
    endfunction

    " Highlight the symbol and its references when holding the cursor.
    autocmd CursorHold * silent call CocActionAsync('highlight')

    " Symbol renaming.
    nmap <Leader>lr <Plug>(coc-rename)

    " Formatting selected code.
    xmap <Leader>lf  <Plug>(coc-format-selected)
    nmap <Leader>lf  <Plug>(coc-format-selected)

    augroup mygroup
      autocmd!
      " Setup formatexpr specified filetype(s).
      autocmd FileType typescript,json setl formatexpr=CocAction('formatSelected')
      " Update signature help on jump placeholder.
      autocmd User CocJumpPlaceholder call CocActionAsync('showSignatureHelp')
    augroup end

    " Applying codeAction to the selected region.
    " Example: `<leader>aap` for current paragraph
    xmap <leader>ac  <Plug>(coc-codeaction-selected)
    nmap <leader>ac  <Plug>(coc-codeaction-selected)

    " Remap keys for applying codeAction to the current buffer.
    nmap <Leader>ac  <Plug>(coc-codeaction)
    " Apply AutoFix to problem on the current line.
    nmap <Leader>qf  <Plug>(coc-fix-current)
    
    " Run the Code Lens action on the current line.
    nmap <Leader>ca  <Plug>(coc-codelens-action)
    
    " Map function and class text objects
    " NOTE: Requires 'textDocument.documentSymbol' support from the language server.
    xmap if <Plug>(coc-funcobj-i)
    omap if <Plug>(coc-funcobj-i)
    xmap af <Plug>(coc-funcobj-a)
    omap af <Plug>(coc-funcobj-a)
    xmap ic <Plug>(coc-classobj-i)
    omap ic <Plug>(coc-classobj-i)
    xmap ac <Plug>(coc-classobj-a)
    omap ac <Plug>(coc-classobj-a)

    " Remap <C-f> and <C-b> for scroll float windows/popups.
    if has('nvim-0.4.0') || has('patch-8.2.0750')
      nnoremap <silent><nowait><expr> <C-f> coc#float#has_scroll() ? coc#float#scroll(1) : "\<C-f>"
      nnoremap <silent><nowait><expr> <C-b> coc#float#has_scroll() ? coc#float#scroll(0) : "\<C-b>"
      inoremap <silent><nowait><expr> <C-f> coc#float#has_scroll() ? "\<c-r>=coc#float#scroll(1)\<cr>" : "\<Right>"
      inoremap <silent><nowait><expr> <C-b> coc#float#has_scroll() ? "\<c-r>=coc#float#scroll(0)\<cr>" : "\<Left>"
      vnoremap <silent><nowait><expr> <C-f> coc#float#has_scroll() ? coc#float#scroll(1) : "\<C-f>"
      vnoremap <silent><nowait><expr> <C-b> coc#float#has_scroll() ? coc#float#scroll(0) : "\<C-b>"
    endif

    " Add `:Format` command to format current buffer.
    command! -nargs=0 Format :call CocActionAsync('format')
    
    " Add `:Fold` command to fold current buffer.
    command! -nargs=? Fold :call     CocAction('fold', <f-args>)
    
    " Add `:OR` command for organize imports of the current buffer.
    command! -nargs=0 OR   :call     CocActionAsync('runCommand', 'editor.action.organizeImport')

    " Mappings for CoCList
    " Show all diagnostics.
    " nnoremap <silent><nowait> <Leader>qd  :<C-u>CocList diagnostics<cr>
    " Manage extensions.
    nnoremap <silent><nowait> <Leader>ext  :<C-u>CocList extensions<cr>
    " Show commands.
    nnoremap <silent><nowait> <Leader>cmd  :<C-u>CocList commands<cr>
    " Find symbol of current document.
    nnoremap <silent><nowait> <Leader>ol  :<C-u>CocList outline<cr>
    " Search workspace symbols.
    nnoremap <silent><nowait> <Leader>sym  :<C-u>CocList -I symbols<cr>
    " Do default action for next item.
    nnoremap <silent><nowait> <Leader>j  :<C-u>CocNext<CR>
    " Do default action for previous item.
    nnoremap <silent><nowait> <Leader>k  :<C-u>CocPrev<CR>
    " Resume latest coc list.
    nnoremap <silent><nowait> <Leader>cr  :<C-u>CocListResume<CR>
  ]]

  -- autocmd FileType * let b:coc_trim_final_newlines = 1
  vim.api.nvim_create_autocmd(
    "FileType",
    { pattern = "*", command = "let b:coc_trim_final_newlines = 1" }
  )
  -- autocmd FileType * let b:coc_trim_trailing_whitespace = 1
  vim.api.nvim_create_autocmd(
    "FileType",
    { pattern = "*", command = "let b:coc_trim_trailing_whitespace = 1" }
  )

  -- notifications
  vim.api.nvim_create_autocmd("User", { pattern = "CocDiagnosticChange", callback = M.diagnostic_notify })
  -- vim.api.nvim_create_autocmd("User", { pattern = "CocStatusChange", callback = M.status_notify })
  vim.api.nvim_create_autocmd("User", { pattern = "CocNvimInit", callback = M.coc_init })
end

function M.config()
  local function coc_notify(msg, level)
    local notify_opts = { title = "LSP Message", timeout = 500 }
    vim.notify(msg, level, notify_opts)
  end
end

M.coc_diag_record = {}
M.coc_status_record = {}

function M.coc_status_notify(msg, level)
  local next = next
  local notify_opts = { title = "LSP Status", timeout = 500, hide_from_history = true, on_close = M.reset_coc_status_record }
  -- if coc_status_record is not {} then add it to notify_opts to key called "replace"
  if next(M.coc_status_record) ~= nil then
    notify_opts["replace"] = M.coc_status_record.id
  end
  M.coc_status_record = vim.notify(msg, level, notify_opts)
end

function M.reset_coc_status_record(window)
  M.coc_status_record = {}
end

function M.coc_diag_notify(msg, level)
  local notify_opts = { title = "LSP Diagnostics", timeout = 500, on_close = M.reset_coc_diag_record }
  -- if coc_diag_record is not {} then add it to notify_opts to key called "replace"
  if next(M.coc_diag_record) ~= nil then
    notify_opts["replace"] = M.coc_diag_record.id
  end
  M.coc_diag_record = vim.notify(msg, level, notify_opts)
end

function M.reset_coc_diag_record(window)
  M.coc_diag_record = {}
end

function M.diagnostic_notify()
  local next = next
  local info = vim.b.coc_diagnostic_info or {}
  if info == nil then return '' end
  if next(info) == nil then return '' end
  local msgs = {}
  local level = 'info'
  if info.warning ~= nil then
    level = 'warn'
  end
  if info.error ~= nil then
    level = 'error'
  end

  if info.error ~= nil then
    table.insert(msgs, string.format(' Errors: %s', info['error']))
  end
  if info.warning ~= nil then
    table.insert(msgs, string.format(' Warnings: %s', info['warning']))
  end
  if info.information ~= nil then
    table.insert(msgs, string.format(' Infos: %s', info['information']))
  end
  if info.hint ~= nil then
    table.insert(msgs, string.format(' Hints: %s', info['hint']))
  end
  local msg = table.concat(msgs, "\n")
  if msg == '' or msg == nil then
    msg = ' All OK'
  end
  M.coc_diag_notify(msg, level)
end

function M.status_notify()
  local status = vim.g.coc_status
  if status == nil then return '' else end
  local level = 'info'
  M.coc_status_notify(status, level)
end

function M.coc_init()
  vim.notify('Initialized coc.nvim for LSP support', 'info', { title = 'CoC' })
end

return M
