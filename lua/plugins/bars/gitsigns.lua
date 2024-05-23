local ui = require("core.ui")

return {
    "lewis6991/gitsigns.nvim",
    name = "gitsigns",
    opts = {
        signs = require("core.icons").gitsigns,
        preview_config = {
            border = ui.border.style,
            style = "minimal",
            relative = "cursor",
        },
    },
}
