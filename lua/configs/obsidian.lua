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
            nvim_cmp = false, -- Setting completion manually during setup with blink.compat
        },
    },
    cmd = {
        "ObsidianBacklinks",
        "ObsidianCheck",
        "ObsidianDailies",
        "ObsidianDebug",
        "ObsidianExtractNote",
        "ObsidianFollowLink",
        "ObsidianLink",
        "ObsidianLinkNew",
        "ObsidianLinks",
        "ObsidianNew",
        "ObsidianNewFromTemplate",
        "ObsidianOpen",
        "ObsidianPasteImg",
        "ObsidianQuickSwitch",
        "ObsidianRename",
        "ObsidianSearch",
        "ObsidianTOC",
        "ObsidianTags",
        "ObsidianTemplate",
        "ObsidianToday",
        "ObsidianToggleCheckbox",
        "ObsidianTomorrow",
        "ObsidianWorkspace",
        "ObsidianYesterday",
    },
}

return t
