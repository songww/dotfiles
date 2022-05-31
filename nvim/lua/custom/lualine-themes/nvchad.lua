-- Diff Source
local function diff_source()
  local gitsigns = vim.b.gitsigns_status_dict
  if gitsigns then
    return {
      added = gitsigns.added,
      modified = gitsigns.changed,
      removed = gitsigns.removed,
    }
  end
end

local function coc_diagnostics()
  local diagnostics = vim.b.coc_diagnostic_info
  if diagnostics then
    return {
      info = diagnostics.infomation,
      warn = diagnostics.warning,
      error = diagnostics.error,
    }
  end
end

local function coc_status()
  local status = vim.g.coc_status
  return status
end

-- LuaLine
local present1, lualine = pcall(require, "lualine")
if not present1 then
  return false
end

-- Colors
local colors = require("base46").get_colors("base_30")

-- Config
local config = {
  options = {
    component_separators = "",
    section_separators = "",
    disabled_filetypes = { "alpha", "dashboard", "Outline" },
    globalstatus = true,
    icons_enabled = true,
    theme = {
      normal = { c = { fg = colors.fg, bg = colors.statusline_bg } },
      inactive = {
        a = { bg = colors.statusline_bg, fg = colors.white, gui = "italic" },
        b = { bg = colors.statusline_bg, fg = colors.white },
        c = { bg = colors.statusline_bg, fg = colors.white },
        x = { bg = colors.statusline_bg, fg = colors.white },
        y = { bg = colors.statusline_bg, fg = colors.white },
        z = { bg = colors.statusline_bg, fg = colors.white },
      }
    },
  },
  sections = {
    lualine_a = {},
    lualine_b = {},
    lualine_y = {},
    lualine_z = {},
    lualine_c = {},
    lualine_x = {},
  },
  inactive_sections = {
    lualine_a = {},
    lualine_v = {},
    lualine_y = {},
    lualine_z = {},
    lualine_c = {},
    lualine_x = {},
  },
}

-- Inserts a component in lualine_c at left section
local function ins_left(component)
  table.insert(config.sections.lualine_c, component)
end

-- Inserts a component in lualine_c at left section for inactive
local function inactive_ins_left(component)
  table.insert(config.inactive_sections.lualine_c, component)
end

-- Inserts a component in lualine_x ot right section
local function ins_right(component)
  table.insert(config.sections.lualine_x, component)
end

-- LEFT

-- vi Color mode
ins_left({
  function()
    return " "
  end,
  color = { fg = colors.statusline_bg, bg = colors.blue }, -- Sets highlighting of component
  padding = { left = 0, right = 1 }, -- We don't need space before this
})

ins_left({
  function()
    return ""
  end,
  color = { fg = colors.blue, bg = colors.grey }, -- Sets highlighting of component
  padding = { left = 0, right = 1 }, -- We don't need space before this
})

ins_left({
  "filename",
  -- cond = conditions.buffer_not_empty,
  color = { fg = colors.white, bg = colors.grey },
})

ins_left({
  function()
    return ""
  end,
  color = { fg = colors.grey, bg = colors.statusline_bg }, -- Sets highlighting of component
  padding = { left = 0, right = 1 }, -- We don't need space before this
})

inactive_ins_left({
  function()
    return " "
  end,
  color = { fg = colors.statusline_fg, bg = colors.grey }, -- Sets highlighting of component
  padding = { left = 0, right = 1 }, -- We don't need space before this
})

inactive_ins_left({
  function()
    return ""
  end,
  color = { fg = colors.grey, bg = colors.grey }, -- Sets highlighting of component
  padding = { left = 0, right = 1 }, -- We don't need space before this
})

inactive_ins_left({
  "filename",
  -- cond = conditions.buffer_not_empty,
  color = { fg = colors.white, bg = colors.grey },
})

inactive_ins_left({
  function()
    return ""
  end,
  color = { fg = colors.grey, bg = colors.statusline_bg }, -- Sets highlighting of component
  padding = { left = 0, right = 1 }, -- We don't need space before this
})

