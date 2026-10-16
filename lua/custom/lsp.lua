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
configure_and_enable('ty', {
    cmd = { 'ty', 'server' },
    filetypes = { 'python' },
    root_markers = { 'ty.toml', 'pyproject.toml', 'setup.py', 'setup.cfg', 'requirements.txt', '.git' },
    settings = {
        ty = {
            diagnosticMode = 'workspace',
        },
    },
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

-- helpers

local function lsp_restart()
    local clients = vim.lsp.get_clients()
    for _, client in ipairs(clients) do
        client:stop()
    end

    local timer = vim.uv.new_timer()
    if timer then
        timer:start(
            100,
            100,
            vim.schedule_wrap(function()
                if #vim.lsp.get_clients() > 0 then
                    return
                end
                timer:stop()
                timer:close()
                for _, buf in ipairs(vim.api.nvim_list_bufs()) do
                    if vim.api.nvim_buf_is_loaded(buf) and vim.bo[buf].filetype ~= '' then
                        vim.api.nvim_exec_autocmds('FileType', { buffer = buf })
                    end
                end
                vim.notify('Restarted ' .. #clients .. ' LSP client(s)')
            end)
        )
    end
end

vim.api.nvim_create_user_command('LspRestart', lsp_restart, {})
