return {
    "lewis6991/satellite.nvim",
    name = "satellite",
    opts = {
        winblend = 50,
        zindex = 40,
        width = 2,
        excluded_filetypes = {
            "prompt",
            "NvimTree",
        },
        handlers = {
            cursor = { enable = false },
            search = { enable = true },
            diagnostic = {
                enable = true,
                signs = { "-", "=", "≡" },
                min_severity = vim.diagnostic.severity.HINT,
            },
            gitsigns = {
                enable = false,
            },
            quickfix = { signs = { "-", "=", "≡" } },
        },
    },
}
