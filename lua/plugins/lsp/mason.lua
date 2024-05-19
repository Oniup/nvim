local function update_repository()
    local required_installed_packages = {
        -- Language servers
        "lua-language-server",
        "vim-language-server",
        "json-lsp",
        "clangd",
        -- Formatters
        "stylua",
        "clang-format",
        -- Debug servers
        "codelldb",
    }

    local registry = require("mason-registry")
    registry.update()

    -- Install missing required servers
    local installed_packages = registry.get_installed_package_names()
    for _, client in ipairs(required_installed_packages) do
        if not vim.tbl_contains(installed_packages, client) then
            vim.cmd("MasonInstall " .. client)
            table.insert(installed_packages, client)
        end
    end
end

return {
    "williamboman/mason.nvim",
    name = "mason",
    dependencies = {
        "lspconfig",
        "devicons",
        "williamboman/mason-lspconfig.nvim",
    },
    config = function()
        require("mason").setup({
            icons = require("core.icons").mason,
            border = require("core.ui").border.style,
            width = 0.6,
            height = 0.6,
        })
        require("mason-lspconfig").setup()
        update_repository()
    end,
}
