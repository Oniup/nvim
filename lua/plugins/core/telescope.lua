local ui = require("core.ui")
local icons = require("core.icons")

local smaller_with_no_preview = {
    previewer = false,
    layout_strategy = "center",
    layout_config = {
        prompt_position = "top",
        anchor = "N",
        width = 0.40,
        height = 0.50,
    },
}

return {
    "nvim-telescope/telescope.nvim",
    dependencies = {
        "burntsushi/ripgrep",
        "nvim-tree/nvim-web-devicons",
        "nvim-lua/plenary.nvim",
        "nvim-lua/popup.nvim",
    },
    cmd = { "Telescope" },
    config = function()
        local actions = require("telescope.actions")
        require("telescope").setup({
            defaults = {
                initial_mode = "insert",
                selection_strategy = "reset",
                prompt_prefix = " " .. icons.noice.cmdline.search .. "  ",
                selection_caret = "  ",
                entry_prefix = "  ",
                border = ui.border.style ~= "none",
                borderchars = ui.border.telescope[ui.border.style],
                sorting_strategy = "ascending",
                preview = true,
                preview_cutoff = 1, -- Preview should always show (unless previewer = false)
                layout_strategy = "horizontal",
                layout_config = {
                    prompt_position = "top",
                    anchor = "N",
                    width = 0.80,
                    height = 0.50,
                },
                file_ignore_patterns = {
                    "bin",
                    "build",
                    "vender",
                    "deps",
                    "dependencies",
                    "thirdparty",
                    "third_party",
                    "tests",
                },
                path_display = { "truncate" },
                mappings = {
                    i = {
                        ["<C-l>"] = actions.select_vertical,
                        ["<C-j>"] = actions.select_horizontal,
                    },
                    n = {
                        ["q"] = actions.close,
                        ["<C-l>"] = actions.select_vertical,
                        ["<C-j>"] = actions.select_horizontal,
                    },
                },
            },
            pickers = {
                builtin = smaller_with_no_preview,
            },
        })
    end,
}
