return {
    {
        "stevearc/oil.nvim",
        keys = {
            { "<leader>o", vim.cmd.Oil, desc = "Open [O]il" },
        },
        opts = {},
        config = function(_, opts)
            require("oil").setup(opts)
            vim.api.nvim_create_autocmd("User", {
                pattern = "OilActionsPost",
                callback = function(event)
                    if event.data.actions.type == "move" then
                        Snacks.rename.on_rename_file(event.data.actions.src_url, event.data.actions.dest_url)
                    end
                end,
            })
        end,
        dependencies = { "nvim-tree/nvim-web-devicons" },
    },
    {

        "ThePrimeagen/harpoon",
        keys = require("configs.harpoon").keys,
        branch = "harpoon2",
        dependencies = { "nvim-lua/plenary.nvim" },
        config = require("configs.harpoon").setup,
    },
    {
        "folke/trouble.nvim",
        branch = "main",
        keys = require("configs.trouble").keys,
        cmd = "Trouble",
        opts = {},
    },
    {
        "nvim-lualine/lualine.nvim",
        event = "BufEnter",
        dependencies = { "nvim-tree/nvim-web-devicons" },
        opts = {
            options = { theme = "tokyonight" },
            sections = {
                lualine_a = {
                    {
                        "mode",
                        fmt = function(str)
                            local reg = vim.fn.reg_recording()
                            return reg ~= "" and "REC @" .. reg or str
                        end,
                    },
                },
                lualine_x = { "encoding", "filetype" },
            },
        },
    },
    {
        "lewis6991/gitsigns.nvim",
        event = "VeryLazy",
        tag = "release",
        opts = {
            signs = {
                add = { text = "+" },
                change = { text = "~" },
                delete = { text = "_" },
                topdelete = { text = "‾" },
                changedelete = { text = "~" },
            },
            on_attach = function(bufnr)
                local gitsigns = require "gitsigns"

                local function map(mode, l, r, opts)
                    opts = opts or {}
                    opts.buffer = bufnr
                    vim.keymap.set(mode, l, r, opts)
                end

                -- Navigation
                map("n", "]c", function()
                    if vim.wo.diff then
                        vim.cmd.normal { "]c", bang = true }
                    else
                        gitsigns.nav_hunk "next"
                    end
                end)

                map("n", "[c", function()
                    if vim.wo.diff then
                        vim.cmd.normal { "[c", bang = true }
                    else
                        gitsigns.nav_hunk "prev"
                    end
                end)

                -- Actions
                map("n", "<leader>hs", gitsigns.stage_hunk)
                map("n", "<leader>hr", gitsigns.reset_hunk)

                map("v", "<leader>hs", function()
                    gitsigns.stage_hunk { vim.fn.line ".", vim.fn.line "v" }
                end)

                map("v", "<leader>hr", function()
                    gitsigns.reset_hunk { vim.fn.line ".", vim.fn.line "v" }
                end)

                map("n", "<leader>hS", gitsigns.stage_buffer)
                map("n", "<leader>hR", gitsigns.reset_buffer)
                map("n", "<leader>hp", gitsigns.preview_hunk)
                map("n", "<leader>hi", gitsigns.preview_hunk_inline)

                map("n", "<leader>hb", function()
                    gitsigns.blame_line { full = true }
                end)

                map("n", "<leader>hd", gitsigns.diffthis)

                map("n", "<leader>hD", function()
                    gitsigns.diffthis "~"
                end)

                map("n", "<leader>hQ", function()
                    gitsigns.setqflist "all"
                end)
                map("n", "<leader>hq", gitsigns.setqflist)

                -- Toggles
                map("n", "<leader>tb", gitsigns.toggle_current_line_blame)
                map("n", "<leader>tw", gitsigns.toggle_word_diff)

                -- Text object
                map({ "o", "x" }, "ih", gitsigns.select_hunk)
            end,
        },
    },
    {
        "https://github.com/ggandor/leap.nvim",
        keys = {
            {
                "s",
                function()
                    require("leap").leap {}
                end,
                desc = "Leap Forward",
            },
            {
                "S",
                function()
                    require("leap").leap { backward = true }
                end,
                desc = "Leap Backward",
            },
        },
    },
    {
        "epwalsh/obsidian.nvim",
        version = "*",
        ft = "markdown",
        dependencies = {
            "nvim-telescope/telescope.nvim",
            "nvim-treesitter/nvim-treesitter",
        },
        keys = require("configs.obsidian").keys,
        cmd = require("configs.obsidian").cmd,
        opts = require("configs.obsidian").opts,
        config = function(_, opts)
            require("obsidian").setup(opts)
            local cmp = require "cmp"
            local blink_cmp = require "blink-cmp"
            cmp.register_source("obsidian", require("cmp_obsidian").new())
            cmp.register_source("obsidian_new", require("cmp_obsidian_new").new())
            cmp.register_source("obsidian_tags", require("cmp_obsidian_tags").new())

            blink_cmp.add_source_provider("cmp_obsidian", {
                name = "obsidian",
                module = "blink.compat.source",
            })
            blink_cmp.add_source_provider("cmp_obsidian_new", {
                name = "obsidian_new",
                module = "blink.compat.source",
            })
            blink_cmp.add_source_provider("cmp_obsidian_tags", {
                name = "obsidian_tags",
                module = "blink.compat.source",
            })
            blink_cmp.add_filetype_source("markdown", "cmp_obsidian")
            blink_cmp.add_filetype_source("markdown", "cmp_obsidian_new")
            blink_cmp.add_filetype_source("markdown", "cmp_obsidian_tags")
        end,
    },
    { "kylechui/nvim-surround", version = "*", keys = { "ys", "cs", "ds" }, opts = {} },
    { "max397574/better-escape.nvim", event = "InsertEnter", opts = {} },
    { "stevearc/dressing.nvim", event = "VeryLazy", opts = {} },
    { "windwp/nvim-autopairs", event = "InsertEnter", opts = {} },
    {
        "folke/noice.nvim",
        event = "VeryLazy",
        dependencies = {
            "MunifTanjim/nui.nvim",
            "rcarriga/nvim-notify",
            "nvim-telescope/telescope.nvim",
        },
        config = function()
            require("noice").setup {}
            require("telescope").load_extension "noice"
            vim.keymap.set("n", "<leader>sm", "<cmd>Telescope noice<cr>", { desc = "[S]earch [M]essages" })
            vim.keymap.set("n", "<leader>md", "<cmd>NoiceDismiss<cr>", { desc = "[M]essages [D]ismiss" })
            vim.keymap.set("n", "<leader>ma", "<cmd>NoiceAll<cr>", { desc = "[M]essages [A]ll" })
            vim.keymap.set("n", "<leader>ml", "<cmd>NoiceLast<cr>", { desc = "[M]essages [L]ast" })
            vim.keymap.set("n", "<leader>me", "<cmd>NoiceErrors<cr>", { desc = "[M]essages [E]rrors" })
            vim.keymap.set("n", "<leader>mh", "<cmd>NoiceHistory<cr>", { desc = "[M]essages [H]istory" })
            vim.keymap.set({ "n", "i", "s" }, "<c-f>", function()
                if not require("noice.lsp").scroll(4) then
                    return "<c-f>"
                end
            end, { silent = true, expr = true })
            vim.keymap.set({ "n", "i", "s" }, "<c-b>", function()
                if not require("noice.lsp").scroll(-4) then
                    return "<c-b>"
                end
            end, { silent = true, expr = true })
        end,
    },
    {
        "folke/snacks.nvim",
        lazy = false,
        priority = 1000,
        opts = { lazygit = {}, quickfile = {} },
        keys = {
            {
                "<leader>lg",
                function()
                    Snacks.lazygit.open()
                end,
                desc = "LazyGit",
            },
        },
    },
    {
        "folke/todo-comments.nvim",
        event = "VeryLazy",
        opts = { signs = false },
        keys = {
            {
                "<leader>st",
                "<cmd>TodoTelescope<cr>",
                desc = "[S]earch [T]odos",
            },
        },
    },
    {
        "lukas-reineke/indent-blankline.nvim",
        main = "ibl",
        opts = {},
        event = "BufEnter",
    },
    {
        "johmsalas/text-case.nvim",
        dependencies = { "nvim-telescope/telescope.nvim" },
        config = function()
            require("textcase").setup {}
            require("telescope").load_extension "textcase"
        end,
        keys = {
            "ga",
            {
                "ga.",
                "<cmd>TextCaseOpenTelescope<CR>",
                mode = { "n", "x" },
                desc = "Telescope",
            },
        },
    },
}
