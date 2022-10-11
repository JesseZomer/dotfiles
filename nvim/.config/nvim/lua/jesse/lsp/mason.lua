require("mason").setup {
    ui = {
        icons = {
            package_installed = "✓"
        }
    }
}
mason_lspconfig = require("mason-lspconfig")
mason_lspconfig.setup {
    ensure_installed = { "sumneko_lua", "tsserver", "stylelint_lsp", },
}

mason_lspconfig.setup_handlers({
    function(server_name)
        require("lspconfig")[server_name].setup {
            on_attach = require("jesse/lsp/shared").on_attach
        }
    end
})
