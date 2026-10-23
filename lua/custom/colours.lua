local function highlight(group, opts)
    vim.api.nvim_set_hl(0, group, opts)
end

vim.api.nvim_create_autocmd('ColorScheme', {
    callback = function()
        highlight('CursorLine', { bg = '#DDDDDD' })
        highlight('ColorColumn', { bg = '#DDDDDD' })
        highlight('CursorLineNr', { fg = '#000000' })
        highlight('Special', { link = '@variable' })
        highlight('@constructor.python', { link = '@function' })

        -- Claude light palette
        local keyword = '#8100C2'
        local func = '#0051C2'
        local type = '#B34A00'
        local param = '#B84F05'
        local string = '#008000'
        local teal = '#008080'
        local punct = '#2B303B'

        -- Keywords
        for _, g in ipairs({
            'Keyword',
            'Statement',
            'Conditional',
            'Repeat',
            'Include',
            'Exception',
            '@keyword',
            '@keyword.function',
            '@keyword.import',
            '@keyword.return',
            '@keyword.conditional',
            '@keyword.repeat',
            '@keyword.exception',
            '@keyword.operator',
            '@keyword.type',
            '@keyword.coroutine',
            '@keyword.modifier',
            '@variable.builtin',
        }) do
            highlight(g, { fg = keyword })
        end

        -- Functions and calls
        for _, g in ipairs({
            'Function',
            '@function',
            '@function.call',
            '@function.method',
            '@function.method.call',
            '@function.builtin',
            '@function.macro',
            '@attribute',
            '@AlabasterDefinition',
        }) do
            highlight(g, { fg = func })
        end

        -- Comments
        for _, g in ipairs({ 'Comment', '@comment', '@comment.documentation' }) do
            highlight(g, { fg = '#6E7687' })
        end

        -- Types
        for _, g in ipairs({ 'Type', '@type', '@type.builtin' }) do
            highlight(g, { fg = type })
        end

        -- Parameters
        highlight('@variable.parameter', { fg = param })

        -- Strings
        for _, g in ipairs({ '@AlabasterString', 'String', 'Character', '@string', '@character' }) do
            highlight(g, { fg = string })
        end
        highlight('@string.escape', { fg = teal })
        highlight('@string.special', { fg = teal })

        -- Numbers, booleans, None
        for _, g in ipairs({
            'Number',
            'Float',
            'Boolean',
            'Constant',
            '@number',
            '@number.float',
            '@boolean',
            '@constant.builtin',
        }) do
            highlight(g, { fg = teal })
        end

        -- Punctuation and operators
        for _, g in ipairs({
            'Delimiter',
            '@punctuation.delimiter',
            '@punctuation.bracket',
            '@punctuation.special',
        }) do
            highlight(g, { fg = 'None' })
        end
        highlight('@operator', { fg = 'NONE' })

        -- Rust
        highlight('@variable.parameter.rust', { fg = 'NONE' })
        highlight('@module.rust', { fg = 'NONE' })
        highlight('@constructor.rust', { fg = type })
        highlight('@label.rust', { fg = type }) -- lifetimes
        highlight('@punctuation.delimiter.rust', { fg = 'NONE' }) -- :: and .
    end,
})

vim.opt.background = 'light'
vim.cmd.colorscheme('alabaster')

vim.cmd('highlight DiagnosticUnderlineError gui=underline guisp=Red')
vim.cmd('highlight DiagnosticUnderlineWarn gui=underline guisp=Orange')
vim.cmd('highlight DiagnosticUnderlineInfo gui=underline guisp=Blue')
vim.cmd('highlight DiagnosticUnderlineHint gui=underline guisp=Gray')
