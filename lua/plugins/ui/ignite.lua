local ui = require("core.ui")
local no_border = ui.border.style == "solid" or ui.boder.style == "none"

return {
    "Oniup/ignite.nvim",
    lazy = false,
    priority = 1000,
    config = function()
        require("ignite").setup({
            style = {
                no_border = no_border,
            },
        })
        vim.cmd([[
            syntax enable
            colorscheme ignite
        ]])
    end,
}
