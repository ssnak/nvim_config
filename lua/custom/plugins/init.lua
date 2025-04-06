return {
    {
        "stevearc/oil.nvim",
        keys = {
            { "<leader>o", vim.cmd.Oil, desc = "Open [O]il" },
        },
        opts = {},
        dependencies = { "nvim-tree/nvim-web-devicons" },
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
    {
        "kdheepak/lazygit.nvim",
        cmd = {
            "LazyGit",
            "LazyGitConfig",
            "LazyGitCurrentFile",
            "LazyGitFilter",
            "LazyGitFilterCurrentFile",
        },
        dependencies = { "nvim-lua/plenary.nvim" },
        keys = {
            { "<leader>lg", "<cmd>LazyGit<cr>", desc = "LazyGit" },
        },
    },
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
            vim.keymap.set("n", "<leader>xm", "<cmd>Noice dismiss<cr>", { desc = "Dismiss [M]essages" })
        end,
    },
    {

        "ThePrimeagen/harpoon",
        keys = { "<leader>aa", "<leader>ah", "<leader>aj", "<leader>ak", "<leader>al", "<leader>a;" },
        branch = "harpoon2",
        dependencies = { "nvim-lua/plenary.nvim" },
        config = require "custom.configs.harpoon",
    },
    {
        "folke/trouble.nvim",
        branch = "main",
        keys = require("custom.configs.trouble").keys,
        opts = {},
    },
    {
        "nvim-lualine/lualine.nvim",
        event = "VimEnter",
        dependencies = { "nvim-tree/nvim-web-devicons" },
        opts = {
            options = { theme = "tokyonight" },
            sections = {
                lualine_x = { "encoding", "overseer", "filetype" },
            },
        },
    },
    { "stevearc/dressing.nvim", opts = {}, event = "VimEnter" },
    {
        "max397574/better-escape.nvim",
        opts = {},
        event = "InsertEnter",
    },
    { "kylechui/nvim-surround", version = "*", keys = { "ys", "cs", "ds" }, opts = {} },
    {
        "lukas-reineke/indent-blankline.nvim",
        main = "ibl",
        opts = {},
        event = { "BufReadPost", "BufNewFile" },
    },
    { "windwp/nvim-autopairs", event = "InsertEnter", config = true },
    {
        "https://github.com/ggandor/leap.nvim",
        keys = {
            {
                "s",
                function()
                    require("leap").leap {}
                end,
                desc = "Leap Forwards",
            },
            {
                "S",
                function()
                    require("leap").leap { backward = true }
                end,
                desc = "Leap Backwards",
            },
        },
    },
    {
        "epwalsh/obsidian.nvim",
        version = "*",
        lazy = true,
        ft = "markdown",
        dependencies = {
            "nvim-lua/plenary.nvim",
            "hrsh7th/nvim-cmp",
            "nvim-telescope/telescope.nvim",
            "nvim-treesitter/nvim-treesitter",
        },
        keys = {
            {
                "<leader>nn",
                vim.cmd.ObsidianNew,
                desc = "New Note",
            },
            {
                "<leader>ns",
                vim.cmd.ObsidianSearch,
                desc = "Search Note",
            },
            {
                "<leader>nr",
                vim.cmd.ObsidianRename,
                desc = "Rename Note",
            },
            {
                "<leader>nt",
                vim.cmd.ObsidianTags,
                desc = "Search Notes By Tag",
            },
        },
        opts = {
            workspaces = {
                {
                    name = "personal",
                    path = "/mnt/c/Users/sergr/vaults/personal",
                },
            },
            completion = {
                nvim_cmp = true,
            },
        },
    },
    {
        "iamcco/markdown-preview.nvim",
        cmd = { "MarkdownPreviewToggle", "MarkdownPreview", "MarkdownPreviewStop" },
        build = "cd app && npm install",
        init = function()
            vim.g.mkdp_filetypes = { "markdown" }
            vim.g.mkdp_browser = "vivaldi"
        end,
        ft = { "markdown" },
    },
}
