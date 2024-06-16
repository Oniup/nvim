local icons = require("core.icons")

return {
    "folke/which-key.nvim",
    event = "VeryLazy",
    init = function()
        vim.o.timeout = true
        vim.o.timeoutlen = 300
    end,
    config = function()
        local wk = require("which-key")
        wk.setup({
            icons = {
                breadcrumb = icons.nvim_tree_glyphs.git.staged,
                separator = icons.arrow.right,
                group = icons.dapui.expanding_controls.current_frame,
            },
            window = {
                border = require("core.ui").border.style,
            },
        })
        wk.register({
            ["<leader>"] = {
                d = { name = "Debug" },
                f = { name = "Find" },
                g = { name = "Git" },
                h = { name = "Help" },
                t = { name = "Terminal" },
                r = { name = "Rename"}
            },
        })
    end,
}
