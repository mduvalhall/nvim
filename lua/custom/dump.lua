local hl = vim.api.nvim_get_hl(0, {})
local names = vim.tbl_keys(hl)
table.sort(names)

local function hex(n)
    return n and string.format('#%06x', n) or nil
end

local lines = {
    "vim.cmd('hi clear')",
    "vim.o.background = 'light'",
    "vim.g.colors_name = 'mytheme'",
    'local hl = vim.api.nvim_set_hl',
}
for _, name in ipairs(names) do
    local spec = hl[name]
    spec.fg, spec.bg, spec.sp = hex(spec.fg), hex(spec.bg), hex(spec.sp)
    table.insert(lines, ('hl(0, %q, %s)'):format(name, vim.inspect(spec, { newline = ' ', indent = '' })))
end

local dir = vim.fn.stdpath('config') .. '/colors'
vim.fn.mkdir(dir, 'p')
vim.fn.writefile(lines, dir .. '/mytheme.lua')
