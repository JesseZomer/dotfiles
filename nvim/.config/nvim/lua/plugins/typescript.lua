return {
  "neovim/nvim-lspconfig",
  dependencies = { "jose-elias-alvarez/typescript.nvim" },
  opts = {
    -- make sure mason installs the server
    servers = {
      ---@type lspconfig.options.tsserver
      tsserver = {
        settings = {
          importModuleSpecifierPreference = "project-relative",
        },
      },
      stylelint_lsp = {
        filetypes = { "css", "less", "postcss", "sass", "scss", "sugarss", "vue", "wxss" },
        settings = {
          stylelintplus = {
            autoFixOnSave = true,
          },
        },
      },
    },
    setup = {
      angularls = function(_, opts)
        require("lspconfig").angularls.setup({
          root_dir = require("lspconfig.util").root_pattern("project.json"),
        })
        return true
      end,
    },
  },
}
