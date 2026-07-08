return {
  "romgrk/barbar.nvim",
  dependencies = {
    { "nvim-tree/nvim-web-devicons", enabled = vim.g.have_nerd_font },
  },
  opts = {
    animation = false,
    autohide = false,
    tabpages = true,
    clickable = true,
    icons = {
      buffer_index = false,
      buffer_number = false,
      separator_at_end = false,
      filename = true,
      gitsigns = {
        added = { enabled = false },
        changed = { enabled = false },
        deleted = { enabled = false },
      },
      filetype = {
        enabled = false,
      },
    },
    -- Disabled due to a bug in neovide cutting and not rending next that passes
    -- a certain length:
    sidebar_filetypes = {
      NvimTree = true,
    },
    no_name_title = "[Empty]",
  },
}
