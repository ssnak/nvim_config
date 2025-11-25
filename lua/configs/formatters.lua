local formatters_by_ft = {
    lua = { "stylua" },
    luau = { "stylua" },
    cpp = { "clang-format" },
    c = { "clang-format" },
    cmake = { "cmakelang" },
    go = { "gofumpt" },
    java = { "clang-format" },
    python = { "black" },
}

return formatters_by_ft
