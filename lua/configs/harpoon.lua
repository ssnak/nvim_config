local t = {}
t.keymaps = {
    {
        "<leader>aa",
        function(harpoon)
            harpoon:list():add()
        end,
        { desc = "Harpoon [A]dd" },
    },
    {
        "<leader>aj",
        function(harpoon)
            harpoon:list():select(1)
        end,
        { desc = "Harpoon Select 1" },
    },
    {
        "<leader>ak",
        function(harpoon)
            harpoon:list():select(2)
        end,
        { desc = "Harpoon Select 2" },
    },
    {
        "<leader>al",
        function(harpoon)
            harpoon:list():select(3)
        end,
        { desc = "Harpoon Select 3" },
    },
    {
        "<leader>a;",
        function(harpoon)
            harpoon:list():select(4)
        end,
        { desc = "Harpoon Select 4" },
    },
    {
        "<leader>ah",
        function(harpoon)
            harpoon.ui:toggle_quick_menu(harpoon:list())
        end,
        { desc = "Harpoon menu" },
    },
}
function t.setup()
    local harpoon = require "harpoon"
    harpoon:setup()
    for _, v in pairs(t.keymaps) do
        vim.keymap.set("n", v[1], function()
            v[2](harpoon)
        end, v[3])
    end
end

t.keys = {}
for _, v in pairs(t.keymaps) do
    table.insert(t.keys, { v[1], desc = v[3].desc })
end

return t
