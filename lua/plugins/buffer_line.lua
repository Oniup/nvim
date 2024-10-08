local icons = require("icons")

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
      button = icons.barbar.close,
      separator = icons.barbar.separator,
      separator_at_end = false,
      modified = {
        button = icons.barbar.modified,
      },
      filename = true,
      diagnostics = {
        [vim.diagnostic.severity.ERROR] = {
          enabled = false,
          icon = icons.diagnostics.error,
        },
        [vim.diagnostic.severity.WARN] = {
          enabled = false,
          icon = icons.diagnostics.warn,
        },
        [vim.diagnostic.severity.INFO] = {
          enabled = false,
          icon = icons.diagnostics.info,
        },
        [vim.diagnostic.severity.HINT] = {
          enabled = false,
          icon = icons.diagnostics.int,
        },
      },
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
    -- sidebar_filetypes = {
    --   NvimTree = true,
    -- },
    no_name_title = "[Empty]",
  },
}
