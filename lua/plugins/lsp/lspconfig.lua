local u = require("core.utils")
local ui = require("core.ui")
local icons = require("core.icons")

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
    capabilities = u.map_tbl(capabilities, require("cmp_nvim_lsp").default_capabilities())

    return {
        capabilities = capabilities,
        settings = u.prequire("language_server_opts.lsp." .. server),
        on_attach = function(client, bufnr)
            -- client.server_capabilities.documentFormattingProvider = false
            -- client.server_capabilities.documentRangeFormattingProvider = false

            -- vim.api.nvim_set_option_value(bufnr, "omnifunc", "v:lua.vim.lsp.omnifunc")
            vim.api.nvim_set_option_value("omnifunc", "v:lua.vim.lsp.omnifunc", { buf = bufnr })
            require("plugins.mappings").lsp_load_buf_mappings(client, bufnr)
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
        { name = "DiagnosticSignWarn", text = icons.diagnostics.warn },
        { name = "DiagnosticSignHint", text = icons.diagnostics.hint },
        { name = "DiagnosticSignInfo", text = icons.diagnostics.info },
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
    name = "lspconfig",
    lazy = false,
    dependencies = {
        "null-ls",
        "mason",
        -- UI
        "dressing",
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
