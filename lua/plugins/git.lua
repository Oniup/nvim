local ui = require("ui")
local icons = require("icons")

return {
    "lewis6991/gitsigns.nvim",
    opts = {
        signs = icons.gitsigns,
        preview_config = {
            border = ui.border.style,
            style = "minimal",
            relative = "cursor",
        },
    },
}
