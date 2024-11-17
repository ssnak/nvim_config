local keymaps = {
    n = {
        { "<Esc>", "<cmd>nohlsearch<CR>" },
        { "[d", vim.diagnostic.goto_prev, { desc = "Go to previous [D]iagnostic message" } },
        { "]d", vim.diagnostic.goto_next, { desc = "Go to next [D]iagnostic message" } },
        { "<leader>e", vim.diagnostic.open_float, { desc = "Show diagnostic [E]rror messages" } },
        { "<leader>q", vim.diagnostic.setloclist, { desc = "Open diagnostic [Q]uickfix list" } },
        { "gs", "<nop>" },
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
