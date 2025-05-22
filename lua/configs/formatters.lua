local formatters_by_ft = {
    lua = { "stylua" },
    cpp = { "clang-format" },
    cmake = { "cmakelang" },
    go = { "gofumpt" },
}

return formatters_by_ft
