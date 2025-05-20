vim.api.nvim_create_autocmd("TextYankPost", {
    desc = "Highlight when yanking (copying) text",
    group = vim.api.nvim_create_augroup("highlight-yank", { clear = true }),
    callback = function()
        vim.highlight.on_yank()
    end,
})

vim.api.nvim_create_autocmd({ "BufEnter", "BufWinEnter" }, {
    pattern = { "*.go", "*.mod" },
    callback = function()
        vim.opt_local.tabstop = 4
        vim.opt_local.expandtab = false
    end,
})
vim.api.nvim_create_autocmd({ "BufEnter", "BufWinEnter" }, {
    pattern = "*.dart",
    callback = function()
        vim.opt_local.shiftwidth = 2
    end,
})
vim.api.nvim_create_autocmd({ "BufEnter", "BufWinEnter" }, {
    pattern = "*.txt",
    callback = function()
        vim.opt_local.spell = true
        vim.opt_local.spelllang = "en_us"
        vim.opt_local.formatoptions:append "a2]pwn"
        vim.opt_local.textwidth = 120
        vim.opt_local.expandtab = false
        vim.opt_local.shiftwidth = 4
        vim.opt_local.tabstop = 4
        vim.api.nvim_set_hl(0, "SpellBad", { underline = true, fg = "#ff0000", ctermfg = "red" }) -- Red squiggles
        vim.api.nvim_set_hl(0, "SpellCap", { underline = true, fg = "#0000ff", ctermfg = "blue" }) -- Blue squiggles
        vim.api.nvim_set_hl(0, "SpellRare", { underline = true, fg = "#ff00ff", ctermfg = "magenta" }) -- Purple squiggles
        vim.api.nvim_set_hl(0, "SpellLocal", { underline = true, fg = "#00ff00", ctermfg = "green" }) -- Green squiggles
    end,
})

return {}
