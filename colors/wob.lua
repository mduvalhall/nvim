-- wob: white on blue
-- Install: ~/.config/nvim/colors/wob.lua
-- Use:     :colorscheme wob

vim.o.termguicolors = true
vim.cmd [[syntax clear]]
vim.cmd [[hi clear]]
vim.g.colors_name = 'wob'
vim.opt.background = 'dark'

local function highlight(group, opts)
    vim.api.nvim_set_hl(0, group, opts)
end

local palette = {
    bg = '#012456',
    -- shades on a gradient from bg to light blue #9ec4ff
    faint = '#FFFFFF',   -- listchars
    comment = '#5074ab', -- comments / number column
    str = '#FFFFFF',     -- strings
    const = '#FFFFFF',   -- constants, numbers, booleans
    fun = '#8FB2FF',     -- functions, types, constructors
    fg = '#FFFFFF',      -- everything else
}

-- editor
highlight('Normal', { bg = palette.bg, fg = palette.fg })
highlight('NormalFloat', { bg = palette.bg, fg = palette.fg })
highlight('FloatBorder', { bg = palette.bg, fg = palette.fg })
highlight('FloatTitle', { bg = palette.bg, fg = palette.fg })
highlight('CursorLine', { bg = palette.bg })
highlight('ColorColumn', { bg = palette.bg })
highlight('SignColumn', { bg = palette.bg })
highlight('CursorLineNr', { fg = palette.fg })
highlight('StatusLine', { bg = palette.bg, fg = palette.fg })
highlight('StatusLineNC', { bg = palette.bg, fg = palette.comment })
highlight('WinSeparator', { fg = palette.comment })
highlight('Pmenu', { bg = palette.bg, fg = palette.fg })
highlight('PmenuSel', { bg = palette.fg, fg = palette.bg })
highlight('Folded', { bg = palette.bg, fg = palette.comment })
highlight('MatchParen', { fg = palette.fg, bold = true, underline = true })

-- visual: inverted
local inverted = { bg = palette.fg, fg = palette.bg }
highlight('Visual', inverted)
highlight('VisualNOS', inverted)

-- search
highlight('Search', { bg = palette.comment, fg = palette.bg })
highlight('CurSearch', inverted)
highlight('IncSearch', inverted)
highlight('Substitute', inverted)

-- listchars
local faint = { fg = palette.faint }
highlight('Whitespace', faint)
highlight('NonText', faint)
highlight('SpecialKey', faint)

-- syntax (treesitter captures link to these by default)
local plain = { fg = palette.fg }
highlight('Identifier', plain)
highlight('Statement', plain)
highlight('Operator', plain)
highlight('PreProc', plain)
highlight('Special', plain)
highlight('Delimiter', plain)
highlight('Title', plain)
highlight('Directory', plain)
highlight('Question', plain)
highlight('MoreMsg', plain)
highlight('ErrorMsg', plain)
highlight('WarningMsg', plain)
highlight('Todo', plain)
highlight('@variable', plain)

-- diagnostics / diffs
highlight('DiagnosticError', plain)
highlight('DiagnosticWarn', plain)
highlight('DiagnosticInfo', plain)
highlight('DiagnosticHint', plain)
highlight('DiagnosticOk', plain)
local undercurl = { undercurl = true, sp = palette.fg }
highlight('DiagnosticUnderlineError', undercurl)
highlight('DiagnosticUnderlineWarn', undercurl)
highlight('DiagnosticUnderlineInfo', undercurl)
highlight('DiagnosticUnderlineHint', undercurl)
highlight('DiagnosticUnderlineOk', undercurl)
highlight('Added', plain)
highlight('Changed', plain)
highlight('Removed', plain)

-- comment
local comment = { fg = palette.comment }
highlight('Comment', comment)
highlight('LineNr', comment)
highlight('LineNrAbove', comment)
highlight('LineNrBelow', comment)

-- strings
local str = { fg = palette.str }
highlight('String', str)
highlight('Character', str)

-- constants
local const = { fg = palette.const }
highlight('Constant', const)
highlight('Number', const)
highlight('Float', const)
highlight('Boolean', const)
highlight('@constant.builtin', const)

-- functions, types and constructors
local fun = { fg = palette.fun }
highlight('Function', fun)
highlight('@function', fun)
highlight('@function.call', fun)
highlight('@function.builtin', fun)
highlight('@function.method', fun)
highlight('@function.method.call', fun)
highlight('Type', fun)
highlight('@type', fun)
highlight('@type.builtin', fun)
highlight('@constructor', fun)
