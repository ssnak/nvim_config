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
        opts = {},
    },
    {
        "nvim-lualine/lualine.nvim",
        event = "BufEnter",
        dependencies = { "nvim-tree/nvim-web-devicons" },
        opts = {
            options = { theme = "tokyonight" },
            sections = {
                lualine_x = { "encoding", "filetype" },
            },
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
            "hrsh7th/nvim-cmp",
            "nvim-telescope/telescope.nvim",
            "nvim-treesitter/nvim-treesitter",
        },
        keys = require("configs.obsidian").keys,
        opts = require("configs.obsidian").opts,
        cmd = require("configs.obsidian").cmd,
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
            vim.keymap.set("n", "<leader>xm", "<cmd>Noice dismiss<cr>", { desc = "Dismiss [M]essages" })
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
        opts = { lazygit = {} },
        keys = {
            {
                "<leader>lg",
                function()
                    require("snacks").lazygit.open()
                end,
                desc = "LazyGit",
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
