local M = {}

local uv = vim.loop
local path = require('lspconfig.util').path
local root_pattern = require('lspconfig.util').root_pattern

local find
find = function(p, fname)
  if path.is_file(path.join(p, fname)) then
    return path.join(p, fname)
  end
  local req = uv.fs_scandir(p)
  local function iter()
    return uv.fs_scandir_next(req)
  end

  for name, type in iter do
    if type == 'directory' then
      local res = find(path.join(p, name), fname)
      if res then
        return path.dirname(res)
      end
    end
  end
end

M.setup = function(on_attach)
  require("clangd_extensions").setup({
    server = {
      -- options to pass to nvim-lspconfig
      -- i.e. the arguments to require("lspconfig").clangd.setup({})
      cmd = {
        "clangd",
        "--background-index",
        "--clang-tidy",
        "--cross-file-rename",
        "--enable-config", -- clangd 11+ supports reading from .clangd configuration file
        "--fallback-style=llvm",
        "--all-scopes-completion",
        "--completion-style=detailed",
        "--header-insertion=iwyu",
        "--header-insertion-decorators",
        "--suggest-missing-includes",
        "--offset-encoding=utf-16",
        "--pch-storage=memory",
        "--inlay-hints"
      },
      root_dir = function(fname)
        if root_pattern("meson.build")(fname) then
          local root = find(path.dirname(fname), "compile_commands.json")
          if root then
            return root
          end
        end

        local pattern = root_pattern('compile_commands.json', 'compile_flags.txt', '.git')
        local filename = path.is_absolute(fname) and fname or path.join(uv.cwd(), fname)
        return pattern(filename)
      end,
      on_attach = on_attach,
    },
    extensions = {
      -- defaults:
      -- Automatically set inlay hints (type hints)
      autoSetHints = true,
      -- These apply to the default ClangdSetInlayHints command
      inlay_hints = {
        -- Only show inlay hints for the current line
        only_current_line = false,
        -- Event which triggers a refersh of the inlay hints.
        -- You can make this "CursorMoved" or "CursorMoved,CursorMovedI" but
        -- not that this may cause  higher CPU usage.
        -- This option is only respected when only_current_line and
        -- autoSetHints both are true.
        only_current_line_autocmd = "CursorHold",
        -- whether to show parameter hints with the inlay hints or not
        show_parameter_hints = true,
        -- prefix for parameter hints
        parameter_hints_prefix = "<- ",
        -- prefix for all the other hints (type, chaining)
        other_hints_prefix = "=> ",
        -- whether to align to the length of the longest line in the file
        max_len_align = false,
        -- padding from the left if max_len_align is true
        max_len_align_padding = 1,
        -- whether to align to the extreme right or not
        right_align = false,
        -- padding from the right if right_align is true
        right_align_padding = 7,
        -- The color of the hints
        highlight = "Comment",
        -- The highlight group priority for extmark
        priority = 100,
      },
      ast = {
        role_icons = {
          type = "",
          declaration = "",
          expression = "",
          specifier = "",
          statement = "",
          ["template argument"] = "",
        },

        kind_icons = {
          Compound = "",
          Recovery = "",
          TranslationUnit = "",
          PackExpansion = "",
          TemplateTypeParm = "",
          TemplateTemplateParm = "",
          TemplateParamObject = "",
        },

        highlights = {
          detail = "Comment",
        },
        memory_usage = {
          border = "none",
        },
        symbol_info = {
          border = "none",
        },
      },
    }
  })
end

return M
