local function update_repository()
  local required_installed_packages = {
    -- Language servers
    "lua-language-server",
    "vim-language-server",
    -- "cmake-language-server",
    "neocmakelsp",
    "json-lsp",
    "clangd",
    -- Formatters
    "stylua",
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
  "williamboman/mason-lspconfig.nvim",
  dependencies = {
    {
      "williamboman/mason.nvim",
      cmd = { "Mason", "MasonUpdate" },
      dependencies = {
        "neovim/nvim-lspconfig",
        { "nvim-tree/nvim-web-devicons", enabled = vim.g.have_nerd_font },
      },
    },
  },
  config = function()
    require("mason").setup({
      ui = {
        icons = require("icons").mason,
        border = require("ui").border.style,
        width = 0.6,
        height = 0.6,
      },
    })
    require("mason-lspconfig").setup()
    update_repository()
  end,
}
