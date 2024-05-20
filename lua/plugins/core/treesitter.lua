return {
    "nvim-treesitter/nvim-treesitter",
    build = ":TSUpdate",
    lazy = false,
    config = function()
        require("nvim-treesitter.configs").setup({
            ensure_installed = {
                "lua",
                "vimdoc",
                "vim",
                "c", "cpp",
                "markdown",
                "markdown_inline",
            },
            auto_install = true,
            sync_install = false,
            highlight = {
                enable = true,
                use_languagetree = true,
                additional_vim_regex_highlighting = { "markdown" },
            },
            indent = {
                enable = true,
            },
        })
    end,
}
