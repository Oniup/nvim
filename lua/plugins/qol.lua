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
      scope = {
        show_start = false,
        show_end = false,
      },
    },
  },
}
