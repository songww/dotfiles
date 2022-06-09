local null = require "null-ls"
local b = null.builtins

local sources = {

  b.code_actions.gitsigns,
  b.code_actions.proselint,
  b.code_actions.refactoring,
  b.code_actions.shellcheck,

  b.diagnostics.actionlint,
  -- b.diagnostics.flake8,
  b.diagnostics.gitlint,
  b.diagnostics.hadolint,
  -- b.diagnostics.mypy,
  -- b.diagnostics.pydocstyle,
  -- b.diagnostics.pylama,
  b.diagnostics.rstcheck,
  b.diagnostics.shellcheck,
  b.diagnostics.vulture, -- Vulture finds unused code in Python programs.
  b.diagnostics.yamllint,

  -- b.formatting.autopep8,
  -- b.formatting.black,
  -- b.formatting.clang_format,
  b.formatting.isort,
  b.formatting.jq,
  b.formatting.nginx_beautifier,
  b.formatting.pg_format,
  -- b.formatting.rustfmt,
  b.formatting.rome,
  b.formatting.shfmt,
  b.formatting.trim_newlines,
  b.formatting.trim_whitespace,
}

local M = {}

function M.using_nullfmt(filetype)
  local null = require("null-ls")
  local null_sources = require("null-ls.sources")

  local sources = null_sources.get({})
  for _, source in ipairs(sources) do
    if source.name ~= "trim_whitespace"
        and null_sources.is_available(source, filetype, null.methods.FORMATTING)
    then
      return true
    end
  end
  return false
end

M.setup = function()
  null.setup {
    debug = true,
    sources = sources,

    -- format on save
    on_attach = function(client, bufnr)
      vim.api.nvim_create_autocmd({ "BufWritePre" }, { buffer = bufnr, callback = function()
        vim.lsp.buf.formatting_seq_sync()
        -- vim.lsp.buf.format {
        --   filter = function(clients)
        --     return vim.tbl_filter(
        --       function(client)
        --         print(client.name)
        --         return client.name ~= "tsserver"
        --       end,
        --       clients
        --     )
        --   end
        -- }
      end })
    end,
  }
end

return M
