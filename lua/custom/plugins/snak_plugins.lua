local plugins = {
    {
        "snak/runner.nvim",
        enabled = false,
        dependencies = {
            "MunifTanjim/nui.nvim",
        },
        opts = {},
    },
    {
        "snak/key-replay.nvim",
        enabled = false,
        event = "InsertEnter",
        opts = {},
    },
}

return plugins
