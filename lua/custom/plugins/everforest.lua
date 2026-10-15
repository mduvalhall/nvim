return {
    'neanias/everforest-nvim',
    version = false,
    lazy = false,
    priority = 1000,
    config = function()
        require('everforest').setup({
            enable_italic = false,
            disable_italic_comments = true,
        })
    end,
}
