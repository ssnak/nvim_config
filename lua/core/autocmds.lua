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
vim.api.nvim_create_autocmd("FileType", {
    pattern = "markdown",
    callback = function()
        vim.opt_local.conceallevel = 1
    end,
})

-- TODO: Move this to the config of the nvim-jdtls plugin and lazy load on java filetype
-- furthermore implement neoconf settings, migrate to version 0.11 with vim.lsp.config
vim.api.nvim_create_autocmd("FileType", {
    pattern = "java",
    group = vim.api.nvim_create_augroup("java-lsp", {}),
    callback = function()
        local config = {
            cmd = {
                "C:/Users/sergr/scoop/apps/openjdk21/current/bin/java.exe",

                "-Declipse.application=org.eclipse.jdt.ls.core.id1",
                "-Dosgi.bundles.defaultStartLevel=4",
                "-Declipse.product=org.eclipse.jdt.ls.core.product",
                "-Dlog.protocol=true",
                "-Dlog.level=ALL",
                "-Xmx1g",
                "--add-modules=ALL-SYSTEM",
                "--add-opens",
                "java.base/java.util=ALL-UNNAMED",
                "--add-opens",
                "java.base/java.lang=ALL-UNNAMED",

                "-jar",
                "C:/Users/sergr/scoop/apps/jdtls/current/plugins/org.eclipse.equinox.launcher_1.7.0.v20250519-0528.jar",

                "-configuration",
                "C:/Users/sergr/scoop/apps/jdtls/current/config_win",

                "-data",
                "C:/Users/sergr/projects/modding/forge/1.8.9",
            },

            root_dir = vim.fs.root(0, { ".git", "mvnw", "gradlew" }),
            capabilities = vim.tbl_deep_extend(
                "force",
                vim.lsp.protocol.make_client_capabilities(),
                require("blink.cmp").get_lsp_capabilities()
            ),
            flags = {
                allow_incremental_sync = true,
            },

            settings = {
                java = {
                    home = "C:/Users/sergr/scoop/apps/openjdk8-redhat/current",
                    eclipse = {
                        downloadSources = true,
                    },
                    maven = {
                        downloadSources = true,
                    },
                    references = {
                        includeDecompiledSources = true,
                    },
                    configuration = {
                        runtimes = {
                            {
                                name = "JavaSE-1.8",
                                path = "C:/Users/sergr/scoop/apps/openjdk8-redhat/current",
                                default = true,
                            },
                            {
                                name = "JavaSE-17",
                                path = "C:/Users/sergr/scoop/apps/openjdk17/current",
                            },
                            {
                                name = "JavaSE-21",
                                path = "C:/Users/sergr/scoop/apps/openjdk21/current",
                            },
                        },
                    },
                    format = {
                        enabled = true,
                        settings = {
                            url = "https://raw.githubusercontent.com/google/styleguide/gh-pages/eclipse-java-google-style.xml",
                            profile = "GoogleStyle",
                        },
                    },
                    referencedLibraries = {
                        include = {
                            "C:/Users/sergr/projects/modding/forge/1.8.9/fpkmod/.gradle/minecraft/forgeSrc-1.8.9-11.15.1.2318-1.8.9-PROJECT(fpkmod).jar",
                        },
                        sources = {
                            {
                                library = "C:/Users/sergr/projects/modding/forge/1.8.9/fpkmod/.gradle/minecraft/forgeSrc-1.8.9-11.15.1.2318-1.8.9-PROJECT(fpkmod).jar",
                                source = "C:/Users/sergr/projects/modding/forge/1.8.9/fpkmod/.gradle/minecraft/forgeSrc-1.8.9-11.15.1.2318-1.8.9-PROJECT(fpkmod)-sources.jar",
                            },
                        },
                    },
                },
            },
            init_options = {
                bundles = {},
            },
        }

        require("jdtls").start_or_attach(config)
    end,
})

return {}
