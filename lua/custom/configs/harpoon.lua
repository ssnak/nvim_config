return function()
    local harpoon = require "harpoon"
    harpoon:setup()

    local function nmap(lhs, rhs, opts)
        opts = opts or {}
        vim.keymap.set("n", lhs, rhs, opts)
    end
    nmap("<leader>aa", function()
        harpoon:list():add()
    end, { desc = "Harpoon [A]dd" })
    nmap("<leader>aj", function()
        harpoon:list():select(1)
    end, { desc = "Harpoon Select 1" })
    nmap("<leader>ak", function()
        harpoon:list():select(2)
    end, { desc = "Harpoon Select 2" })
    nmap("<leader>al", function()
        harpoon:list():select(3)
    end, { desc = "Harpoon Select 3" })
    nmap("<leader>a;", function()
        harpoon:list():select(4)
    end, { desc = "Harpoon Select 4" })
    nmap("<leader>ah", function()
        harpoon.ui:toggle_quick_menu(harpoon:list())
    end, { desc = "Harpoon menu" })
end
