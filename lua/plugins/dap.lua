return {
  "mfussenegger/nvim-dap",
  dependencies = {
    "rcarriga/nvim-dap-ui",
    "nvim-neotest/nvim-nio",

    "williamboman/mason.nvim",
    "jay-babu/mason-nvim-dap.nvim",
  },
  cmd = { "DapContinue", "DapToggleBreakpoint", "DapClearBreakPoints", },
  config = function()
    local dap = require("dap")
    local dapui = require("dapui")

    require("mason-nvim-dap").setup({
      automatic_installation = true,
      ensure_installed = {
        -- "codelldb",
      },
      handlers = {
        -- Keep default setup for everything else
        function(config)
          require('mason-nvim-dap').default_setup(config)
        end,

        -- Override codelldb to avoid internal terminal panics
        codelldb = function(config)
          config.configurations = {
            {
              name = "Launch C++",
              type = "codelldb",
              request = "launch",
              program = function()
                return vim.fn.input("Path to executable: ", vim.fn.getcwd() .. "/", "file")
              end,
              cwd = "${workspaceFolder}",
              stopOnEntry = false,
              runInTerminal = false, -- Must have enabled for windows
            },
          }
          require('mason-nvim-dap').default_setup(config)
        end,
      },
    })

    dapui.setup()
    dap.listeners.after.event_initialized["dapui_config"] = function()
      dapui.open()
    end

    require("config.keymaps").dap()
    vim.fn.sign_define("DapBreakpoint", { text = "", texthl = "Error", linehl = "", numhl = "" })
    vim.fn.sign_define(
      "DapStopped",
      { text = "▶️", texthl = "Operator", linehl = "CursorLine", numhl = "CursorLine" }
    )
  end,
}
