local M = {}

M.pyright = {
  settings = {
    python = {
      venvPath = '.venv',
      analysis = {
        autoSearchPaths = true,
        diagnosticMode = "workspace",
        useLibraryCodeForTypes = true
      }
    }
  }
}
M.sumneko_lua = {
  settings = {
    Lua = {
      runtime = {
        -- Tell the language server which version of Lua you're using (most likely LuaJIT in the case of Neovim)
        version = 'LuaJIT',
      },
      completion = {
        callSnippet = "Both",
        displayContext = 10,
        keywordSnippet = "Both",
      },
      diagnostics = {
        globals = { "vim" },
      },
      workspace = {
        library = {
          [vim.fn.expand "$VIMRUNTIME/lua"] = true,
          [vim.fn.expand "$VIMRUNTIME/lua/vim/lsp"] = true,
        },
        maxPreload = 100000,
        preloadFileSize = 10000,
      },
      -- Do not send telemetry data containing a randomized but unique identifier
      telemetry = {
        enable = false,
      },
      hint = {
        enable = true,
        setType = true,
      }
    },
  }
}

M.setup_lsp = function(attach, capabilities)
  local lspconfig = require("lspconfig")

  local on_attach = function(client, bufnr)
    attach(client, bufnr)
    require("nvim-navic").attach(client, bufnr)
    local version = vim.version()
    if version.major == 0 and version.minor <= 7 then
      client.resolved_capabilities.document_formatting = true
      client.resolved_capabilities.document_range_formatting = true
    else
      client.server_capabilities.documentFormattingProvider = true
      client.server_capabilities.documentRangeFormattingProvider = true
    end
  end

  lspconfig.pyright.setup({
    on_attach = on_attach,
    capabilities = capabilities,
    settings = M.pyright.settings,
  })

  lspconfig.sumneko_lua.setup({
    on_attach = on_attach,
    capabilities = capabilities,
    settings = M.sumneko_lua.settings
  })

  lspconfig.jsonls.setup({
    on_attach = on_attach,
    capabilities = capabilities,
    init_options = {
      provideFormatter = false,
    }
  })

  require("custom.plugins.configs.rust").setup(on_attach)

  require("custom.plugins.configs.clangd").setup(on_attach)

end

return M