ins_left({
  "diff",
  source = diff_source,
  symbols = { added = "  ", modified = "柳", removed = " " },
  diff_color = {
    added = { bg = colors.statusline_bg, fg = colors.green },
    modified = { bg = colors.statusline_bg, fg = colors.yellow },
    removed = { bg = colors.statusline_bg, fg = colors.red },
  },
  color = {},
  cond = nil,
})

ins_left({
  "diagnostics",
  source = coc_diagnostics,
  symbols = { error = " ", warn = " ", info = " " },
  diagnostics_color = {
    error = { fg = colors.red },
    warn = { fg = colors.yellow },
    info = { fg = colors.cyan },
  },
  colored = true,
  cond = nil,
})

-- ins_right({
--   'lsp_progress',
--   display_components = { { 'title', 'percentage', 'message' } },
--   -- With spinner
--   -- display_components = { 'lsp_client_name', 'spinner', { 'title', 'percentage', 'message' } },
--   colors = {
--     percentage      = colors.cyan,
--     title           = colors.cyan,
--     message         = colors.cyan,
--     spinner         = colors.cyan,
--     lsp_client_name = colors.magenta,
--     use             = true,
--   },
--   separators = {
--     component = ' ',
--     progress = ' | ',
--     -- message = { pre = '(', post = ')'},
--     percentage = { pre = '', post = '%% ' },
--     title = { pre = '', post = ': ' },
--     lsp_client_name = { pre = '[', post = ']' },
--     spinner = { pre = '', post = '' },
--     message = { commenced = 'In Progress', completed = 'Completed' },
--   },
--   timer = { progress_enddelay = 500, spinner = 1000, lsp_client_name_enddelay = 1000 },
--   spinner_symbols = { '🌑 ', '🌒 ', '🌓 ', '🌔 ', '🌕 ', '🌖 ', '🌗 ', '🌘 ' },
-- })

--ins_right({
--	function()
--		local msg = ""
--		local buf_ft = vim.api.nvim_buf_get_option(0, "filetype")
--		local clients = vim.lsp.get_active_clients()
--		if next(clients) == nil then
--			return msg
--		end
--		for _, client in ipairs(clients) do
--			local filetypes = client.config.filetypes
--			if filetypes and vim.fn.index(filetypes, buf_ft) ~= -1 then
--				return client.name
--			end
--		end
--		return msg
--	end,
--	icon = " ",
--	color = { fg = colors.violet, gui = "bold" },
--})
ins_right({
  coc_status,
  icon = " ",
  color = { fg = colors.violet, gui = "bold" },
})

ins_right({
  function()
    return ""
  end,
  color = { fg = colors.blue, bg = colors.statusline_bg }, -- Sets highlighting of component
  padding = { left = 0, right = 0 }, -- We don't need space before this
})

ins_right({
  function()
    return " "
  end,
  color = { fg = colors.statusline_bg, bg = colors.blue }, -- Sets highlighting of component
  padding = { left = 0, right = 0 }, -- We don't need space before this
})

ins_right({
  function()
    return ""
  end,
  color = { fg = colors.grey, bg = colors.blue }, -- Sets highlighting of component
  padding = { left = 0, right = 0 }, -- We don't need space before this
})

ins_right({
  "b:gitsigns_head",
  color = { fg = colors.blue, bg = colors.grey },
})

ins_right({
  function()
    return ""
  end,
  color = { fg = colors.red, bg = colors.grey }, -- Sets highlighting of component
  padding = { left = 0, right = 0 }, -- We don't need space before this
})

-- ins_right({
-- 	function()
-- 		return " "
-- 	end,
-- 	color = { fg = colors.statusline_bg, bg = colors.red }, -- Sets highlighting of component
-- 	padding = { left = 0, right = 0 }, -- We don't need space before this
-- })

ins_right({
  "mode",
  fmt = function(str)
    return str
  end,
  color = { fg = colors.grey, bg = colors.red }, -- Sets highlighting of component
})

lualine.setup(config)
