local keymaps = {
    n = {
        { "<Esc>", "<cmd>nohlsearch<CR>" },
        { "[d", vim.diagnostic.goto_prev, { desc = "Go to previous [D]iagnostic message" } },
        { "]d", vim.diagnostic.goto_next, { desc = "Go to next [D]iagnostic message" } },
        { "<leader>e", vim.diagnostic.open_float, { desc = "Show diagnostic [E]rror messages" } },
        { "<leader>q", vim.diagnostic.setloclist, { desc = "Open diagnostic [Q]uickfix list" } },
        { "gs", "<nop>" },
        { "<C-h>", "<C-w><C-h>", { desc = "Move focus to the left window" } },
        { "<C-l>", "<C-w><C-l>", { desc = "Move focus to the right window" } },
        { "<C-j>", "<C-w><C-j>", { desc = "Move focus to the lower window" } },
        { "<C-k>", "<C-w><C-k>", { desc = "Move focus to the upper window" } },
        { "<leader>vl", "<cmd>Lazy<cr>", { desc = "Lazy" } },
        { "<leader>vm", "<cmd>Mason<cr>", { desc = "Mason" } },
        { "<leader>vti", "<cmd>MasonToolsInstall<cr>", { desc = "Mason Tools [I]nstall" } },
        { "<leader>vtu", "<cmd>MasonToolsUpdate<cr>", { desc = "Mason Tools [U]pdate" } },
    },

    i = {
        { "C-c", "<Esc>" },
    },

    t = {
        { "<Esc><Esc>", "<C-\\><C-n>", { desc = "Exit terminal mode" } },
    },
}

for mode, v in pairs(keymaps) do
    for _, keymap in pairs(v) do
        vim.keymap.set(mode, keymap[1], keymap[2], keymap[3])
    end
end

return {}
