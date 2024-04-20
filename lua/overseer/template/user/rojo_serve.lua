---@diagnostic disable: missing-fields
---@type overseer.TemplateDefinition
return {
    name = "rojo",
    builder = function()
        return {
            cmd = "rojo serve",
            components = { "unique" },
        }
    end,
    desc = "Serve rojo project",
    condition = {
        filetype = { "luau" },
    },
}
