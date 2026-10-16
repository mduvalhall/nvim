local configure_and_enable = function(ls, configuration)
    vim.lsp.config[ls] = configuration
    vim.lsp.enable(ls)
end

-- lua
configure_and_enable('lua_ls', {
    cmd = { 'lua-language-server' },
    filetypes = { 'lua' },
    root_markers = { '.git' },
    settings = {
        Lua = {
            hint = { enable = true },
            telemetry = { enable = false },
            diagnostics = { globals = { 'vim' } },
            workspace = {
                checkThirdParty = false,
                library = vim.api.nvim_get_runtime_file('', true),
            },
        },
    },
})

-- python
configure_and_enable('pyrefly', {
    cmd = { 'pyrefly', 'lsp' },
    filetypes = { 'python' },
})

configure_and_enable('typ', {
    cmd = { 'ty', 'server' },
    filetypes = { 'python' },
    root_markers = { 'ty.toml', 'pyproject.toml', 'setup.py', 'setup.cfg', 'requirements.txt', '.git' },
})

configure_and_enable('ruff', {
    cmd = { 'ruff', 'server' },
    filetypes = { 'python' },
    root_markers = { 'pyproject.toml' },
})

-- vue
local mason_packages = vim.fn.stdpath('data') .. '/mason/packages'
local vue_ls_path = mason_packages .. '/vue-language-server/node_modules/@vue/language-server'
configure_and_enable('ts_ls', {
    filetypes = { 'typescript', 'javascript', 'javascriptreact', 'typescriptreact', 'vue' },
    init_options = {
        plugins = {
            {
                name = '@vue/typescript-plugin',
                location = vue_ls_path,
                languages = { 'vue' },
            },
        },
    },
})
