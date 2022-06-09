-- Update this path
local extension_path = vim.env.HOME .. '/.vscode/extensions/vadimcn.vscode-lldb-1.7.0/'
local codelldb_path = extension_path .. 'adapter/codelldb'
local liblldb_path = extension_path .. 'lldb/lib/liblldb.so'

local opts = {
  -- debugging stuff
  dap = {
    adapter = require('rust-tools.dap').get_codelldb_adapter(codelldb_path, liblldb_path)
  },

  tools = { -- rust-tools options
    -- automatically set inlay hints (type hints)
    -- There is an issue due to which the hints are not applied on the first
    -- opened file. For now, write to the file to trigger a reapplication of
    -- the hints or just run :RustSetInlayHints.
    -- default: true
    autoSetHints = true,

    -- whether to show hover actions inside the hover window
    -- this overrides the default hover handler so something like lspsaga.nvim's hover would be overriden by this
    -- default: true
    hover_with_actions = true,

    -- how to execute terminal commands
    -- options right now: termopen / quickfix
    executor = require("rust-tools/executors").termopen,

    -- callback to execute once rust-analyzer is done initializing the workspace
    -- The callback receives one parameter indicating the `health` of the server: "ok" | "warning" | "error"
    on_initialized = nil,

    -- These apply to the default RustSetInlayHints command
    inlay_hints = {

      -- Only show inlay hints for the current line
      only_current_line = false,

      -- Event which triggers a refersh of the inlay hints.
      -- You can make this "CursorMoved" or "CursorMoved,CursorMovedI" but
      -- not that this may cause higher CPU usage.
      -- This option is only respected when only_current_line and
      -- autoSetHints both are true.
      only_current_line_autocmd = "CursorHold",

      -- whether to show parameter hints with the inlay hints or not
      -- default: true
      show_parameter_hints = true,

      -- whether to show variable name before type hints with the inlay hints or not
      -- default: false
      show_variable_name = true,

      -- prefix for parameter hints
      -- default: "<-"
      parameter_hints_prefix = "<- ",

      -- prefix for all the other hints (type, chaining)
      -- default: "=>"
      other_hints_prefix = "=> ",

      -- whether to align to the lenght of the longest line in the file
      max_len_align = false,

      -- padding from the left if max_len_align is true
      max_len_align_padding = 1,

      -- whether to align to the extreme right or not
      right_align = false,

      -- padding from the right if right_align is true
      right_align_padding = 7,

      -- The color of the hints
      highlight = "Comment",
    },

    -- options same as lsp hover / vim.lsp.util.open_floating_preview()
    hover_actions = {
      -- the border that is used for the hover window
      -- see vim.api.nvim_open_win()
      border = {
        { "╭", "FloatBorder" },
        { "─", "FloatBorder" },
        { "╮", "FloatBorder" },
        { "│", "FloatBorder" },
        { "╯", "FloatBorder" },
        { "─", "FloatBorder" },
        { "╰", "FloatBorder" },
        { "│", "FloatBorder" },
      },

      -- whether the hover action window gets automatically focused
      -- default: false
      auto_focus = false,
    },

    -- settings for showing the crate graph based on graphviz and the dot
    -- command
    crate_graph = {
      -- Backend used for displaying the graph
      -- see: https://graphviz.org/docs/outputs/
      -- default: x11
      backend = "gtk",
      -- where to store the output, nil for no output stored (relative
      -- path from pwd)
      -- default: nil
      output = nil,
      -- true for all crates.io and external crates, false only the local
      -- crates
      -- default: true
      full = true,

      -- List of backends found on: https://graphviz.org/docs/outputs/
      -- Is used for input validation and autocompletion
      -- Last updated: 2021-08-26
      enabled_graphviz_backends = {
        "gtk",
        "jpeg",
        "json",
        "png",
        "svg",
        "webp",
        "x11",
      },
    },
  },

  -- all the opts to send to nvim-lspconfig
  -- these override the defaults set by rust-tools.nvim
  -- see https://github.com/neovim/nvim-lspconfig/blob/master/doc/server_configurations.md#rust_analyzer
  server = {
    -- standalone file support
    -- setting it to false may improve startup time
    standalone = true,
    settings = {
      ["rust-analyzer"] = {
        cargo = {
          -- target = "all",
          features = "all",
          autoreload = true,
        },
        checkOnSave = {
          enable            = true,
          features          = "all",
          allTargets        = true,
          noDefaultFeatures = false,
        },
        cachePriming = {
          enable = true,
        },
        completion = {
          privateEditable = { enable = true },
        },
        diagnostics = {
          experimental = { enable = true },
        },
        hover = {
          links = { enable = true },
          actions = {
            references = {
              enable = false
            }
          },
        },
        imports = {
          granularity = {
            enforce = false,
            group = "module",
          },
          merge = { glob = false },
          prefix = "crate"
        },
        inlayHints = {
          enable = true,
          bindingModeHints = { enable = true },
          closingBraceHints = { minLines = 1 },
          closureReturnTypeHints = { enable = "always" },
          lifetimeElisionHints = {
            enable = "always",
            useParameterNames = true,
          },
          reborrowHints = { enable = "always" },
          renderColons = true,
          refershOnInsertMode = true,
          typeHints = {
            enable = true,
            hideNamedConstructor = false,
          },
        },
        rustfmt = {
          rangeFormatting = { enable = true }
        },
        typing = {
          autoClosingAngleBrackets = {
            enable = true
          }
        }
      }
    }
  }, -- rust-analyzer options
}

