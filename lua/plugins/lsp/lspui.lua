local ui = require("core.ui")

return {
    "stevearc/dressing.nvim",
    name = "dressing",
    dependencies = {
        "nui",
    },
    opts = {
        input = {
            border = ui.border.style,
            select = {
                nui = {
                    position = "50%",
                    size = nil,
                    relative = "editor",
                    border = {
                        style = ui.border.style,
                    },
                    buf_options = {
                        swapfile = false,
                        filetype = "DressingSelect",
                    },
                    win_options = {
                        winblend = 50,
                    },
                    max_width = 80,
                    max_height = 40,
                    min_width = 40,
                    min_height = 10,
                },
            },
        },
        mappings = {
            n = {
                ["q"] = "Close",
            },
        },
    },
}
