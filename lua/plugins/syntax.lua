local ui = require("ui")

return {
  {
    "nvim-treesitter/nvim-treesitter",
    main = "nvim-treesitter.configs",
    build = ":TSUpdate",
    lazy = false,
    opts = {
      ensure_installed = {
        "markdown",
        "markdown_inline",
      },
      highlight = {
        enable = true,
        use_languagetree = true,
        additional_vim_regex_highlighting = { "markdown" },
      },
      indent = {
        enable = false,
      },
    },
  },
  {
    "Oniup/ignite.nvim",
    lazy = false,
    priority = 1000,
    config = function()
      require("ignite").setup({
        style = {
          no_border = ui.border.style,
        },
      })
      vim.cmd([[
            syntax enable
            colorscheme ignite
        ]])
    end,
  },
}
