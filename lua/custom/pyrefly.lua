local function pyrefly_severity(sev)
    if sev == 'error' then
        return vim.diagnostic.severity.ERROR
    elseif sev == 'warning' then
        return vim.diagnostic.severity.WARN
    end
    return vim.diagnostic.severity.INFO
end

local function find_project_root()
    local markers = { 'pyrefly.toml', 'pyproject.toml' }
    local path = vim.fn.expand('%:p:h')
    local found = vim.fs.find(markers, { path = path, upward = true })[1]
    if found then
        return vim.fn.fnamemodify(found, ':h')
    end
    return vim.fn.getcwd()
end

local function pyrefly_workspace_diagnostics(callback)
    local root = find_project_root()
    local output =
        vim.fn.systemlist(string.format('cd %s && pyrefly check --output-format json', vim.fn.shellescape(root)))
    local text = table.concat(output, '\n')

    local json_str = text:match('(%b{})')
    if not json_str then
        vim.notify('pyrefly check: no JSON found in output', vim.log.levels.WARN)
        return
    end

    local ok, decoded = pcall(vim.json.decode, json_str)
    if not ok or not decoded then
        vim.notify('pyrefly check: failed to parse output', vim.log.levels.WARN)
        return
    end

    local by_file = {}
    for _, err in ipairs(decoded.errors or {}) do
        local abs_path = err.path
        if not abs_path:match('^/') then
            abs_path = root .. '/' .. abs_path
        end
        local uri = vim.uri_from_fname(abs_path)
        by_file[uri] = by_file[uri] or {}
        table.insert(by_file[uri], {
            lnum = err.line - 1,
            col = err.column - 1,
            end_lnum = err.stop_line - 1,
            end_col = err.stop_column - 1,
            message = err.description,
            severity = pyrefly_severity(err.severity),
            source = 'pyrefly',
            code = err.name,
        })
    end

    local ns = vim.api.nvim_create_namespace('pyrefly_check')
    for _, bufnr in ipairs(vim.api.nvim_list_bufs()) do
        vim.diagnostic.reset(ns, bufnr)
    end

    for uri, diags in pairs(by_file) do
        local bufnr = vim.uri_to_bufnr(uri)
        vim.diagnostic.set(ns, bufnr, diags)
    end

    if callback then
        callback()
    end
end

vim.api.nvim_create_user_command('PyreflyWorkspaceDiagnostics', function()
    pyrefly_workspace_diagnostics(function()
        require('fzf-lua').diagnostics_workspace()
    end)
end, {})
