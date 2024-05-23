return {
    {
        "nvim-tree/nvim-web-devicons",
        name = "web-devicons",
        config = function()
            require("nvim-web-devicons").setup()
        end,
    },
    { "nvim-lua/popup.nvim", name = "popup" },
    { "nvim-lua/plenary.nvim", name = "plenary" },
    { "MunifTanjim/nui.nvim", name = "nui" },
    { "nvim-neotest/nvim-nio", name = "nio" },
}
