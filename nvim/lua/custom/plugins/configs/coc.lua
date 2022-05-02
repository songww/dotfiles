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
  }

  vim.g.coc_status_error_sign = ''
  vim.g.coc_status_warning_sign = ''

  -- json comments highlight
  vim.api.nvim_create_autocmd("Filetype", {
    pattern = "json",
    command = "syntax match Comment +//.+$+"
  })
  --vim.cmd [[
  --  autocmd FileType json syntax match Comment +\/\/.\+$+
  --]]

  vim.cmd [[
        " Use tab for trigger completion with characters ahead and navigate.
        " NOTE: Use command ':verbose imap <tab>' to make sure tab is not mapped by
        " other plugin before putting this into your config.
        inoremap <silent><expr> <TAB>
              \ pumvisible() ? "\<C-n>" :
              \ Helper_check_backspace() ? "\<TAB>" :
              \ coc#refresh()
        inoremap <expr><S-TAB> pumvisible() ? "\<C-p>" : "\<C-h>"
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

  vim.g.coc_snippet_next = '<Tab>'

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
          if (index(['vim','help'], &filetype) >= 0)
            execute 'h '.expand('<cword>')
          elseif (coc#rpc#ready())
            call CocActionAsync('doHover')
          else
            execute '!' . &keywordprg . " " . expand('<cword>')
          endif
        endfunction

        " Highlight the symbol and its references when holding the cursor.
        autocmd CursorHold * silent call CocActionAsync('highlight')

        " Symbol renaming.
        nmap <Leader>lr <Plug>(coc-rename)

        " Formatting selected code.
        xmap <A-f>  <Plug>(coc-format-selected)
        nmap <A-f>  <Plug>(coc-format-selected)

        " Remap keys for applying codeAction to the current buffer.
        nmap <Leader>ac  <Plug>(coc-codeaction)
        " Apply AutoFix to problem on the current line.
        nmap <Leader>qf  <Plug>(coc-fix-current)
        
        " Run the Code Lens action on the current line.
        nmap <Leader>cl  <Plug>(coc-codelens-action)
        
        " Use <Leader>-s for selections ranges.
        " Requires 'textDocument/selectionRange' support of language server.
        nmap <silent> <Leader>s <Plug>(coc-range-select)
        xmap <silent> <Leader>s <Plug>(coc-range-select)

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
        nnoremap <silent><nowait> <Leader>s  :<C-u>CocList -I symbols<cr>
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
end

return M
