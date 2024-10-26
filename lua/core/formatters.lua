local formatters_by_ft = {
    lua = { "stylua" },
    luau = { "stylua" },
    cpp = { "clang-format" },
    -- Conform can also run multiple formatters sequentially
    -- python = { "isort", "black" },
    --
    -- You can use a sub-list to tell conform to run *until* a formatter
    -- is found.
    -- javascript = { { "prettierd", "prettier" } },
}

return formatters_by_ft
