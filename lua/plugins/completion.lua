return {
    {
        "saghen/blink.compat",
        version = "*",
        opts = {},
    },

    {
        "saghen/blink.cmp",
        event = "InsertEnter",
        version = "1.*",
        dependencies = {
            {
                "L3MON4D3/LuaSnip",
                build = (function()
                    if vim.fn.has "win32" == 1 or vim.fn.executable "make" == 0 then
                        return
                    end
                    return "make install_jsregexp"
                end)(),
                dependencies = {
                    {
                        "rafamadriz/friendly-snippets",
                        config = function()
                            require("luasnip.loaders.from_vscode").lazy_load()
                        end,
                    },
                },
            },
        },
        opts = {
            snippets = { preset = "luasnip" },
            sources = {
                default = { "lsp", "path", "snippets", "buffer" },
                per_filetype = { lua = { inherit_defaults = true, "lazydev" } },
                providers = {
                    lazydev = {
                        name = "LazyDev",
                        module = "lazydev.integrations.blink",
                        score_offset = 100,
                    },
                },
            },
            keymap = {
                preset = "none",
                ["<C-h>"] = { "snippet_backward" },
                ["<C-l>"] = { "snippet_forward" },
                ["<C-b>"] = { "scroll_documentation_up" },
                ["<C-f>"] = { "scroll_documentation_down" },
                ["<C-p>"] = { "select_prev" },
                ["<C-n>"] = { "select_next" },
                ["<CR>"] = { "accept", "fallback" },
            },
            completion = {
                documentation = {
                    auto_show = true,
                },
            },
        },
    },
}
