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
    renderer = {
      root_folder_label = false,
      indent_width = 1,
      icons = {
        glyphs = {
          default = "󰈙",
          symlink = "",
          bookmark = "",
          folder = { -- nf-md-folder
            arrow_closed = "",
            arrow_open = "",
            default = "󰉋",
            open = "󰝰",
            empty = "󰉖",
            empty_open = "󰷏",
            symlink = "󰉕",
            symlink_open = "󰉕",
          },
          git = {
            unstaged = "",
            staged = "",
            unmerged = "󰘭",
            renamed = "",
            untracked = "",
            deleted = "󰧧",
            ignored = "",
          },
        },
      },
    },
  },
}
