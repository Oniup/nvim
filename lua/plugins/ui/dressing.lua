return {
    "stevearc/dressing.nvim",
    name = "dressing",
    opts = {
        input = {
            border = require("core.ui").border.style,
        },
        mappings = {
            n = {
                ["q"] = "Close",
            },
        },
    },
}
