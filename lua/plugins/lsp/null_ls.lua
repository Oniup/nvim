return {
    "nvimtools/none-ls.nvim",
    name = "null_ls",
    dependencies = {
        "lspconfig",
        "plenary",
        "mason",
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

                    client.server_capabilities.hoverProvider = false
                    client.server_capabilities.definitionProvider = false
                    client.server_capabilities.referencesProvider = false
                    client.server_capabilities.implementationProvider = false
                    client.server_capabilities.signatureHelpProvider = false
                    client.server_capabilities.documentHighlightProvider = false
                    client.server_capabilities.workspaceSymbolProvider = false
                    client.server_capabilities.codeActionProvider = false
                    client.server_capabilities.renameProvider = false
                    client.server_capabilities.documentSymbolProvider = false
                    client.server_capabilities.codeLensProvider = false
                    client.server_capabilities.documentLinkProvider = false
                    client.server_capabilities.colorProvider = false
                    client.server_capabilities.foldingRangeProvider = false
                    client.server_capabilities.declarationProvider = false
                    client.server_capabilities.executeCommandProvider = false
                    client.server_capabilities.typeDefinitionProvider = false
                    client.server_capabilities.semanticTokensProvider = nil
                    client.server_capabilities.inlayHintProvider = false
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
