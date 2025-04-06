local formatters_by_ft = {
    lua = { "stylua" },
    go = { "gofumpt" },
    python = { "black" },
    ocaml = { "ocamlformat" },
    cpp = { "clang-format" },
    java = { "clang-format" },
    cmake = { "cmake_format" },
    html = { "prettier" },
    javascript = { "prettier" },
    typescript = { "prettier" },
}

return formatters_by_ft
