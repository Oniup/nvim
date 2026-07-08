return {
  {
    "nvim-treesitter/nvim-treesitter",
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
  -- Color schemes
  {
    "Oniup/ignite.nvim",
    lazy = false,
    priority = 1000,
    config = function()
      require("ignite").setup()

      vim.cmd([[
            syntax enable
            colorscheme ignite
        ]])
    end,
  },
}
