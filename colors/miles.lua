-- miles: light theme
vim.cmd('hi clear')
if vim.fn.exists('syntax_on') == 1 then
    vim.cmd('syntax reset')
end
vim.o.background = 'light'
vim.g.colors_name = 'miles'

-- Palette -------------------------------------------------------------------
local p = {
    fg = '#000000',
    bg = '#f7f7f7',

    comment = '#6e7687',
    keyword = '#8100c2',
    func = '#0051c2',
    blue = '#325cc0',
    const = '#008080',
    string = '#008000',
    type = '#b34a00',
    param = '#b84f05',
    punct = '#777777',
    magenta = '#7a3e9d',
    cyan = '#0083b2',
    green = '#448c27',
    bright_green = '#60cb00',
    yellow = '#cb9000',
    bright_yellow = '#ffbc5d',
    red = '#aa3731',

    dim = '#696969',
    muted = '#7d7d7d',
    faint = '#bfbfbf',
    linenr = '#7d7c7c',
    conceal = '#b0b0b0',
    eob = '#b6b6b6',
    codelens = '#999999',

    bg_line = '#dddddd',
    bg_float = '#e7e7e7',
    bg_sel = '#c7c7c7',
    bg_status = '#c9c9c9',
    bg_ref = '#dadada',
    bg_cursorcol = '#e2eeee',
    border = '#abbdc0',
    visual = '#bfdbfe',
    accent = '#007acc',

    error = '#d13e23',
    error_fg = '#c33c33',
    error_bg = '#f8b28f',
    warn = '#bc7500',
    warn_msg = '#e1ad4c',
    info = '#278c00',

    add_bg = '#adffb7',
    change_bg = '#fff987',
    todo_bg = '#ffdeaa',
    search_bg = '#fae9b7',
}