local M = {}
M.setup = function(on_attach)
  -- Normal setup
  opts.server.on_attach = on_attach
  -- opts.server.capabilities = capabilities
  require('rust-tools').setup(opts)
end

return M

--[[
rust-analyzer.assist.expressionFillDefault                       default: "todo"
rust-analyzer.cachePriming.enable                                default: true
rust-analyzer.cachePriming.numThreads                            default: 0
rust-analyzer.cargo.autoreload                                   default: true
rust-analyzer.cargo.buildScripts.enable                          default: true
rust-analyzer.cargo.buildScripts.overrideCommand                 default: null
rust-analyzer.cargo.buildScripts.useRustcWrapper                 default: true
rust-analyzer.cargo.features                                     default: []
rust-analyzer.cargo.noDefaultFeatures                            default: false
rust-analyzer.cargo.noSysroot                                    default: false
rust-analyzer.cargo.target                                       default: null
rust-analyzer.cargo.unsetTest                                    default: ["core"]
rust-analyzer.cargoRunner                                        default: null
rust-analyzer.checkOnSave.allTargets                             default: true
rust-analyzer.checkOnSave.command                                default: "check"
rust-analyzer.checkOnSave.enable                                 default: true
rust-analyzer.checkOnSave.extraArgs                              default: []
rust-analyzer.checkOnSave.features                               default: null
rust-analyzer.checkOnSave.noDefaultFeatures                      default: null
rust-analyzer.checkOnSave.overrideCommand                        default: null
rust-analyzer.checkOnSave.target                                 default: null
rust-analyzer.completion.autoimport.enable                       default: true
rust-analyzer.completion.autoself.enable                         default: true
rust-analyzer.completion.callable.snippets                       default: "fill_arguments"
rust-analyzer.completion.postfix.enable                          default: true
rust-analyzer.completion.privateEditable.enable                  default: false
rust-analyzer.completion.snippets.custom                         default: {"Arc::new":{"body":"Arc::new(${receiver})","scope":"expr","description":"Put the expression into an `Arc`","postfix":"arc","requires":"std::sync::Arc"},"Some":{"body":"Some(${receiver})","postfix":"some","scope":"expr","description":"Wrap the expression in an `Option::Some`"},"Err":{"body":"Err(${receiver})","postfix":"err","scope":"expr","description":"Wrap the expression in a `Result::Err`"},"Rc::new":{"body":"Rc::new(${receiver})","scope":"expr","description":"Put the expression into an `Rc`","postfix":"rc","requires":"std::rc::Rc"},"Box::pin":{"body":"Box::pin(${receiver})","scope":"expr","description":"Put the expression into a pinned `Box`","postfix":"pinbox","requires":"std::boxed::Box"},"Ok":{"body":"Ok(${receiver})","postfix":"ok","scope":"expr","description":"Wrap the expression in a `Result::Ok`"}}
rust-analyzer.debug.engine                                       default: "auto"
rust-analyzer.debug.engineSettings                               default: {}
rust-analyzer.debug.openDebugPane                                default: false
rust-analyzer.debug.sourceFileMap                                default: {"\/rustc\/<id>":"${env:USERPROFILE}\/.rustup\/toolchains\/<toolchain-id>\/lib\/rustlib\/src\/rust"}
rust-analyzer.diagnostics.disabled                               default: []
rust-analyzer.diagnostics.enable                                 default: true
rust-analyzer.diagnostics.experimental.enable                    default: false
rust-analyzer.diagnostics.remapPrefix                            default: {}
rust-analyzer.diagnostics.warningsAsHint                         default: []
rust-analyzer.diagnostics.warningsAsInfo                         default: []
rust-analyzer.files.excludeDirs                                  default: []
rust-analyzer.files.watcher                                      default: "client"
rust-analyzer.highlightRelated.breakPoints.enable                default: true
rust-analyzer.highlightRelated.exitPoints.enable                 default: true
rust-analyzer.highlightRelated.references.enable                 default: true
rust-analyzer.highlightRelated.yieldPoints.enable                default: true
rust-analyzer.hover.actions.debug.enable                         default: true
rust-analyzer.hover.actions.enable                               default: true
rust-analyzer.hover.actions.gotoTypeDef.enable                   default: true
rust-analyzer.hover.actions.implementations.enable               default: true
rust-analyzer.hover.actions.references.enable                    default: false
rust-analyzer.hover.actions.run.enable                           default: true
rust-analyzer.hover.documentation.enable                         default: true
rust-analyzer.hover.links.enable                                 default: true
rust-analyzer.imports.granularity.enforce                        default: false
rust-analyzer.imports.granularity.group                          default: "crate"
rust-analyzer.imports.group.enable                               default: true
rust-analyzer.imports.merge.glob                                 default: true
rust-analyzer.imports.prefix                                     default: "plain"
rust-analyzer.inlayHints.bindingModeHints.enable                 default: false
rust-analyzer.inlayHints.chainingHints.enable                    default: true
rust-analyzer.inlayHints.closingBraceHints.enable                default: true
rust-analyzer.inlayHints.closingBraceHints.minLines              default: 25
rust-analyzer.inlayHints.closureReturnTypeHints.enable           default: "never"
rust-analyzer.inlayHints.lifetimeElisionHints.enable             default: "never"
rust-analyzer.inlayHints.lifetimeElisionHints.useParameterNames  default: false
rust-analyzer.inlayHints.maxLength                               default: 25
rust-analyzer.inlayHints.parameterHints.enable                   default: true
rust-analyzer.inlayHints.reborrowHints.enable                    default: "never"
rust-analyzer.inlayHints.renderColons                            default: true
rust-analyzer.inlayHints.typeHints.enable                        default: true
rust-analyzer.inlayHints.typeHints.hideClosureInitialization     default: false
rust-analyzer.inlayHints.typeHints.hideNamedConstructor          default: false
rust-analyzer.joinLines.joinAssignments                          default: true
rust-analyzer.joinLines.joinElseIf                               default: true
rust-analyzer.joinLines.removeTrailingComma                      default: true
rust-analyzer.joinLines.unwrapTrivialBlock                       default: true
rust-analyzer.lens.debug.enable                                  default: true
rust-analyzer.lens.enable                                        default: true
rust-analyzer.lens.forceCustomCommands                           default: true
rust-analyzer.lens.implementations.enable                        default: true
rust-analyzer.lens.references.adt.enable                         default: false
rust-analyzer.lens.references.enumVariant.enable                 default: false
rust-analyzer.lens.references.method.enable                      default: false
rust-analyzer.lens.references.trait.enable                       default: false
rust-analyzer.lens.run.enable                                    default: true
rust-analyzer.linkedProjects                                     default: []
rust-analyzer.lru.capacity                                       default: null
rust-analyzer.notifications.cargoTomlNotFound                    default: true
rust-analyzer.procMacro.attributes.enable                        default: true
rust-analyzer.procMacro.enable                                   default: true
rust-analyzer.procMacro.ignored                                  default: {}
rust-analyzer.procMacro.server                                   default: null
rust-analyzer.runnableEnv                                        default: null
rust-analyzer.runnables.command                                  default: null
rust-analyzer.runnables.extraArgs                                default: []
rust-analyzer.rustc.source                                       default: null
rust-analyzer.rustfmt.extraArgs                                  default: []
rust-analyzer.rustfmt.overrideCommand                            default: null
rust-analyzer.rustfmt.rangeFormatting.enable                     default: false
rust-analyzer.semanticHighlighting.strings.enable                default: true
rust-analyzer.server.extraEnv                                    default: null
rust-analyzer.server.path                                        default: null
rust-analyzer.signatureInfo.detail                               default: "full"
rust-analyzer.signatureInfo.documentation.enable                 default: true
rust-analyzer.trace.extension                                    default: false
rust-analyzer.trace.server                                       default: "off"
rust-analyzer.typing.autoClosingAngleBrackets.enable             default: false
rust-analyzer.workspace.symbol.search.kind                       default: "only_types"
rust-analyzer.workspace.symbol.search.limit                      default: 128
rust-analyzer.workspace.symbol.search.scope                      default: "workspace"
]]
