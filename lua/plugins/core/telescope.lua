local ui = require("core.ui")

return {
    "nvim-telescope/telescope.nvim",
    name = "telescope",
    dependencies = {
        "burntsushi/ripgrep",

        "web-devicons",
        "plenary",
        "popup",
    },
    cmd = { "Telescope" },
    config = function()
        local actions = require("telescope.actions")
        require("telescope").setup({
            defaults = vim.tbl_deep_extend("force", ui.telescope_themes.large_with_preview, {
                sorting_strategy = "ascending",
                border = ui.border.style ~= "none",
                borderchars = ui.border.telescope[ui.border.style],
                initial_mode = "insert",
                selection_strategy = "reset",
                prompt_prefix = " " .. require("core.icons").cmdline.search .. "  ",
                selection_caret = "  ",
                entry_prefix = "  ",
                preview = true,
                preview_cutoff = 1, -- Preview should always show (unless previewer = false)
                file_ignore_patterns = {
                    "bin",
                    "build",
                    "vender",
                    "deps",
                    "dependencies",
                    "thirdparty",
                    "third_party",
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
            }),
            pickers = {
                code_action = ui.telescope_themes.smaller_with_no_preview,
                builtin = ui.telescope_themes.smaller_with_no_preview,
            },
        })
    end,
}
