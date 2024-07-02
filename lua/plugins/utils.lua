local icons = require("icons")

return {
    { "numToStr/Comment.nvim", config = true },
    {
        "akinsho/toggleterm.nvim",
        cmd = "ToggleTerm",
        opts = {
            size = function(term)
                if term.direction == "horizontal" then
                    return 40
                elseif term.direction == "vertical" then
                    return vim.o.columns * 0.4
                end
            end,
            shade_terminals = false,
            direction = "horizontal",
            autochdir = true,
            persist_mode = false,
            hide_numbers = false,
        },
    },
    {
        "windwp/nvim-autopairs",
        event = { "InsertEnter" },
        config = true,
    },
    {
        "lukas-reineke/indent-blankline.nvim",
        main = "ibl",
        opts = {
            indent = { char = icons.seporators.vertical.thin },
            scope = {
                show_start = false,
                show_end = false,
            },
        },
    },
    {
        "iamcco/markdown-preview.nvim",
        cmd = { "MarkdownPreviewToggle", "MarkdownPreview", "MarkdownPreviewStop" },
        ft = { "markdown" },
        build = function()
            vim.fn["mkdp#util#install"]()
        end,
        init = function()
            vim.g.mkdp_filetypes = { "markdown" }
        end,
    },
}