local groups = {
    -- Editor UI ---------------------------------------------------------------
    Normal = { fg = p.fg, bg = p.bg },
    NormalFloat = { bg = p.bg_float },
    FloatBorder = { fg = p.bg_float, bg = p.bg_float },
    Cursor = { fg = p.visual, bg = p.accent },
    lCursor = { fg = p.bg, bg = p.fg },
    TermCursorNC = { fg = p.bg, bg = p.fg },
    CursorLine = { bg = p.bg_line },
    CursorColumn = { bg = p.bg_cursorcol },
    CursorLineNr = { fg = p.fg },
    ColorColumn = { bg = p.bg_line },
    LineNr = { fg = p.linenr },
    SignColumn = {},
    FoldColumn = { fg = '#4d4d4d', bg = p.bg },
    Folded = { fg = p.muted, bg = p.bg_line },
    Conceal = { fg = p.conceal },
    NonText = { fg = p.dim },
    EndOfBuffer = { fg = p.eob },
    SpecialKey = { fg = p.cyan },
    Directory = { fg = p.blue },
    Title = { fg = p.magenta },
    Visual = { bg = p.visual },
    VisualNOS = { link = 'Visual' },
    Search = { fg = p.fg, bg = p.search_bg },
    IncSearch = { fg = p.fg, bg = p.bright_yellow },
    MatchParen = { underline = true, sp = p.bright_yellow },
    QuickFixLine = { bg = p.bg_cursorcol },
    VertSplit = { fg = p.border },
    WinSeparator = { link = 'Normal' },
    StatusLine = { fg = p.fg, bg = p.bg_status },
    StatusLineNC = { fg = '#9f9f9f', bg = p.bg_status },
    TabLine = { fg = p.muted, bg = p.bg_status },
    TabLineFill = { bg = p.bg_status },
    TabLineSel = { fg = p.blue, bg = p.bg_status },
    WinBar = { fg = p.fg, bg = p.bg, bold = true },
    WinBarNC = { fg = p.muted, bg = p.bg },
    Pmenu = { bg = p.bg_float },
    PmenuSel = { bg = p.bg_sel },
    PmenuSbar = { bg = p.punct },
    PmenuThumb = { bg = '#333333' },
    WildMenu = { bg = p.codelens },
    MoreMsg = { fg = p.green, bold = true },
    Question = { fg = p.green },
    WarningMsg = { fg = p.warn_msg },
    ErrorMsg = { fg = p.error, bg = p.error_bg },
    Italic = { italic = true },

    -- Syntax ------------------------------------------------------------------
    Comment = { fg = p.comment },
    Constant = { fg = p.const }, -- Number, Boolean, Float link here by default
    String = { fg = p.string },
    Character = { link = 'String' },
    Identifier = { fg = p.fg },
    Function = { fg = p.func },
    Statement = { fg = p.keyword }, -- Keyword, Conditional, Repeat, Exception link here by default
    Include = { link = 'Statement' },
    Label = { fg = p.blue },
    Operator = { fg = p.punct },
    PreProc = { fg = p.fg }, -- Define, Macro, PreCondit link here by default
    Type = { fg = p.type },
    StorageClass = { fg = p.fg },
    Structure = { fg = p.blue },
    Typedef = { link = 'Structure' },
    Special = { link = '@variable' }, -- Delimiter, SpecialChar, Tag, Debug link here by default
    SpecialComment = { link = 'Todo' },
    Todo = { fg = p.blue, bg = p.todo_bg },
    Error = { fg = p.error_fg, bg = p.error_bg },

    -- Treesitter (only where it differs from the default links) ---------------
    ['@variable'] = { fg = p.fg },
    ['@variable.builtin'] = { link = 'Keyword' },
    ['@variable.parameter'] = { fg = p.param },
    ['@variable.parameter.rust'] = { link = '@variable' },
    ['@constant.builtin'] = { link = 'Constant' },
    ['@constant.macro'] = { fg = p.fg },
    ['@string.special'] = { link = 'Constant' },
    ['@string.escape'] = { link = 'Constant' },
    ['@function.builtin'] = { link = 'Function' },
    ['@function.macro'] = { link = 'Function' },
    ['@attribute'] = { link = 'Function' },
    ['@constructor'] = { fg = p.fg },
    ['@constructor.python'] = { link = '@function' },
    ['@constructor.rust'] = { link = '@type' },
    ['@type.builtin'] = { link = 'Type' },
    ['@module'] = { fg = p.fg },
    ['@label'] = { fg = p.fg },
    ['@label.rust'] = { link = '@type' },
    ['@tag'] = { fg = p.fg },
    ['@tag.delimiter'] = { fg = p.punct },
    ['@operator'] = { fg = p.fg },
    ['@none'] = { fg = p.magenta },

    -- LSP semantic tokens: plain by default, declarations highlighted ----------
    ['@lsp.type.function'] = { fg = p.fg },
    ['@lsp.type.method'] = { fg = p.fg },
    ['@lsp.type.enumMember'] = { fg = p.fg },
    ['@lsp.type.selfKeyword'] = { fg = p.fg },
    ['@lsp.mod.declaration'] = { fg = p.fg },
    ['@lsp.typemod.enumMember.defaultLibrary'] = { fg = p.fg },
    ['@lsp.typemod.selfKeyword'] = { fg = p.fg },

    -- Diagnostics -------------------------------------------------------------
    DiagnosticError = { fg = p.error },
    DiagnosticWarn = { fg = p.warn },
    DiagnosticInfo = { fg = p.info },
    DiagnosticHint = { fg = p.blue },
    DiagnosticVirtualTextError = { fg = '#411414', bg = p.error_bg },
    DiagnosticVirtualTextWarn = { fg = p.fg, bg = p.change_bg },
    DiagnosticVirtualTextInfo = { fg = '#042f09', bg = p.add_bg },
    DiagnosticVirtualTextHint = { fg = '#0f171d', bg = '#c3d0da' },
    DiagnosticUnderlineError = { underline = true, sp = '#ff0000' },
    DiagnosticUnderlineWarn = { underline = true, sp = '#ffa500' },
    DiagnosticUnderlineInfo = { underline = true, sp = '#0000ff' },
    DiagnosticUnderlineHint = { underline = true, sp = '#808080' },

    -- LSP UI ------------------------------------------------------------------
    LspReferenceText = { bg = p.bg_ref },
    LspReferenceWrite = { bg = p.bg_ref, underline = true, sp = p.accent },
    LspCodeLens = { fg = p.codelens },
    LspCodeLensSeparator = { link = 'LspCodeLens' },

    -- Diff --------------------------------------------------------------------
    DiffAdd = { fg = '#0a7816', bg = p.add_bg },
    DiffChange = { fg = '#341a00', bg = p.change_bg },
    DiffDelete = { fg = '#872c28', bg = p.error_bg },
    DiffText = { fg = p.change_bg, bg = '#876004' },
    diffAdded = { link = 'DiffAdd' },
    diffRemoved = { link = 'DiffDelete' },

    -- Spelling ----------------------------------------------------------------
    SpellBad = { undercurl = true, sp = p.red },
    SpellCap = { undercurl = true, sp = p.blue },
    SpellLocal = { undercurl = true, sp = p.cyan },
    SpellRare = { undercurl = true, sp = p.magenta },

    -- Debugging ---------------------------------------------------------------
    debugBreakpoint = { bg = p.error_bg },
    debugPC = { bg = '#c7c7ee' },
    NvimDapVirtualText = { fg = p.fg, bg = '#78d2c9' },

    -- Filetype-specific -------------------------------------------------------
    helpCommand = { fg = p.cyan },
    helpExample = { fg = p.cyan },
    helpHeader = { fg = p.magenta },
    helpHeadline = { fg = p.blue },
    helpHyperTextJump = { fg = p.magenta },
    helpSectionDelim = { fg = p.magenta },
    healthSuccess = { fg = p.green, bg = p.bg },
    asmDirective = { fg = p.dim },
    nasmLabel = { link = 'Function' },
    dbui_connection_source = { fg = p.dim },
    dbui_help = { fg = p.dim },

    -- Plugins -----------------------------------------------------------------
    GitSignsAdd = { fg = '#6abf40' },
    GitSignsChange = { fg = '#ec8013' },
    GitSignsDelete = { fg = '#b40600' },

    FzfLuaBorder = { fg = p.border },

    TelescopeBorder = { fg = p.border },
    TelescopeMatching = { fg = '#cc6f14' },
    TelescopeMultiSelection = { fg = p.magenta },
    TelescopePromptPrefix = { fg = p.blue },
    TelescopeResultsTitle = { fg = p.yellow },
    TelescopeSelectionCaret = { fg = p.error_fg },
    TelescopeTitle = { fg = p.yellow },

    CmpItemMenuDefault = { fg = p.magenta },
    ALEWarningSign = { link = 'DiagnosticWarn' },
    MatchupVirtualText = { fg = p.yellow },

    HopNextKey = { fg = p.yellow },
    HopNextKey1 = { fg = p.blue },
    HopNextKey2 = { fg = '#17a2d6' },
    HopUnmatched = { fg = p.faint },
    LightspeedGreyWash = { fg = p.faint },
    ISwapGrey = { fg = p.faint },
    ISwapSnipe = { fg = p.bg, bg = p.yellow },

    NeogitPopupActionKey = { fg = p.magenta },
    NeogitPopupSwitchKey = { fg = p.magenta },
    NeogitPopupOptionKey = { fg = p.blue },
    NeogitPopupSwitchEnabled = { fg = p.cyan },
    NeogitPopupActionDisabled = { fg = p.muted },
    NeogitPopupOptionDisabled = { fg = p.muted },
    NeogitPopupSwitchDisabled = { fg = p.muted },

    StartifyBracket = { fg = p.muted },
    StartifyFile = { fg = p.fg },
    StartifyPath = { fg = '#4e6e75' },
    StartifySlash = { fg = '#4e6e75' },
    StartifySection = { fg = p.green },

    NoiceCmdlineIcon = { fg = p.bright_green },
    NoiceCmdlinePopupBorder = { fg = p.bright_green },
    NoiceCmdlineIconSearch = { fg = p.yellow },
    NoiceCmdlinePopupBorderSearch = { fg = p.yellow },
    NoiceConfirmBorder = { link = 'NoiceCmdlinePopupBorder' },
}

