return {
    "nvim-treesitter/nvim-treesitter",
    name = "treesitter",
    build = ":TSUpdate",
    lazy = false,
    config = function()
        require("nvim-treesitter.configs").setup({
            ensure_installed = {
                "markdown",
                "markdown_inline",
            },
            auto_install = true,
            highlight = {
                enable = false,
                use_languagetree = false,
                additional_vim_regex_highlighting = { "markdown" },
            },
            indent = {
                enable = true,
            },
        })
    end,
}
