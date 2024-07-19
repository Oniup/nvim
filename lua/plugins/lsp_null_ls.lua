return {
  "nvimtools/none-ls.nvim",
  dependencies = {
    "neovim/nvim-lspconfig",
    "williamboman/mason-lspconfig.nvim",
    "nvim-lua/plenary.nvim",
    "jay-babu/mason-null-ls.nvim",
  },
  config = function()
    local null_ls = require("null-ls")
    local mason = require("mason-null-ls")
    null_ls.setup({
      on_attach = function(client, _)
        if client.name == "null-ls" then
          client.server_capabilities.documentFormattingProvider = true
          client.server_capabilities.documentRangeFormattingProvider = true
        end
      end,
    })
    mason.setup({
      handlers = {
        function(source_name, methods)
          mason.default_setup(source_name, methods)
        end,
      },
    })
  end,
}
