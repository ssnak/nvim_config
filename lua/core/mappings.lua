local keymaps = {
    n = {
        { "<Esc>", "<cmd>nohlsearch<CR>" },
        { "[d", vim.diagnostic.goto_prev, { desc = "Go to previous [D]iagnostic message" } },
        { "]d", vim.diagnostic.goto_next, { desc = "Go to next [D]iagnostic message" } },
        { "gs", "<nop>" },
        { "<c-h>", "<c-w>h", { desc = "Move to left window" } },
        { "<c-j>", "<c-w>j", { desc = "Move to bottom window" } },
        { "<c-k>", "<c-w>k", { desc = "Move to top window" } },
        { "<c-l>", "<c-w>l", { desc = "Move to right window" } },
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
