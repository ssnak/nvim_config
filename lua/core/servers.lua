local util = require "lspconfig.util"
require("lspconfig").perlpls.setup {}
local servers = {
    clangd = {},
    cmake = {},
    gopls = {},
    bashls = {},
    emmet_language_server = {},
    svelte = {},
    tailwindcss = {},
    ts_ls = {},
    sqls = {},
    html = {},
    pyright = {},
    ocamllsp = {},
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
