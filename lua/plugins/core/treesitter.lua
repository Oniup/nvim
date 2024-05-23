return {
    "nvim-treesitter/nvim-treesitter",
    name = "treesitter",
    main = "nvim-treesitter.configs",
    build = ":TSUpdate",
    lazy = false,
    opts = {
        ensure_installed = {
            "markdown",
            "markdown_inline",
        },
        auto_install = true,
        sync_install = true,
        highlight = {
            enable = true,
            use_languagetree = true,
            additional_vim_regex_highlighting = { "markdown" },
        },
        indent = {
            enable = true,
        },
    },
}
