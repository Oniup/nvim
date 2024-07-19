local u = require("util")
local ui = require("ui")
local icons = require("icons")

local function lsp_load_buf_mappings(client, bufnr)
  local map = vim.keymap.set
  local function lsp_opts(desc)
    return { noremap = true, silent = true, buffer = bufnr, desc = desc }
  end

  map("i", "<C-h>", vim.lsp.buf.signature_help, lsp_opts("Signature Help"))
  map("n", "K", vim.lsp.buf.hover, lsp_opts("Open hover info"))
  map({ "n", "v" }, "<leader>a", vim.lsp.buf.code_action, lsp_opts("Code actions"))

  map("n", "<leader>fo", vim.lsp.buf.format, lsp_opts("Format file"))
  map("n", "<leader>re", vim.lsp.buf.rename, lsp_opts("Rename"))

  map("n", "gd", "<CMD> Telescope lsp_definitions <CR>", lsp_opts("Goto definitions"))
  map("n", "gi", "<CMD> Telescope lsp_implementations <CR>", lsp_opts("Goto implementations"))
  map("n", "gt", "<CMD> Telescope lsp_type_definitions <CR>", lsp_opts("Goto type definitions"))
  map("n", "gr", "<CMD> Telescope lsp_references <CR>", lsp_opts("List references"))

  map("n", "gl", vim.diagnostic.open_float, lsp_opts("Open diagnostics hover info"))
  map("n", "<leader>gn", vim.diagnostic.goto_next, lsp_opts("Go to next diagnostic"))
  map("n", "<leader>gp", vim.diagnostic.goto_prev, lsp_opts("Go to prev diagnostic"))

  if client.name == "clangd" then
    map(
      "n",
      "<leader>o",
      "<CMD> ClangdSwitchSourceHeader <CR>",
      lsp_opts("Switch between source/header")
    )
  end
end

local function create_client_opts(server)
  -- Load specific settings
  local capabilities = vim.lsp.protocol.make_client_capabilities()
  capabilities.textDocument.completion.completionItem = {
    documentationFormat = { "markdown", "plaintext" },
    snippetSupport = true,
    preselectSupport = true,
    insertReplaceSupport = true,
    labelDetailsSupport = true,
    deprecatedSupport = true,
    commitCharactersSupport = true,
    tagSupport = { valueSet = { 1 } },
    resolveSupport = {
      properties = {
        "documentation",
        "additionalTextEdits",
        "detail",
      },
    },
  }
  -- capabilities = vim.tbl_deep_extend("force", capabilities, require("cmp_nvim_lsp").default_capabilities())

  return {
    capabilities = capabilities,
    settings = u.prequire("lsp_clients." .. server),
    on_attach = function(client, bufnr)
      vim.api.nvim_set_option_value("omnifunc", "v:lua.vim.lsp.omnifunc", { buf = bufnr })
      lsp_load_buf_mappings(client, bufnr)
    end,
  }
end

local function ui_set_popup_window()
  require("lspconfig.ui.windows").default_options = {
    border = ui.border.style,
  }
end

local function ui_set_diagnostics()
  for _, sign in ipairs({
    { name = "DiagnosticSignError", text = icons.diagnostics.error },
    { name = "DiagnosticSignWarn",  text = icons.diagnostics.warn },
    { name = "DiagnosticSignHint",  text = icons.diagnostics.hint },
    { name = "DiagnosticSignInfo",  text = icons.diagnostics.info },
  }) do
    vim.fn.sign_define(sign.name, {
      texthl = sign.name,
      text = sign.text,
      numhl = "",
    })
  end
  vim.diagnostic.config(ui.lsp)
end

return {
  "neovim/nvim-lspconfig",
  lazy = false,
  dependencies = {
    "nvimtools/none-ls.nvim",
    "stevearc/dressing.nvim",
  },
  config = function()
    require("mason-lspconfig").setup_handlers({
      function(server)
        require("lspconfig")[server].setup(create_client_opts(server))
      end,
    })

    ui_set_popup_window()
    ui_set_diagnostics()
  end,
}
