local icons = require("icons")

return {
    "mfussenegger/nvim-dap",
    dependencies = {
        "williamboman/mason.nvim",
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
        for k, v in pairs(icons.dap) do
            vim.fn.sign_define(k, v)
        end
    end,
}
