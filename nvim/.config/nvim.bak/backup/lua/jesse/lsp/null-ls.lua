local null_ls_status_ok, null_ls = pcall(require, "null-ls")
if not null_ls_status_ok then
    return
end

local augroup = vim.api.nvim_create_augroup("LspFormatting", {})
null_ls.setup {
    debug = false,
    sources = {
        null_ls.builtins.diagnostics.eslint_d,
        null_ls.builtins.formatting.prettier,
        null_ls.builtins.formatting.elm_format,
        null_ls.builtins.formatting.stylelint,
        null_ls.builtins.diagnostics.stylelint
    },
    on_attach = require("jesse/lsp/shared").on_attach
}
