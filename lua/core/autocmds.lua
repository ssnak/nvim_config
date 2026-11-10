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
        local root_dir = vim.fs.root(0, { ".git", "mvnw", "gradlew" })
        if not root_dir then
            return
        end
        local java_bin = "C:/Users/sergr/scoop/apps/openjdk21/current/bin/java.exe"
        local launcher_jar =
            "C:/Users/sergr/scoop/apps/jdtls/current/plugins/org.eclipse.equinox.launcher_1.7.0.v20250519-0528.jar"
        local configuration_file = "C:/Users/sergr/scoop/apps/jdtls/current/config_win"
        local workspaces = vim.fn.expand "~/jdtls_workspaces/"
        local default_home = "C:/Users/sergr/scoop/apps/openjdk8-redhat/current"
        local java_runtimes = {
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
        }
        if vim.uv.os_uname().sysname == "Linux" then
            java_bin = "/home/snak/.sdkman/candidates/java/21.0.8-tem/bin/java"
            launcher_jar =
                "/usr/share/java/jdtls/plugins/org.eclipse.equinox.launcher_1.7.100.v20251111-0406.jar"
            configuration_file = "/usr/share/java/jdtls/config_linux"
            workspaces = vim.fn.expand "~/.jdtls_workspaces/"
            -- default_home = "/home/snak/.sdkman/candidates/java/8.0.462-tem"
            default_home = "/home/snak/.sdkman/candidates/java/25.0.4-tem"
            java_runtimes[2] = java_runtimes[3]
            java_runtimes[3] = nil
            java_runtimes[1].path = "/home/snak/.sdkman/candidates/java/8.0.462-tem"
            java_runtimes[1].default = false
            java_runtimes[2].path = "/home/snak/.sdkman/candidates/java/21.0.8-tem"
            java_runtimes[3] = {
                name = "JavaSE-25",
                path = "/home/snak/.sdkman/candidates/java/25.0.4-tem",
                default = true,
            }
        end
        local config = {
            cmd = {
                java_bin,
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
                launcher_jar,

                "-configuration",
                configuration_file,

                "-data",
                workspaces .. vim.fn.fnamemodify(root_dir, ":p:h:t"),
            },

            root_dir = root_dir,
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
                    home = default_home,
                    eclipse = {
                        downloadSources = true,
                    },
                    maven = {
                        downloadSources = true,
                    },
                    references = {
                        includeDecompiledSources = true,
                    },
                    contentProvider = {
                        preferred = "fernflower",
                    },
                    configuration = {
                        updateBuildConfiguration = "interactive", -- disabled | interactive | automatic
                        runtimes = java_runtimes,
                    },
                    format = {
                        enabled = false,
                        settings = {
                            url = "https://raw.githubusercontent.com/google/styleguide/gh-pages/eclipse-java-google-style.xml",
                            profile = "GoogleStyle",
                        },
                    },
                },
            },
            init_options = {
                bundles = {},
            },
        }

        -- local mc = vim.fs.joinpath(root_dir, ".gradle/minecraft")
        -- local source = vim.fs.joinpath(mc, "source")
        -- local lib = vim.fs.find(function(name, _)
        --     return name:match "^forgeSrc-[%d%.%-]+%.jar$" ~= nil
        -- end, { path = mc })[1]
        -- config.settings.java.project = {
        --     referencedLibraries = { "lib" },
        -- sourcePaths = {
        --     "src/main/java",
        --     "src/main/resources",
        --     "/home/snak/Desktop/Mods/CyvForge/.gradle/minecraft/source",
        -- },
        --     referencedLibraries = {
        --         include = { lib },
        --         sources = {
        --             { library = lib, source = source },
        --         },
        --     },
        -- referencedLibraries = {
        --     include = {
        --         "/home/snak/.gradle/caches/minecraft/net/minecraftforge/forge/1.8.9-11.15.1.2318-1.8.9/stable/22/forgeBin-1.8.9-11.15.1.2318-1.8.9.jar",
        --     },
        --     sources = {
        --         {
        --             library = "/home/snak/.gradle/caches/minecraft/net/minecraftforge/forge/1.8.9-11.15.1.2318-1.8.9/stable/22/forgeBin-1.8.9-11.15.1.2318-1.8.9.jar",
        --             source = "/home/snak/Desktop/Mods/CyvForge/.gradle/minecraft/source/",
        --         },
        --     },
        -- },
        -- }

        require("jdtls").start_or_attach(config)
    end,
})

return {}
