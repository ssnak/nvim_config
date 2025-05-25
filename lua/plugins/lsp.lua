return {
    { "mfussenegger/nvim-jdtls" },
    { "folke/lazydev.nvim", ft = "lua", opts = {} },
    {
        "neovim/nvim-lspconfig",
        version = "1.*",
        event = "BufReadPre",
        dependencies = {
            { "mason-org/mason.nvim", branch = "v1.x" },
            { "mason-org/mason-lspconfig.nvim", branch = "v1.x" },
            { "WhoIsSethDaniel/mason-tool-installer.nvim" },

            {
                "folke/neoconf.nvim",
                opts = {
                    import = {
                        vscode = false,
                        coc = false,
                        nlsp = false,
                    },
                },
            },
            { "j-hui/fidget.nvim", opts = {} },
            {
                "nvimdev/lspsaga.nvim",
                opts = {
                    lightbulb = { sign = false },
                    rename = { in_select = false },
                },
            },
        },
        config = function()
            vim.api.nvim_create_autocmd("LspAttach", {
                group = vim.api.nvim_create_augroup("lsp-attach", { clear = true }),
                callback = function(event)
                    local map = function(keys, func, desc)
                        vim.keymap.set("n", keys, func, { buffer = event.buf, desc = "LSP: " .. desc })
                    end

                    --  To jump back, press <C-t>.
                    map("<leader>sld", require("telescope.builtin").lsp_definitions, "[S]earch [D]efinition")
                    map("<leader>slr", require("telescope.builtin").lsp_references, "[S]earch [R]eferences")
                    map(
                        "<leader>sli",
                        require("telescope.builtin").lsp_implementations,
                        "[S]earch [I]mplementation"
                    )
                    map("<leader>slt", require("telescope.builtin").lsp_type_definitions, "[T]ype Definition")
                    map(
                        "<leader>sld",
                        require("telescope.builtin").lsp_document_symbols,
                        "[D]ocument Symbols"
                    )
                    map(
                        "<leader>slw",
                        require("telescope.builtin").lsp_dynamic_workspace_symbols,
                        "[W]orkspace Symbols"
                    )
                    map("grn", "<cmd>Lspsaga rename<cr>", "[R]e[n]ame")
                    map("gra", "<cmd>Lspsaga code_action<cr>", "Code [A]ction")
                    map("gpd", "<cmd>Lspsaga peek_definition<cr>", "[P]eek [D]efinition")
                    map("gpt", "<cmd>Lspsaga peek_type_definition<cr>", "[P]eek [T]ype Definition")
                    map("gO", "<cmd>Lspsaga outline<cr>", "Document Symbols")
                    map("grk", "<cmd>Lspsaga hover_doc ++keep<cr>", "Hover")

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
                vim.tbl_deep_extend("force", capabilities, require("blink.cmp").get_lsp_capabilities())

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
                    jdtls = function() end,
                },
            }
        end,
    },
}
