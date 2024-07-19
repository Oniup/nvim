local ui = require("ui")

return {
  "stevearc/dressing.nvim",
  dependencies = {
    "MunifTanjim/nui.nvim",
  },
  opts = {
    input = {
      border = ui.border.style,
      mappings = {
        n = {
          ["<C-q>"] = "Close",
        },
        i = {
          ["<C-q>"] = "Close",
        },
      },
    },
    select = {
      enabled = true,
      backend = { "fzf_lua", "nui" },
      nui = {
        position = "50%",
        size = nil,
        relative = "editor",
        border = {
          style = ui.border.style,
        },
        buf_options = {
          swapfile = false,
          filetype = "DressingSelect",
        },
        win_options = {
          winblend = 50,
        },
        max_width = 80,
        max_height = 40,
        min_width = 40,
        min_height = 10,
      },
      mappings = {
        n = {
          ["<C-q>"] = "Close",
        },
        i = {
          ["<C-q>"] = "Close",
        },
      },
    },
  },
}
