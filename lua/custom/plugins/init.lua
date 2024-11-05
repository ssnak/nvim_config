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
        branch = "dev",
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
    {
        "stevearc/overseer.nvim",
        opts = { templates = { "builtin", "user.rojo_serve" } },
        enabled = false,
        config = function(_, opts)
            require("overseer").setup(opts)
            vim.keymap.set("n", "<leader>rt", "<cmd>OverseerToggle<cr>", { desc = "Overseer [T]oggle" })
            vim.keymap.set("n", "<leader>rr", "<cmd>OverseerRun<cr>", { desc = "Overseer [R]un" })
        end,
    },
    { "stevearc/dressing.nvim", opts = {}, event = "VimEnter" },
    { "max397574/better-escape.nvim", config = true, event = "InsertEnter" },
    { "kylechui/nvim-surround", version = "*", keys = { "ys", "cs", "ds" }, opts = {} },
    {
        "lukas-reineke/indent-blankline.nvim",
        main = "ibl",
        opts = {},
        event = { "BufReadPost", "BufNewFile" },
    },
    { "windwp/nvim-autopairs", event = "InsertEnter", config = true },
    { "andweeb/presence.nvim", opts = { main_image = "file" }, enabled = false },
}
