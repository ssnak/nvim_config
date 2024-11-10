--        For example, to see the options for `lua_ls`, you could go to: https://luals.github.io/wiki/settings/
local util = require "lspconfig.util"
local servers = {
    clangd = {},
    gopls = {},
    pyright = {},
    rust_analyzer = {},
    ts_ls = {},
    powershell_es = {},
    glsl_analyzer = {},
    jsonls = {
        root_dir = function(fname)
            return util.root_pattern ".git"(fname)
        end,
    },
    lua_ls = {
        -- cmd = {...},
        -- filetypes = { ...},
        -- capabilities = {},
        settings = {
            Lua = {
                completion = {
                    callSnippet = "Replace",
                },
                -- You can toggle below to ignore Lua_LS's noisy `missing-fields` warnings
                -- diagnostics = { disable = { 'missing-fields' } },
            },
        },
    },
}
vim.filetype.add {
    extension = {
        vert = "glsl",
        frag = "glsl",
    },
}

return servers
