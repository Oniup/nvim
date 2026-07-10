local ui = require("config.ui")

local function ui_set_popup_window()
  require("lspconfig.ui.windows").default_options = {
    border = ui.border.style,
  }
end

return {
  "neovim/nvim-lspconfig",
  dependencies = {
    "williamboman/mason.nvim",
    "williamboman/mason-lspconfig.nvim",
    "ray-x/lsp_signature.nvim",
    "stevearc/conform.nvim",
    "stevearc/dressing.nvim",
  },
  config = function()
    ui_set_popup_window()

    -- Initialize Mason
    require("mason").setup({
      ui = {
        border = ui.border.style,
        width = 0.6,
        height = 0.6,
      },
    })

    -- Auto install servers
    local servers = {
      "lua_ls",
      "neocmake",
      "clangd",
    }

    -- Setup mason-lspconfig to ensure they are downloaded
    require("mason-lspconfig").setup({
      ensure_installed = servers,
    })

    local conform = require("conform")
    conform.setup({
      formatters_by_ft = {
        -- C/C++ and shader languages
        c = { "clang-format" },
        cpp = { "clang-format" },
        glsl = { "clang-format" },
        vert = { "clang-format" },
        frag = { "clang-format" },
        comp = { "clang-format" },

        -- Other language formatters
        lua = { "stylua" },
        python = { "black" },
      },
      format_on_save = {
        -- These options will be passed to conform.format()
        timeout_ms = 500,
        lsp_format = "fallback",
      },
    })

    -- Define capabilities and apply them globally to ALL servers
    local capabilities = require("cmp_nvim_lsp").default_capabilities();
    capabilities.textDocument.completion.completionItem.snippetSupport = false
    vim.lsp.config("*", { -- Applies to every language
      capabilities = capabilities,
    })

    -- Load custom settings for specific servers using native vim.lsp.config
    for _, server_name in ipairs(servers) do
      local ok, custom_settings = pcall(require, "lsp_clients." .. server_name)
      if ok then
        vim.lsp.config(server_name, {
          settings = custom_settings,
        })
      end
      vim.lsp.enable(server_name)
    end

    vim.api.nvim_create_autocmd("LspAttach", {
      group = vim.api.nvim_create_augroup("UserLspConfig", {}),
      callback = function(ev)
        local client = vim.lsp.get_client_by_id(ev.data.client_id)
        local bufnr = ev.buf

        vim.api.nvim_set_option_value("omnifunc", "v:lua.vim.lsp.omnifunc", { buf = bufnr })
        require("config.keymaps").lsp_buffer_attach(client, bufnr)
      end,
    })
  end,
}
