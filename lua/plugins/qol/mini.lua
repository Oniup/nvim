local icons = require("core.icons")

return {
    {
        "echasnovski/mini.indentscope",
        config = function()
            local indentscope = require("mini.indentscope")
            require("mini.indentscope").setup({
                draw = {
                    delay = 0,
                    animation = indentscope.gen_animation.none(),
                },
                symbol = icons.seporators.vertical,
            })
        end,
    },
}
