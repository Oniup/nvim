local ui = require("core.ui")

return {
    {
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
    },
    -- {
    --     "lewis6991/hover.nvim",
    --     name = "hover",
    --     opts = {
    --         init = function()
    --             require("hover.providers.lsp")
    --             require("hover.providers.dap")
    --             require("hover.providers.gh") -- Github: Issues and PR's
    --             require("hover.providers.gh_user") -- Github: Users
    --             require("hover.providers.dictionary")
    --             -- require('hover.providers.jira')
    --         end,
    --         preview_opts = {
    --             border = ui.border.style,
    --         },
    --         preview_window = false,
    --         title = true,
    --         mouse_providers = {
    --             "LSP",
    --         },
    --         mouse_delay = 500,
    --     },
    -- },
}
