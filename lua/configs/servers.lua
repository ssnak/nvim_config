local lspconfig = require "lspconfig"
local util = lspconfig.util
lspconfig.dartls.setup {}
lspconfig.nushell.setup {}

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
    jsonls = {
        root_dir = function(fname)
            return util.root_pattern ".git"(fname)
        end,
    },
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
}
vim.filetype.add {
    extension = {
        vert = "glsl",
        frag = "glsl",
    },
}

return servers
