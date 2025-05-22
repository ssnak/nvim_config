local t = {
    keys = {
        {
            "<leader>nn",
            vim.cmd.ObsidianNew,
            desc = "New Note",
        },
        {
            "<leader>ns",
            vim.cmd.ObsidianSearch,
            desc = "Search Note",
        },
        {
            "<leader>nr",
            vim.cmd.ObsidianRename,
            desc = "Rename Note",
        },
        {
            "<leader>nt",
            vim.cmd.ObsidianTags,
            desc = "Search Notes By Tag",
        },
    },
    opts = {
        workspaces = {
            {
                name = "personal",
                path = "~/vaults/personal",
            },
        },
        completion = {
            nvim_cmp = true,
        },
    },
}

return t
