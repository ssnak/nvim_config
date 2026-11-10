-- local lspconfig = require "lspconfig"
-- local util = lspconfig.util
-- lspconfig.dartls.setup {}
-- lspconfig.nushell.setup {}

--- @type { [string]: vim.lsp.Config }
local servers = {
    clangd = {},
    cmake = {},
    gopls = {},
    pyright = {},
    ts_ls = {},
    powershell_es = {},
    zls = {},
    dcm = {},
    rust_analyzer = {},
    glsl_analyzer = {},
    jsonls = {},
    lua_ls = {
        settings = {
            Lua = {
                completion = {
                    callSnippet = "Replace",
                },
                diagnostics = { disable = { "missing-fields" } },
            },
        },
    },
    luau_lsp = {},
    qmlls = {},
}

vim.filetype.add {
    extension = {
        vert = "glsl",
        frag = "glsl",
        vsh = "glsl",
        fsh = "glsl",
        re = "cpp", -- For re2c
    },
}

return servers
