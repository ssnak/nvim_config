local formatters_by_ft = {
    lua = { "stylua" },
    luau = { "stylua" },
    cpp = { "clang-format" },
    cmake = { "cmakelang" },
    go = { "gofumpt" },
    java = { "clang-format" },
}

return formatters_by_ft
