return {
  "nvim-telescope/telescope.nvim",
  version = "*",
  dependencies = {
    "nvim-lua/plenary.nvim",
  },
  config = function()
    local telescope = require("telescope")
    local actions = require("telescope.actions")
    local ui = require("config.ui")

    telescope.setup({
      defaults = vim.tbl_deep_extend("force", ui.telescope_themes.large_with_preview, {
        sorting_strategy = "ascending",
        border = ui.border.style ~= "none",
        borderchars = ui.border.chars[ui.border.style],
        initial_mode = "insert",
        selection_strategy = "reset",
        -- prompt_prefix = " " .. icons.cmdline.search .. "  ",
        selection_caret = "  ",
        entry_prefix = "  ",
        preview = true,
        preview_cutoff = 1, -- Preview should always show (unless previewer = false)
        file_ignore_patterns = {
          "bin",
          "build",
          "vender",
          "deps",
          "dependencies",
          "thirdparty",
          "third_party",
          ".cache",
          ".git",
        },
        path_display = { "truncate" },
        mappings = {
          i = {
            ["<C-q>"] = actions.close,
            ["<C-l>"] = actions.select_vertical,
            ["<C-j>"] = actions.select_horizontal,
          },
          n = {
            ["<C-q>"] = actions.close,
            ["<C-l>"] = actions.select_vertical,
            ["<C-j>"] = actions.select_horizontal,
          },
        },
      }),
      pickers = {
        code_action = ui.telescope_themes.smaller_with_no_preview,
        builtin = ui.telescope_themes.smaller_with_no_preview,
      },
    })
  end,
}
