return {
    {
        "neovim/nvim-lspconfig",
        version = "1.*",
        event = "VeryLazy",
        dependencies = {
            { "mason-org/mason.nvim", branch = "v1.x" },
            { "mason-org/mason-lspconfig.nvim", branch = "v1.x" },
            { "WhoIsSethDaniel/mason-tool-installer.nvim" },

            { "folke/neoconf.nvim", opts = {} },
            { "j-hui/fidget.nvim", opts = {} },
            { "folke/neodev.nvim", opts = {} },
        },
        config = function()
            vim.api.nvim_create_autocmd("LspAttach", {
                group = vim.api.nvim_create_augroup("lsp-attach", { clear = true }),
                callback = function(event)
                    local map = function(keys, func, desc)
                        vim.keymap.set("n", keys, func, { buffer = event.buf, desc = "LSP: " .. desc })
                    end

                    --  To jump back, press <C-t>.
                    map("gd", require("telescope.builtin").lsp_definitions, "[G]oto [D]efinition")
                    map("gr", require("telescope.builtin").lsp_references, "[G]oto [R]eferences")
                    map("gI", require("telescope.builtin").lsp_implementations, "[G]oto [I]mplementation")
                    map("<leader>D", require("telescope.builtin").lsp_type_definitions, "Type [D]efinition")
                    map(
                        "<leader>ds",
                        require("telescope.builtin").lsp_document_symbols,
                        "[D]ocument [S]ymbols"
                    )
                    map(
                        "<leader>ws",
                        require("telescope.builtin").lsp_dynamic_workspace_symbols,
                        "[W]orkspace [S]ymbols"
                    )
                    map("<leader>rn", vim.lsp.buf.rename, "[R]e[n]ame")
                    map("<leader>ca", vim.lsp.buf.code_action, "[C]ode [A]ction")
                    map("K", vim.lsp.buf.hover, "Hover Documentation")
                    map("gD", vim.lsp.buf.declaration, "[G]oto [D]eclaration")

                    local client = vim.lsp.get_client_by_id(event.data.client_id)
                    local bufnr = event.buf
                    if client then
                        if client.server_capabilities.documentHighlightProvider then
                            vim.api.nvim_create_autocmd({ "CursorHold", "CursorHoldI" }, {
                                buffer = bufnr,
                                callback = vim.lsp.buf.document_highlight,
                            })

                            vim.api.nvim_create_autocmd({ "CursorMoved", "CursorMovedI" }, {
                                buffer = bufnr,
                                callback = vim.lsp.buf.clear_references,
                            })
                        end

                        local filetype = vim.bo[bufnr].filetype
                        if
                            (filetype == "cpp" or filetype == "c")
                            and client.supports_method "textDocument/switchSourceHeader"
                        then
                            vim.keymap.set("n", "gh", function()
                                vim.cmd.ClangdSwitchSourceHeader()
                            end, { desc = "Switch to header file" })
                        end
                    end
                end,
            })

            local capabilities = vim.lsp.protocol.make_client_capabilities()
            capabilities =
                vim.tbl_deep_extend("force", capabilities, require("cmp_nvim_lsp").default_capabilities())

            local servers = require "configs.servers"

            require("mason").setup()

            local ensure_installed = vim.tbl_keys(servers or {})
            local formatters = vim.iter(vim.tbl_values(require "configs.formatters")):flatten():totable()
            local linters = vim.iter(vim.tbl_values(require "configs.linters")):flatten():totable()
            local debuggers = require "configs.debuggers"
            vim.list_extend(ensure_installed, formatters)
            vim.list_extend(ensure_installed, linters)
            vim.list_extend(ensure_installed, debuggers)

            -- Remove duplicates
            ensure_installed = (function()
                local seen = {}
                return vim.tbl_filter(function(v)
                    if not seen[v] then
                        seen[v] = true
                        return true
                    end
                    return false
                end, ensure_installed)
            end)()
            require("mason-tool-installer").setup { ensure_installed = ensure_installed }

            require("mason-lspconfig").setup {
                -- Uncomment this when updating
                -- automatic_enable = false,
                -- ensure_installed = {},
                handlers = {
                    function(server_name)
                        local server = servers[server_name] or {}
                        server.capabilities =
                            vim.tbl_deep_extend("force", {}, capabilities, server.capabilities or {})
                        require("lspconfig")[server_name].setup(server)
                    end,
                },
            }
        end,
    },
}
