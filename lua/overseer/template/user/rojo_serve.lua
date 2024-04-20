return {
    name = "Rojo Serve",
    builder = function()
        return {
            cmd = { "rojo" },
            args = { "serve" },
        }
    end,
    condition = {
        filetype = { "luau" },
    },
}
