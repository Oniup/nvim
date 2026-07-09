local sections = {
  mode = {
    "mode",
  },
  diff = {
    "diff",
    colored = true,
  },
  branch = "branch",
  location = {
    "location",
    fmt = function(output)
      if output then
        local pos = vim.api.nvim_win_get_cursor(0)
        local line_count = vim.api.nvim_buf_line_count(vim.api.nvim_get_current_buf())
        output = pos[2] .. ":" .. pos[1] .. "/" .. line_count
      end
      return output
    end,
  },
  filetype = {
    "filetype",
    colored = true,
    icon_only = true,
  },
  filetype_no_color = {
    "filetype",
    colored = false,
    icon_only = true,
  },
  diagnostics = {
    "diagnostics",
    diagnostics_color = {
      diagnostics_color = {
        error = "DiagnosticError",
        warn = "DiagnosticWarn",
        info = "DiagnosticInfo",
        hint = "DiagnosticHint",
      },
      colored = true,
      update_in_insert = true,
      always_visable = true,
    },
  },
  searchcount = {
    "searchcount",
    maxcount = 999,
    timeout = 500,
  },
}
return {
  "nvim-lualine/lualine.nvim",
  dependencies = {
    { "nvim-tree/nvim-web-devicons", enabled = vim.g.have_nerd_font },
  },
  opts = {
    options = {
      -- theme = require("ignite.lualine_theme"),
      component_separators = { right = "", left = "" },
      section_separators = { right = "", left = "" },
    },
    sections = {
      lualine_a = { sections.mode },
      lualine_b = { sections.branch },
      lualine_c = { sections.diff },
      lualine_x = {
        sections.diagnostics,
      },
      lualine_y = { sections.filetype, sections.filename },
      lualine_z = { sections.location },
    },
    inactive_sections = {
      lualine_c = { sections.diff },
      lualine_x = { sections.diagnostics },
      lualine_y = {
        sections.filetype_no_color,
        sections.filename,
        sections.location,
      },
    },
    extensions = {
      "lazy",
      "mason",
      "nvim-dap-ui",
      "nvim-tree",
      "quickfix",
      "toggleterm",
    },
  },
}
