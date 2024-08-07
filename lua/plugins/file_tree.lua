local ui = require("ui")
local icons = require("icons")

return {
  "nvim-tree/nvim-tree.lua",
  cmd = { "NvimTreeToggle", "NvimTreeFocus" },
  opts = {
    sync_root_with_cwd = true,
    respect_buf_cwd = true,
    hijack_cursor = true,
    hijack_unnamed_buffer_when_opening = true,
    update_focused_file = {
      enable = true,
      update_root = false,
    },
    actions = {
      file_popup = {
        open_win_config = {
          border = ui.border.type,
        },
      },
    },
    renderer = {
      root_folder_label = false,
      indent_width = 1,
      icons = {
        glyphs = icons.nvim_tree_glyphs,
      },
    },
    diagnostics = {
      enable = false,
      icons = {
        error = icons.diagnostics.error,
        warning = icons.diagnostics.warn,
        info = icons.diagnostics.info,
        hint = icons.diagnostics.hint,
      },
    },
  },
}
