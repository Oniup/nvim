return {
    "mfussenegger/nvim-dap",
    name = "dap",
    dependencies = {
        "mason",
        "jay-babu/mason-nvim-dap.nvim",
    },
    cmd = {
        "DapToggleBreakpoint",
    },
    config = function()
        local dap = require("dap")
        local mason_dap = require("mason-nvim-dap")
        dap.set_log_level("ERROR")
        mason_dap.setup({
            handlers = {
                function(dapconfig)
                    mason_dap.default_setup(dapconfig)
                end,
            },
        })
        local icons = require("core.icons").dap
        for k, v in pairs(icons) do
            vim.fn.sign_define(k, v)
        end
    end,
}
