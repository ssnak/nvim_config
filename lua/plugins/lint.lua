return {
    {
        "mfussenegger/nvim-lint",
        event = "VeryLazy",
        config = function()
            local lint = require "lint"
            lint.linters_by_ft = require "configs.linters"
            local lint_augroup = vim.api.nvim_create_augroup("lint", { clear = true })
            vim.api.nvim_create_autocmd({ "BufEnter", "BufWritePost", "InsertLeave" }, {
                group = lint_augroup,
                callback = function()
                    require("lint").try_lint()
                end,
            })
        end,
    },
}
