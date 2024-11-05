return {
    -- If you want to see what colorschemes are already installed, you can use `:Telescope colorscheme`.
    "folke/tokyonight.nvim",
    lazy = false,
    priority = 1000, -- Make sure to load this before all the other start plugins.
    opts = {
        transparent = true,
    },
    init = function()
        vim.cmd.colorscheme "tokyonight-night"
    end,
}
