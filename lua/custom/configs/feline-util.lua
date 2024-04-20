local t = {
    components = {},
}

function t.addMargin(str)
    return " " .. str .. " "
end

local function get_vim_mode()
    local modes = {
        n = "normal",
        no = "op",
        nov = "op_v",
        noV = "op_V",
        ["noCTRL-V"] = "op_b",
        niI = "normal",
        niR = "normal",
        niV = "normal",
        nt = "normal",
        ntT = "normal",
        v = "visual",
        vs = "visual",
        V = "v-line",
        Vs = "v-line",
        ["CTRL-V"] = "v-block",
        ["CTRL-Vs"] = "v-block",
        s = "select",
        S = "select",
        ["CTRL-S"] = "select",
        i = "insert",
        ic = "insert",
        ix = "insert",
        R = "replace",
        Rc = "replace",
        Rx = "replace",
        Rv = "replace",
        Rvc = "replace",
        Rvx = "replace",
        c = "command",
        cv = "unk",
        r = "unk",
        rm = "unk",
        ["r?"] = "unk",
        ["!"] = "shell",
        t = "term",
    }

    return t.addMargin(modes[vim.fn.mode()])
end

t.components.vim_mode_component = {
    provider = get_vim_mode,
    hl = function()
        local vi_mode = require "feline.providers.vi_mode"
        return {
            name = vi_mode.get_mode_highlight_name(),
            bg = vi_mode.get_mode_color(),
            style = "bold",
        }
    end,
}

return t
