local formatters_by_ft = {
    lua = { "stylua" },
    go = { "gofumpt" },
    cpp = { "clang-format" },
    -- configure cmakelang formatter
    cmake = { "cmakelang" },
}

return formatters_by_ft
