-- Update this path
local extension_path = vim.env.HOME .. '/.vscode/extensions/vadimcn.vscode-lldb-1.7.0/'
local codelldb_path = extension_path .. 'adapter/codelldb'
local liblldb_path = extension_path .. 'lldb/lib/liblldb.so'

local options = function()
  return {
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
      -- autoSetHints = true,

      -- whether to show hover actions inside the hover window
      -- this overrides the default hover handler so something like lspsaga.nvim's hover would be overriden by this
      -- default: true
      -- hover_with_actions = true,

      -- how to execute terminal commands
      -- options right now: termopen / quickfix
      executor = require("rust-tools/executors").termopen,

      -- callback to execute once rust-analyzer is done initializing the workspace
      -- The callback receives one parameter indicating the `health` of the server: "ok" | "warning" | "error"
      -- on_initialized = nil,

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
        output = ".",
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
            command           = "clippy",
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
end

local M = {}
M.setup = function(on_attach)
  -- Normal setup
  local opts = options()
  opts.server.on_attach = on_attach
  -- opts.server.capabilities = capabilities
  local rust = require("rust-tools")
  rust.setup(opts)
end

return M
