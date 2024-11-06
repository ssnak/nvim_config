local util = require "lspconfig.util"
local servers = {
    clangd = {},
    cmake = {},
    gopls = {},
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
