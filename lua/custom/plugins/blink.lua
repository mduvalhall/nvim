return {
    'saghen/blink.cmp',
    dependencies = { 'rafamadriz/friendly-snippets' },

    version = '1.*',

    ---@module 'blink.cmp'
    ---@type blink.cmp.Config
    opts = {
        keymap = {
            preset = 'default',
            ['<C-e>'] = {'show', 'hide'},
        },

        appearance = {
            nerd_font_variant = 'mono',
        },

        completion = {
            menu = {
                auto_show = false,
            },
            documentation = {
                auto_show = true,
            },
        },

        sources = {
            default = { 'lsp', 'path', 'snippets', 'buffer' },
        },

        fuzzy = {
            implementation = 'prefer_rust_with_warning',
        },

        accept = {
            auto_brackets = {
                enabled = false,
            },
        },
    },
    opts_extend = { 'sources.default' },
}
