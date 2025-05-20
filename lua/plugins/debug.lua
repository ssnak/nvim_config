-- debug.lua
--
return {
    "mfussenegger/nvim-dap",
    dependencies = {
        -- Creates a beautiful debugger UI
        "rcarriga/nvim-dap-ui",
        -- Required dependency for nvim-dap-ui
        "nvim-neotest/nvim-nio",
        -- Installs the debug adapters for you
        "williamboman/mason.nvim",
        "jay-babu/mason-nvim-dap.nvim",
        -- Add your own debuggers here
        "leoluz/nvim-dap-go",
        "mfussenegger/nvim-dap-python",
    },
    --- @return LazyKeysSpec[]
    keys = function()
        local dap = require "dap"
        local dapui = require "dapui"
        return {
            { "<F1>", dap.step_into, desc = "Debug: Step Into" },
            { "<F2>", dap.step_over, desc = "Debug: Step Over" },
            { "<F3>", dap.step_out, desc = "Debug: Step Out" },
            { "<F5>", dap.continue, desc = "Debug: Start/Continue" },
            { "<F7>", dapui.toggle, desc = "Debug: See last session result" },
            { "<leader>b", dap.toggle_breakpoint, desc = "Debug: Toggle Breakpoint" },
            {
                "<leader>B",
                function()
                    dap.set_breakpoint(vim.fn.input "Breakpoint condition: ")
                end,
                desc = "Debug: Set Breakpoint",
            },
        }
    end,
    config = function()
        local dap = require "dap"
        local dapui = require "dapui"
        local mason = vim.fn.stdpath "data" .. "/mason"
        local bin = mason .. "/bin"
        local packages = mason .. "/packages"

        require("mason-nvim-dap").setup {
            handlers = {
                delve = function()
                    require("dap-go").setup {
                        delve = { path = bin .. "/dlv.cmd", detached = vim.fn.has "win32" == 0, cwd = nil },
                    }
                end,
            },
            automatic_installation = false,
            automatic_setup = true,
            ensure_installed = require "configs.debuggers",
        }

        --- @diagnostic disable-next-line: missing-fields
        dapui.setup {
            icons = { expanded = "▾", collapsed = "▸", current_frame = "*" },
        }

        dap.listeners.after.event_initialized["dapui_config"] = dapui.open
        dap.listeners.before.event_terminated["dapui_config"] = dapui.close
        dap.listeners.before.event_exited["dapui_config"] = dapui.close

        require("dap-python").setup(packages .. "/debugpy/venv/Scripts/python")
    end,
}
