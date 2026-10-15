return {
    'ibhagwan/fzf-lua',
    config = function()
        vim.cmd [[FzfLua register_ui_select]]
    end,
}
