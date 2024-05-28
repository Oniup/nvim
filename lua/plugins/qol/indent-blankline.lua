local icons = require("core.icons")

return {
    "lukas-reineke/indent-blankline.nvim",
    name = "indent-blankline",
    main = "ibl",
    opts = {
        indent = { char = icons.seporators.vertical.thin },
        scope = {
            show_start = false,
            show_end = false,
        },
    },
}
