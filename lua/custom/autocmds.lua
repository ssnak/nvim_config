vim.api.nvim_create_autocmd("LspAttach", {
    callback = function(args)
        local client = vim.lsp.get_client_by_id(args.data.client_id)
        if not client then
            return
        end
        if client.supports_method "textDocument/switchSourceHeader" then
            vim.keymap.set("n", "gh", function()
                vim.cmd.ClangdSwitchSourceHeader()
            end, { desc = "Switch to header file" })
        end
    end,
})

vim.api.nvim_create_autocmd({ "BufEnter", "BufWinEnter" }, {
    pattern = { "*.go", "*.mod" },
    callback = function()
        vim.opt.tabstop = 4
        vim.opt.expandtab = false
    end,
})
return {}
