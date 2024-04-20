return {
    {
        "stevearc/oil.nvim",
        opts = {},
        dependencies = { "nvim-tree/nvim-web-devicons" },
        config = function()
            require("oil").setup()
            vim.keymap.set("n", "<leader>o", "<cmd>Oil<cr>", { desc = "Open [O]il" })
        end,
    },
    {
        "windwp/nvim-autopairs",
        event = "InsertEnter",
        config = true,
    },
    {
        "johmsalas/text-case.nvim",
        dependencies = { "nvim-telescope/telescope.nvim" },
        config = function()
            require("textcase").setup {}
            require("telescope").load_extension "textcase"
        end,
        keys = {
            "ga", -- Default invocation prefix
            {
                "ga.",
                "<cmd>TextCaseOpenTelescope<CR>",
                mode = { "n", "x" },
                desc = "Telescope",
            },
        },
    },
    {
        "kdheepak/lazygit.nvim",
        cmd = {
            "LazyGit",
            "LazyGitConfig",
            "LazyGitCurrentFile",
            "LazyGitFilter",
            "LazyGitFilterCurrentFile",
        },
        -- optional for floating window border decoration
        dependencies = {
            "nvim-lua/plenary.nvim",
        },
        -- setting the keybinding for LazyGit with 'keys' is recommended in
        -- order to load the plugin when the command is run for the first time
        keys = {
            {
                "<leader>lg",
                "<cmd>LazyGit<cr>",
                desc = "LazyGit",
            },
        },
    },
    {
        "folke/noice.nvim",
        event = "VeryLazy",
        opts = {
            ---@type NoicePresets
            presets = {},
        },
        dependencies = {
            "MunifTanjim/nui.nvim",
            "rcarriga/nvim-notify",
            "nvim-telescope/telescope.nvim",
        },
        config = function(opts)
            require("noice").setup(opts)
            require("telescope").load_extension "noice"
            vim.keymap.set("n", "<leader>sm", "<cmd>Telescope noice<cr>", { desc = "[S]earch [M]essages" })
        end,
    },
    {

        "ThePrimeagen/harpoon",
        branch = "harpoon2",
        dependencies = { "nvim-lua/plenary.nvim" },
        config = function()
            local harpoon = require "harpoon"
            harpoon:setup()

            local function nmap(lhs, rhs, opts)
                opts = opts or {}
                vim.keymap.set("n", lhs, rhs, opts)
            end
            nmap("<leader>aa", function()
                harpoon:list():add()
            end, { desc = "Harpoon [A]dd" })
            nmap("<leader>aj", function()
                harpoon:list():select(1)
            end, { desc = "Harpoon Select 1" })
            nmap("<leader>ak", function()
                harpoon:list():select(2)
            end, { desc = "Harpoon Select 2" })
            nmap("<leader>al", function()
                harpoon:list():select(3)
            end, { desc = "Harpoon Select 3" })
            nmap("<leader>a;", function()
                harpoon:list():select(4)
            end, { desc = "Harpoon Select 4" })
            nmap("<leader>ah", function()
                harpoon.ui:toggle_quick_menu(harpoon:list())
            end, { desc = "Harpoon menu" })
        end,
    },
    {
        "folke/trouble.nvim",
        branch = "dev", -- IMPORTANT!
        keys = {
            {
                "<leader>xx",
                "<cmd>Trouble diagnostics toggle<cr>",
                desc = "Diagnostics (Trouble)",
            },
            {
                "<leader>xX",
                "<cmd>Trouble diagnostics toggle filter.buf=0<cr>",
                desc = "Buffer Diagnostics (Trouble)",
            },
            {
                "<leader>cs",
                "<cmd>Trouble symbols toggle focus=false<cr>",
                desc = "Symbols (Trouble)",
            },
            {
                "<leader>cl",
                "<cmd>Trouble lsp toggle focus=false win.position=right<cr>",
                desc = "LSP Definitions / references / ... (Trouble)",
            },
            {
                "<leader>xL",
                "<cmd>Trouble loclist toggle<cr>",
                desc = "Location List (Trouble)",
            },
            {
                "<leader>xQ",
                "<cmd>Trouble qflist toggle<cr>",
                desc = "Quickfix List (Trouble)",
            },
        },
        opts = {}, -- for default options, refer to the configuration section for custom setup.
    },
    {
        "max397574/better-escape.nvim",
        config = true,
    },
    {
        "kylechui/nvim-surround",
        version = "*",
        event = "VeryLazy",
        opts = {},
    },
    {
        "freddiehaddad/feline.nvim",
        enabled = true,
        config = function()
            local opts = require "custom.configs.feline"
            require("feline").setup(opts)
            require("feline").winbar.setup()
        end,
    },

    -- local plugins
    {
        "snak/runner.nvim",
        dependencies = {
            "MunifTanjim/nui.nvim",
        },
        opts = {},
    },
}
