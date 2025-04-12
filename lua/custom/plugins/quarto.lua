return {
    {
        "quarto-dev/quarto-nvim",
        dependencies = {
            "jmbuhr/otter.nvim",
        },
        opts = {
            lspFeatures = {
                enabled = true,
                chunks = "curly",
            },
            codeRunner = {
                enabled = false,
            },
        },
        keys = function()
            local is_code_chunk = function()
                local current, _ = require("otter.keeper").get_current_language_context()
                if current then
                    return true
                else
                    return false
                end
            end
            --- Insert code chunk of given language
            --- Splits current chunk if already within a chunk
            --- @param lang string
            local insert_code_chunk = function(lang)
                vim.api.nvim_feedkeys(vim.api.nvim_replace_termcodes("<esc>", true, false, true), "n", true)
                local keys
                if is_code_chunk() then
                    keys = [[o```<cr><cr>```{]] .. lang .. [[}<esc>o]]
                else
                    keys = [[o```{]] .. lang .. [[}<cr>```<esc>O]]
                end
                keys = vim.api.nvim_replace_termcodes(keys, true, false, true)
                vim.api.nvim_feedkeys(keys, "n", false)
            end

            local insert_r_chunk = function()
                insert_code_chunk "r"
            end

            local insert_py_chunk = function()
                insert_code_chunk "python"
            end

            local insert_lua_chunk = function()
                insert_code_chunk "lua"
            end

            local insert_julia_chunk = function()
                insert_code_chunk "julia"
            end

            local insert_bash_chunk = function()
                insert_code_chunk "bash"
            end

            local insert_ojs_chunk = function()
                insert_code_chunk "ojs"
            end
            return {
                { "<leader>O", group = "[O]tter & c[o]de", ft = "quarto" },
                { "<leader>Oa", require("otter").activate, desc = "otter [a]ctivate", ft = "quarto" },
                { "<leader>Od", require("otter").activate, desc = "otter [d]eactivate", ft = "quarto" },
                { "<leader>Or", insert_r_chunk, desc = "[r] code chunk", ft = "quarto" },
                { "<leader>Op", insert_py_chunk, desc = "[p]ython code chunk", ft = "quarto" },
                { "<leader>Ol", insert_lua_chunk, desc = "[l]lua code chunk", ft = "quarto" },
                { "<leader>Oj", insert_julia_chunk, desc = "[j]ulia code chunk", ft = "quarto" },
                { "<leader>Ob", insert_bash_chunk, desc = "[b]ash code chunk", ft = "quarto" },
                { "<leader>Oo", insert_ojs_chunk, desc = "[o]bservable js code chunk", ft = "quarto" },
                { "<leader>q", group = "[q]uarto", ft = "quarto" },
                {
                    "<leader>qE",
                    function()
                        require("otter").export(true)
                    end,
                    desc = "[E]xport with overwrite",
                    ft = "quarto",
                },
                { "<leader>qa", ":QuartoActivate<cr>", desc = "[a]ctivate", ft = "quarto" },
                { "<leader>qe", require("otter").export, desc = "[e]xport", ft = "quarto" },
                { "<leader>qh", ":QuartoHelp ", desc = "[h]elp", ft = "quarto" },
                {
                    "<leader>qp",
                    ":lua require'quarto'.quartoPreview()<cr>",
                    desc = "[p]review",
                    ft = "quarto",
                },
                {
                    "<leader>qu",
                    ":lua require'quarto'.quartoUpdatePreview()<cr>",
                    desc = "[u]pdate preview",
                    ft = "quarto",
                },
                {
                    "<leader>qq",
                    ":lua require'quarto'.quartoClosePreview()<cr>",
                    desc = "[q]uiet preview",
                    ft = "quarto",
                },
                { "<leader>v", group = "[v]im" },
                { "<leader>vc", ":Telescope colorscheme<cr>", desc = "[c]olortheme" },
                { "<leader>vl", ":Lazy<cr>", desc = "[l]azy package manager" },
                { "<leader>vm", ":Mason<cr>", desc = "[m]ason software installer" },
            }
        end,
    },

    {
        "GCBallesteros/jupytext.nvim",
        ft = "quarto",
        opts = {
            custom_language_formatting = {
                python = {
                    extension = "qmd",
                    style = "quarto",
                    force_ft = "quarto",
                },
                r = {
                    extension = "qmd",
                    style = "quarto",
                    force_ft = "quarto",
                },
            },
        },
    },
    {
        "jbyuki/nabla.nvim",
        keys = {
            {
                "<leader>qm",
                ':lua require"nabla".toggle_virt()<cr>',
                ft = "quarto",
                desc = "toggle [m]ath equations",
            },
        },
    },
}
