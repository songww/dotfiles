local _, cmp = pcall(require, "cmp")

vim.api.nvim_create_autocmd("BufReadPost", {
  pattern = "Cargo.toml",
  callback = function()
    cmp.setup.buffer({
      sources = cmp.config.sources(
        {
          { name = 'crates' },
        },
        {
          { name = 'buffer' }
        }
      )
    })
  end
})

-- Set configuration for specific filetype.
cmp.setup.filetype('gitcommit', {
  sources = cmp.config.sources(
    {
      { name = 'git' }, -- You can specify the `cmp_git` source if you were installed it.
    },
    {
      { name = 'buffer' }
    }
  )
})

cmp.setup.filetype({ 'sql', 'mysql', 'plsql', 'dbui' }, {
  sources = {
    {
      { name = 'vim-dadbod-completion' }
    },
    {
      { name = 'buffer' }
    }
  }
})

-- Use buffer source for `/` (if you enabled `native_menu`, this won't work anymore).
cmp.setup.cmdline('/', {
  mapping = cmp.mapping.preset.cmdline(),
  sources = {
    { name = 'buffer' }
  }
})

-- Use cmdline & path source for ':' (if you enabled `native_menu`, this won't work anymore).
cmp.setup.cmdline(':', {
  mapping = cmp.mapping.preset.cmdline(),
  sources = cmp.config.sources(
    {
      { name = 'path' }
    },
    {
      { name = 'cmdline' }
    }
  )
})

vim.api.nvim_create_autocmd("BufEnter",
  {
    pattern = { "dapui_*", "dap-repl" },
    callback = function()
      cmp.setup.buffer({
        sources = cmp.config.sources(
          {
            { name = "cmp-dap" }
          },
          {
            { name = 'buffer' }
          }
        )
      })
    end
  }
)

local M = {
  mapping = {
    -- ["<C-p>"] = cmp.mapping.select_prev_item(),
    -- ["<C-n>"] = cmp.mapping.select_next_item(),
    ["<C-Space>"] = nil,
    ["<C-k>"] = cmp.mapping.select_prev_item(),
    ["<C-j>"] = cmp.mapping.select_next_item(),
    ["<C-P>"] = cmp.mapping.complete(),
    ["<C-x>"] = cmp.mapping.complete(),
    -- ["<Tab>"] = nil,
  },
  -- enabled = function()
  --   return vim.api.nvim_buf_get_option(0, "buftype") ~= "prompt"
  --       or require("cmp_dap").is_dap_buffer()
  -- end,
  sources = {
    -- {
    { name = "nvim_lsp" },
    { name = "nvim_lua" },
    { name = "luasnip" },
    { name = "cmp_tabnine" },
    { name = "treesitter" },
    { name = "path" },
    { name = "emoji" },
    { name = "buffer" },
  },
}

return M
