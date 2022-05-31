vim.g.colors_name = "ayu"

local ayu_sign_contrast = vim.g.ayu_sign_contrast or 0

local sign_bg = ''

if ayu_sign_contrast ~= 0 then
  sign_bg = 'ui_bg'
end

local ayu_italic_comment = vim.g.ayu_italic_comment or 0
local italic_comment = 0
if ayu_italic_comment ~= 0 then
  italic_comment = 1
end

-- }}}

local M = {

  -- Vim Highlighting: (see :help highlight-groups)"{{{

  Normal = { fg = 'editor_fg', bg = 'editor_bg' },
  ColorColumn = { fg = '', bg = 'editor_line' },
  CursorColumn = { fg = '', bg = 'editor_line' },
  CursorLine = { fg = '', bg = 'editor_line' },
  CursorLineNr = { fg = 'common_accent', bg = 'editor_line' },
  LineNr = { fg = 'editor_gutter_normal', bg = '' },
  Directory = { fg = 'syntax_func', bg = '' },
  ErrorMsg = { fg = 'editor_fg', bg = 'common_error', standout = 1 },
  VertSplit = { fg = 'ui_panel_bg', bg = 'ui_panel_bg' },
  Folded = { fg = 'extended_fg_idle', bg = 'ui_bg' },
  FoldColumn = { fg = '', bg = sign_bg },
  SignColumn = { fg = '', bg = sign_bg },

  MatchParen = { fg = 'editor_fg', bg = 'editor_bg', 'underline' },
  ModeMsg = { fg = 'syntax_string', bg = '' },
  MoreMsg = { fg = 'syntax_string', bg = '' },
  NonText = { fg = 'editor_gutter_normal', bg = '' },
  Pmenu = { fg = 'editor_fg', bg = 'ui_bg' },
  PmenuSel = { fg = '', bg = 'ui_selection_active' },
  Question = { fg = 'syntax_string', bg = '' },
  Search = { fg = '', bg = 'editor_findMatch_inactive' },
  IncSearch = { fg = '', bg = 'editor_findMatch_active' },
  SpecialKey = { fg = 'editor_selection_inactive', bg = '' },
  SpellCap = { fg = 'syntax_tag', bg = '', line = 'underline' },
  SpellLocal = { fg = 'syntax_keyword', bg = '', line = 'underline' },
  SpellBad = { fg = 'common_error', bg = '', line = 'underline' },
  SpellRare = { fg = 'syntax_regexp', bg = '', line = 'underline' },
  StatusLine = { fg = 'editor_fg', bg = 'ui_panel_bg' },
  StatusLineNC = { fg = 'extended_fg_idle', bg = 'ui_panel_bg' },
  WildMenu = { fg = 'editor_fg', bg = 'syntax_markup' },
  TabLine = { fg = 'syntax_comment', bg = 'ui_panel_shadow' },
  TabLineFill = { fg = 'editor_fg', bg = 'ui_bg' },
  TabLineSel = { fg = 'editor_fg', bg = 'editor_bg' },
  Title = { fg = 'syntax_keyword', bg = '' },
  Visual = { fg = '', bg = 'editor_selection_inactive' },
  WarningMsg = { fg = 'extended_warning', bg = '' },

  -- Extended
  Conditional = { fg = 'extended_conditional', bg = '' },
  Repeat = { fg = 'extended_repeat', bg = '' },

  --}}}

  -- Neovim Highlights:" {{{

  NormalFloat = { fg = 'editor_fg', bg = 'ui_panel_bg' },
  FloatBorder = { fg = 'editor_fg', bg = 'ui_panel_bg' },

  -- }}}

  -- Generic Syntax Highlighting: (see :help group-name)"{{{

  Comment = { fg = 'syntax_comment', bg = '', italic = italic_comment },

  Constant = { fg = 'syntax_constant', bg = '', '' },
  String = { fg = 'syntax_string', bg = '' },

  Identifier = { fg = 'syntax_entity', bg = '' },
  Function = { fg = 'syntax_func', bg = '' },

  Statement = { fg = 'syntax_keyword', bg = '' },
  Operator = { fg = 'syntax_operator', bg = '' },
  Exception = { fg = 'syntax_markup', bg = '' },

  PreProc = { fg = 'common_accent', bg = '' },

  Type = { fg = 'syntax_entity', bg = '' },
  Structure = { fg = 'syntax_special', bg = '' },

  Special = { fg = 'common_accent', bg = '' },
  Delimiter = { fg = 'syntax_special', bg = '' },

  Underlined = { fg = 'syntax_tag', bg = '', 'underline' },

  Ignore = { fg = '', bg = '' },

  Error = { fg = 'editor_fg', bg = 'common_error' },

  Todo = { fg = 'syntax_markup', bg = '' },

  -- Quickfix window highlighting
  qfLineNr = { fg = 'syntax_keyword', bg = '' },

  Conceal = { fg = 'syntax_comment', bg = '' },
  CursorLineConceal = { fg = 'editor_gutter_normal', bg = 'editor_line' },

  -- Extended
  PreCondit = { fg = 'extended_conditional', bg = '' },

  --}}}

  -- Diff Syntax Highlighting:"{{{
  DiffAdd = { fg = 'vcs_added', bg = 'editor_gutter_normal' },
  DiffAdded = { fg = 'vcs_added', bg = '' },
  DiffChange = { fg = 'vcs_modified', bg = 'editor_gutter_normal' },
  DiffDelete = { fg = 'vcs_removed', bg = 'editor_gutter_normal' },
  DiffRemoved = { fg = 'vcs_removed', bg = '' },
  DiffText = { fg = 'vcs_modified', bg = 'editor_gutter_active' },
  -- }}}

  -- Netrw:" {{{
  netrwClassify = { fg = 'syntax_special', bg = '' },
  -- }}}

  -- GitGutter:" {{{
  GitGutterAdd = { fg = 'vcs_added', sign_bg },
  GitGutterChange = { fg = 'vcs_modified', sign_bg },
  GitGutterDelete = { fg = 'vcs_removed', sign_bg },
  GitGutterChangeDelete = { fg = 'vcs_modified', sign_bg, 'underline' },
  -- }}}

  -- Signify:" {{{
  SignifySignAdd = { fg = 'vcs_added', sign_bg },
  SignifySignChange = { fg = 'vcs_modified', sign_bg },
  SignifySignDelete = { fg = 'vcs_removed', sign_bg },
  SignifySignChangeDelete = { fg = 'vcs_modified', sign_bg, 'underline' },
  -- }}}

  -- NERDTree:" {{{
  NERDTreeOpenable = { fg = 'extended_fg_idle', bg = '' },
  NERDTreeClosable = { fg = 'common_accent', bg = '' },
  NERDTreeUp = { fg = 'extended_fg_idle', bg = '' },
  NERDTreeDir = { fg = 'syntax_func', bg = '' },
  NERDTreeFile = { fg = '', bg = '' },
  NERDTreeDirSlash = { fg = 'syntax_special', bg = '' },
  -- }}}

  -- Telescope:"{{{
  TelescopeMatching = { fg = 'common_accent', bg = '' },
  -- }}}

  -- Neovim Diagnostics:" {{{
  DiagnosticDefaultError = { fg = 'common_error', bg = '' },
  DiagnosticUnderlineError = { fg = 'common_error', bg = '', 'underline' },
  DiagnosticSignError = { fg = 'common_error', sign_bg },

  DiagnosticDefaultWarn = { fg = 'extended_warning', bg = '' },
  DiagnosticUnderlineWarn = { fg = 'extended_warning', bg = '', 'underline' },
  DiagnosticSignWarn = { fg = 'extended_warning', sign_bg },

  DiagnosticVirtualTextHint = { fg = 'extended_fg_idle', bg = '' },
  DiagnosticSignHint = { fg = 'editor_fg', sign_bg },

  DiagnosticVirtualTextInfo = { fg = 'extended_fg_idle', bg = '' },
  DiagnosticSignInfo = { fg = 'editor_fg', sign_bg },
  -- }}}

  -- Neovim Builtin LSP:" {{{
  LspDiagnosticsDefaultError = { fg = 'common_error', bg = '' },
  LspDiagnosticsUnderlineError = { fg = 'common_error', bg = '', 'underline' },
  LspDiagnosticsSignError = { fg = 'common_error', sign_bg },

  LspDiagnosticsDefaultWarning = { fg = 'extended_warning', bg = '' },
  LspDiagnosticsUnderlineWarning = { fg = 'extended_warning', bg = '', 'underline' },
  LspDiagnosticsSignWarning = { fg = 'extended_warning', sign_bg },

  LspDiagnosticsVirtualTextHint = { fg = 'extended_fg_idle', bg = '' },
  LspDiagnosticsSignHint = { fg = 'editor_fg', sign_bg },

  LspDiagnosticsVirtualTextInformation = { fg = 'extended_fg_idle', bg = '' },
  LspDiagnosticsSignInformation = { fg = 'editor_fg', sign_bg },

  -- hi! link LspReferenceRead Visual
  -- }}}

  -- YATS:" {{{

  typescriptDecorator = { fg = 'syntax_markup', bg = '' },
  typescriptImport = { fg = 'extended_import', bg = '' },
  typescriptExport = { fg = 'common_accent', bg = '' },
  typescriptIdentifier = { fg = 'syntax_tag', bg = '', 'italic' },
  typescriptAssign = { fg = 'syntax_operator', bg = '' },
  typescriptBinaryOp = { fg = 'syntax_operator', bg = '' },
  typescriptTernaryOp = { fg = 'syntax_operator', bg = '' },
  typescriptModule = { fg = 'syntax_keyword', bg = '' },
  typescriptTypeBrackets = { fg = 'syntax_special', bg = '' },
  typescriptClassName = { fg = 'syntax_tag', bg = '' },
  typescriptAmbientDeclaration = { fg = 'syntax_keyword', bg = '' },
  typescriptRegexpString = { fg = 'syntax_regexp', bg = '' },
  typescriptTry = { fg = 'syntax_markup', bg = '' },
  typescriptExceptions = { fg = 'syntax_markup', bg = '' },
  typescriptDebugger = { fg = 'syntax_markup', bg = '', 'bold' },
  typescriptParens = { fg = 'syntax_special', bg = '' },
  --typescriptVariable = { fg = 'syntax_keyword', bg = '' },
  typescriptObjectLabel = { fg = 'syntax_tag', bg = '' },
  typescriptOperator = { fg = 'syntax_keyword', bg = '' },
  typescriptArrowFunc = { fg = 'syntax_operator', bg = '' },
  typescriptBraces = { fg = 'syntax_special', bg = '' },
  typescriptGlobal = { fg = 'common_accent', bg = '' },

  -- Prop
  typescriptDOMFormProp = { fg = 'syntax_entity', bg = '' },
  typescriptDOMEventProp = { fg = 'syntax_entity', bg = '' },
  typescriptBOMWindowProp = { fg = 'common_accent', bg = '' },

  -- Method
  typescriptDateMethod = { fg = 'syntax_func', bg = '' },
  typescriptBlobMethod = { fg = 'syntax_func', bg = '' },
  typescriptArrayMethod = { fg = 'syntax_func', bg = '' },
  typescriptArrayStaticMethod = { fg = 'syntax_func', bg = '' },
  typescriptStringMethod = { fg = 'syntax_func', bg = '' },
  typescriptPaymentMethod = { fg = 'syntax_func', bg = '' },
  typescriptHeadersMethod = { fg = 'syntax_func', bg = '' },
  typescriptCacheMethod = { fg = 'syntax_func', bg = '' },
  typescriptDOMEventMethod = { fg = 'syntax_func', bg = '' },
  typescriptDOMEventTargetMethod = { fg = 'syntax_func', bg = '' },
  typescriptBOMWindowMethod = { fg = 'syntax_func', bg = '' },
  typescriptDOMStorageMethod = { fg = 'syntax_func', bg = '' },
  typescriptPromiseMethod = { fg = 'syntax_func', bg = '' },
  typescriptGlobalMethod = { fg = 'syntax_func', bg = '' },
  typescriptFunctionMethod = { fg = 'syntax_func', bg = '' },
  typescriptBOMLocationMethod = { fg = 'syntax_func', bg = '' },

  -- Extended
  typescriptFuncKeyword = { fg = 'extended_keyword_func', bg = '' },
  typescriptConditional = { fg = 'extended_conditional', bg = '' },
  typescriptCase = { fg = 'extended_conditional', bg = '' },
  typescriptRepeat = { fg = 'extended_repeat', bg = '' },
  typescriptBranch = { fg = 'extended_repeat', bg = '' },

  -- }}}

  -- Javascript:" {{{

  jsNull = { fg = 'syntax_constant', bg = '' },
  jsThis = { fg = 'syntax_constant', bg = '', 'italic' },

  jsBrackets = { fg = 'syntax_special', bg = '' },
  jsDot = { fg = 'syntax_special', bg = '' },
  jsParens = { fg = 'syntax_special', bg = '' },
  jsFuncParens = { fg = 'syntax_special', bg = '' },
  jsFuncBraces = { fg = 'syntax_special', bg = '' },
  jsIfElseBraces = { fg = 'syntax_special', bg = '' },

  jsObjectKey = { fg = 'syntax_tag', bg = '' },
  jsObjectProp = { fg = 'syntax_tag', bg = '' },

  jsRegexpString = { fg = 'syntax_regexp', bg = '' },

  jsStorageClass = { fg = 'syntax_keyword', bg = '' },

  jsArrowFunction = { fg = 'syntax_operator', bg = '' },

  -- Extended
  jsFunction = { fg = 'extended_keyword_func', bg = '' },

  -- }}}

  -- TreeSitter:" {{{

  TSInclude = { fg = 'extended_import', bg = '' },

  TSParameter = { fg = 'syntax_special', bg = '' },

  TSField = { fg = 'syntax_tag', bg = '' },
  TSProperty = { fg = 'syntax_tag', bg = '' },

  TSAttribute = { fg = 'syntax_markup', bg = '' },

  TSVariableBuiltin = { fg = 'syntax_constant', bg = '', 'italic' },
  TSConstBuiltin = { fg = 'syntax_constant', bg = '' },

  TSStringRegex = { fg = 'syntax_regexp', bg = '' },

  TSFuncMacro = { fg = 'syntax_func', bg = '' },

  -- Extended
  TSKeywordFunction = { fg = 'extended_keyword_func', bg = '' },
  TSRepeat = { fg = 'extended_repeat', bg = '' },
  TSConditional = { fg = 'extended_conditional', bg = '' },

  -- }}}

  -- Fugitive:" {{{
  fugitiveUntrackedHeading = { fg = 'common_accent', bg = '' },
  fugitiveUnstagedHeading = { fg = 'common_accent', bg = '' },
  fugitiveStagedHeading = { fg = 'common_accent', bg = '' },
  fugitiveHeading = { fg = 'common_accent', bg = '' },
  -- }}}

  -- Git Commit:" {{{
  gitcommitBranch = { fg = 'syntax_func', bg = '' },
  gitcommitHeader = { fg = 'common_accent', bg = '' },
  gitcommitSummary = { fg = 'editor_fg', bg = '' },
  gitcommitOverflow = { fg = 'syntax_markup', bg = '' },
  -- }}}

  -- Startify:" {{{
  StartifyFile = { fg = 'editor_fg', bg = '' },
  -- }}}

  -- Vim:" {{{
  vimUserFunc = { fg = 'syntax_func', bg = '' },
  --hi! link vimVar NONE
  vimFunction = { fg = 'syntax_func', bg = '' },
  vimIsCommand = { fg = '', bg = '' },
  -- }}}

  -- XML:" {{{

  xmlTag = { fg = 'syntax_special', bg = '' },
  xmlTagName = { fg = 'syntax_keyword', bg = '' },
  xmlEntity = { fg = 'syntax_tag', bg = '' },
  xmlEntityPunct = { fg = 'syntax_operator', bg = '' },
  xmlEqual = { fg = 'syntax_operator', bg = '' },

  -- }}}

  -- INI:" {{{
  dosiniHeader = { fg = 'syntax_keyword', bg = '' },
  -- }}}

  -- Pandoc:" {{{

  pandocPipeTableHeader = { fg = 'syntax_keyword', bg = '' },
  pandocPipeTableDelims = { fg = 'syntax_keyword', bg = '' },
  pandocDelimitedCodeBlock = { fg = 'common_accent', bg = '' },

  -- }}}

  -- Shell:" {{{

  shTestOpr = { fg = 'syntax_operator', bg = '' },
  shOption = { fg = 'syntax_special', bg = '' },
  shQuote = { fg = 'syntax_string', bg = '' },

  -- }}}

  -- Haskell:" {{{

  haskellDeclKeyword = { fg = 'syntax_keyword', bg = '' },
  haskellLet = { fg = 'syntax_keyword', bg = '' },
  haskellWhere = { fg = 'syntax_keyword', bg = '' },
  haskellIdentifier = { fg = 'syntax_tag', bg = '' },

  -- }}}

  -- PHP:" {{{

  phpDefine = { fg = 'syntax_keyword', bg = '' },
  phpStructure = { fg = 'syntax_keyword', bg = '' },

  -- }}}

  -- Ruby:" {{{

  rubyModule = { fg = 'syntax_keyword', bg = '' },
  rubyRegexp = { fg = 'syntax_regexp', bg = '' },
  rubyRegexpDelimiter = { fg = 'syntax_regexp', bg = '' },
  rubyStringDelimiter = { fg = 'syntax_string', bg = '' },

  -- }}}

  -- Compe:" {{{

  -- hi! link CompeDocumentation NormalFloat

  -- }}}

  -- Cmp:" {{{

  CmpItemAbbrMatch = { fg = 'common_accent', bg = '' },
  CmpItemAbbrMatchFuzzy = { fg = 'common_accent', bg = '' },

  -- Highlights for cmp item types
  CmpItemAbbrDeprecated = { fg = '', bg = '', strikethrough = 1 },

  CmpItemKindInterface = { fg = 'syntax_entity', bg = '' },
  CmpItemKindClass = { fg = 'syntax_entity', bg = '' },
  CmpItemKindEnum = { fg = 'syntax_entity', bg = '' },
  CmpItemKindStruct = { fg = 'syntax_entity', bg = '' },

  CmpItemKindFunction = { fg = 'syntax_func', bg = '' },
  CmpItemKindMethod = { fg = 'syntax_func', bg = '' },

  CmpItemKindKeyword = { fg = 'syntax_keyword', bg = '' },
  CmpItemKindOperator = { fg = 'syntax_keyword', bg = '' },

  CmpItemKindProperty = { fg = 'syntax_tag', bg = '' },
  CmpItemKindField = { fg = 'syntax_tag', bg = '' },

  CmpItemKindText = { fg = 'syntax_comment', bg = '' },
  CmpItemKindSnippet = { fg = 'syntax_comment', bg = '' },

  CmpItemKindModule = { fg = 'extended_import', bg = '' },

  CmpItemKindConstant = { fg = 'syntax_constant', bg = '' },

  CmpItemKindConstructor = { fg = 'common_accent', bg = '' },

  -- }}}

  -- Indent Blankline:" {{{

  IndentBlanklineChar = { fg = 'editor_indentGuide_normal', bg = '' },
  IndentBlanklineContextChar = { fg = 'editor_indentGuide_active', bg = '' },

}

return M
