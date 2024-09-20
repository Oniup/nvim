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
  -- Color schemes
  {
    -- Default color scheme
    "Oniup/ignite.nvim",
    -- There is no dependencies this is just all the color schemes
    dependencies = {
      "neanias/everforest-nvim",
    },
    lazy = false,
    priority = 1000,
    config = function()
      require("ignite").setup({
        style = {
          no_border = ui.border.style,
        },
      })

      require("everforest").setup()

      vim.cmd([[
            syntax enable
            colorscheme ignite
        ]])
    end,
  },
}
