local formatters_by_ft = {
    lua = { "stylua" },
    cpp = { "clang-format" },
    -- configure cmakelang formatter
    cmake = { "cmakelang" },
}

return formatters_by_ft
