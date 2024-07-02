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
    "mfussenegger/nvim-dap",
    dependencies = {
        "williamboman/mason.nvim",
        "jay-babu/mason-nvim-dap.nvim",

        "rcarriga/nvim-dap-ui",
        "nvim-neotest/nvim-nio",
        "rcarriga/cmp-dap",
    },
    cmd = {
        "DapToggleBreakpoint",
    },
    config = function()
        local dap = require("dap")
        local mason_dap = require("mason-nvim-dap")

        -- Setup dap
        dap.set_log_level("ERROR")
        mason_dap.setup({
            handlers = {
                function(dapconfig)
                    mason_dap.default_setup(dapconfig)
                end,
            },
        })
        for k, v in pairs(icons) do
            vim.fn.sign_define(k, v)
        end

        -- Setup dapui
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
