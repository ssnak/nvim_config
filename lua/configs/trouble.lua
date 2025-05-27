local t = {}
t.keys = {
    {
        "gd",
        "<cmd>Trouble lsp_definitions toggle focus auto_refresh=false follow=true<cr>",
        desc = "[G]oto [D]efinitions",
    },
    {
        "gD",
        "<cmd>Trouble lsp_declarations toggle focus auto_refresh=false follow=true<cr>",
        desc = "[G]oto [D]eclarations",
    },
    {
        "grr",
        "<cmd>Trouble lsp_references toggle focus auto_refresh=false follow=true<cr>",
        desc = "[G]oto [R]eferences",
    },
    {
        "gri",
        "<cmd>Trouble lsp_implementations toggle focus auto_refresh=false follow=true<cr>",
        desc = "[G]oto [I]mplementations",
    },
    {
        "grt",
        "<cmd>Trouble lsp_type_definitions toggle focus auto_refresh=false follow=true<cr>",
        desc = "[G]oto [T]ype Definitions",
    },
    {
        "<leader>ts",
        "<cmd>Trouble symbols toggle focus<cr>",
        desc = "Symbols (Trouble)",
    },
    {
        "<leader>tS",
        "<cmd>Trouble lsp_document_symbols toggle focus win.type=float<cr>",
        desc = "Symbols Full (Trouble)",
    },
    {
        "<leader>td",
        "<cmd>Trouble diagnostics toggle focus<cr>",
        desc = "Diagnostics (Trouble)",
    },
    {
        "<leader>tD",
        "<cmd>Trouble diagnostics toggle filter.buf=0<cr> focus",
        desc = "Buffer Diagnostics (Trouble)",
    },
    {
        "<leader>tL",
        "<cmd>Trouble lsp toggle focus=false win.position=right<cr>",
        desc = "LSP Definitions / references / ... (Trouble)",
    },
    {
        "<leader>tl",
        "<cmd>Trouble loclist toggle focus<cr>",
        desc = "Location List (Trouble)",
    },
    {
        "<leader>tq",
        "<cmd>Trouble qflist toggle focus<cr>",
        desc = "Quickfix List (Trouble)",
    },
    {
        "<leader>tt",
        "<cmd>Trouble todo toggle focus<cr>",
        desc = "Todo List (Trouble)",
    },
}

return t
