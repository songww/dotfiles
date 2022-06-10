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
    client.resolved_capabilities.document_formatting = true
    client.resolved_capabilities.document_range_formatting = true
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

--[[
→ Lua.IntelliSense.traceBeSetted     default: false
        → Lua.IntelliSense.traceFieldInject  default: false
        → Lua.IntelliSense.traceLocalSet     default: false
        → Lua.IntelliSense.traceReturn       default: false
        → Lua.completion.autoRequire         default: true
        → Lua.completion.callSnippet         default: "Disable"
        → Lua.completion.displayContext      default: 0
        → Lua.completion.enable              default: true
        → Lua.completion.keywordSnippet      default: "Replace"
        → Lua.completion.postfix             default: "@"
        → Lua.completion.requireSeparator    default: "."
        → Lua.completion.showParams          default: true
        → Lua.completion.showWord            default: "Fallback"
        → Lua.completion.workspaceWord       default: true
        → Lua.diagnostics.disable
        → Lua.diagnostics.disableScheme      default: ["git"]
        → Lua.diagnostics.enable             default: true
        → Lua.diagnostics.globals
        → Lua.diagnostics.ignoredFiles       default: "Opened"
        → Lua.diagnostics.libraryFiles       default: "Opened"
        → Lua.diagnostics.neededFileStatus
        → Lua.diagnostics.severity
        → Lua.diagnostics.workspaceDelay     default: 3000
        → Lua.diagnostics.workspaceRate      default: 100
        → Lua.format.defaultConfig
        → Lua.format.enable                  default: true
        → Lua.hint.arrayIndex                default: "Auto"
        → Lua.hint.enable                    default: false
        → Lua.hint.paramName                 default: "All"
        → Lua.hint.paramType                 default: true
        → Lua.hint.setType                   default: false
        → Lua.hover.enable                   default: true
        → Lua.hover.enumsLimit               default: 5
        → Lua.hover.previewFields            default: 20
        → Lua.hover.viewNumber               default: true
        → Lua.hover.viewString               default: true
        → Lua.hover.viewStringMax            default: 1000
        → Lua.misc.parameters
        → Lua.runtime.builtin
        → Lua.runtime.fileEncoding           default: "utf8"
        → Lua.runtime.nonstandardSymbol
        → Lua.runtime.path                   default: ["?.lua","?\/init.lua"]
        → Lua.runtime.pathStrict             default: false
        → Lua.runtime.plugin                 default: ""
        → Lua.runtime.special
        → Lua.runtime.unicodeName            default: false
        → Lua.runtime.version                default: "Lua 5.4"
        → Lua.semantic.annotation            default: true
        → Lua.semantic.enable                default: true
        → Lua.semantic.keyword               default: false
        → Lua.semantic.variable              default: true
        → Lua.signatureHelp.enable           default: true
        → Lua.telemetry.enable               default: null
        → Lua.window.progressBar             default: true
        → Lua.window.statusBar               default: true
        → Lua.workspace.checkThirdParty      default: true
        → Lua.workspace.ignoreDir            default: [".vscode"]
        → Lua.workspace.ignoreSubmodules     default: true
        → Lua.workspace.library
        → Lua.workspace.maxPreload           default: 5000
        → Lua.workspace.preloadFileSize      default: 500
        → Lua.workspace.supportScheme        default: ["file","untitled","git"]
        → Lua.workspace.useGitIgnore         default: true
        → Lua.workspace.userThirdParty


        → json.colorDecorators.enable  default: true
        → json.format.enable           default: true
        → json.maxItemsComputed        default: 5000
        → json.schemaDownload.enable   default: true
        → json.schemas
        → json.trace.server            default: "off"
        → json.validate.enable         default: true


        → pyright.disableLanguageServices              default: false
        → pyright.disableOrganizeImports               default: false
        → python.analysis.autoImportCompletions        default: true
        → python.analysis.autoSearchPaths              default: true
        → python.analysis.diagnosticMode               default: "openFilesOnly"
        → python.analysis.diagnosticSeverityOverrides
        → python.analysis.extraPaths                   default: []
        → python.analysis.logLevel                     default: "Information"
        → python.analysis.stubPath                     default: "typings"
        → python.analysis.typeCheckingMode             default: "basic"
        → python.analysis.typeshedPaths                default: []
        → python.analysis.useLibraryCodeForTypes       default: false
        → python.pythonPath                            default: "python"
        → python.venvPath                              default: ""

]]