-- LSP declarations / definitions get the blue accent
for _, name in ipairs({
    'class.declaration',
    'class.definition',
    'enum.declaration',
    'function.declaration',
    'function.definition',
    'macro.declaration',
    'method.declaration',
    'struct.declaration',
    'type.declaration',
}) do
    groups['@lsp.typemod.' .. name] = { fg = p.blue }
end

-- Noice cmdline variants share the base icon/border colours
for _, kind in ipairs({ 'Cmdline', 'Filter', 'Lua' }) do
    groups['NoiceCmdlineIcon' .. kind] = { link = 'NoiceCmdlineIcon' }
    groups['NoiceCmdlinePopupBorder' .. kind] = { link = 'NoiceCmdlinePopupBorder' }
end

-- Custom statusline groups
for name, fg in pairs({
    Add = '#284918',
    Blue = p.blue,
    Cyan = p.cyan,
    Err = '#8e1410',
    Green = p.green,
    Hint = p.blue,
    Info = p.info,
    Magenta = p.magenta,
    Red = p.red,
    Warn = p.warn,
}) do
    groups['Statusline' .. name] = { fg = fg, bg = p.bg_status }
end

-- Rainbow delimiters
for i, c in ipairs({ p.yellow, p.magenta, p.blue, p.green, p.bright_yellow, p.red, p.cyan }) do
    groups['rainbowcol' .. i] = { fg = c }
end

for name, spec in pairs(groups) do
    vim.api.nvim_set_hl(0, name, spec)
end
