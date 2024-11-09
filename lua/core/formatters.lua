local formatters_by_ft = {
    lua = { "stylua" },
    go = { "gofumpt" },
    cpp = { "clang-format" },
    cmake = { "cmake_format" },
}

return formatters_by_ft
