return {
  "jose-elias-alvarez/null-ls.nvim",
  event = "BufReadPre",
  dependencies = { "mason.nvim" },
  opts = function()
    local nls = require("null-ls")
    return {
      sources = {
        nls.builtins.formatting.prettierd,
        nls.builtins.formatting.stylua,
        nls.builtins.formatting.stylelint,
        nls.builtins.code_actions.eslint_d,
        nls.builtins.diagnostics.stylelint,
      },
    }
  end,
}
