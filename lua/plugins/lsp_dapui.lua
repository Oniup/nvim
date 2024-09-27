local icons = require("icons")
local ui = require("ui")

local function load_extensions()
  require("cmp").setup.filetype({ "dap-repl", "dapui_watches", "dapui_hover" }, {
    sources = {
      { name = "dap" },
    },
  })
end

local function set_dapui_listeners()
  local dap = require("dap")
  local dapui = require("dapui")
  dap.listeners.before.attach.dapui_config = dapui.open
  dap.listeners.before.launch.dapui_config = dapui.open
  dap.listeners.before.event_terminated.dapui_config = dapui.close
  dap.listeners.before.event_exited.dapui_config = nil
end

return {
  "rcarriga/nvim-dap-ui",
  dependencies = {
    "mfussenegger/nvim-dap",
    "nvim-neotest/nvim-nio",
    "rcarriga/cmp-dap",
  },
  lazy = true,
  config = function()
    require("dapui").setup({
      layouts = ui.dapui.layouts,
      icons = icons.dapui.expanding_controls,
      controls = ui.dapui.controls,
      floating = {
        border = ui.border.style,
        mappings = {
          close = { "q", "<Esc>" },
        },
      },
    })
    set_dapui_listeners()
    load_extensions()
  end,
}
