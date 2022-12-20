return function(use)
	use({
		"folke/which-key.nvim",
		config = function()
			require("which-key").setup({})
		end,
	})

	use({
		"rmagatti/auto-session",
		config = function()
			require("auto-session").setup({
				log_level = "info",
				auto_session_suppress_dirs = { "~/", "~/Projects" },
			})
		end,
	})
	--
	-- use({
	--     'VonHeikemen/lsp-zero.nvim',
	--     requires = { -- LSP Support
	--         { 'neovim/nvim-lspconfig' }, { 'williamboman/mason.nvim' }, { 'williamboman/mason-lspconfig.nvim' },
	--
	--         -- Autocompletion
	--         { 'hrsh7th/nvim-cmp' }, { 'hrsh7th/cmp-buffer' }, { 'hrsh7th/cmp-path' }, { 'saadparwaiz1/cmp_luasnip' },
	--         { 'hrsh7th/cmp-nvim-lsp' }, { 'hrsh7th/cmp-nvim-lua' }, -- Snippets
	--         { 'L3MON4D3/LuaSnip' }, { 'rafamadriz/friendly-snippets' } },
	--     config = function()
	--         local lsp = require('lsp-zero')
	--
	--         lsp.preset('recommended')
	--         lsp.setup()
	--     end
	-- })
	--
	use({
		"windwp/nvim-autopairs",
		config = function()
			require("nvim-autopairs").setup()
			local cmp_autopairs = require("nvim-autopairs.completion.cmp")
			local cmp = require("cmp")
			cmp.event:on("confirm_done", cmp_autopairs.on_confirm_done())
		end,
	})
	--
	use({
		"nvim-tree/nvim-tree.lua",
		requires = { "nvim-tree/nvim-web-devicons" },
		config = function()
			require("nvim-tree").setup()
		end,
	})

	use({
		"akinsho/bufferline.nvim",
		tag = "v3.*",
		requires = { "nvim-tree/nvim-web-devicons" },
		config = function()
			require("bufferline").setup({})
		end,
	})
	--
	use({
		"petertriho/nvim-scrollbar",
		config = function()
			require("scrollbar").setup()
		end,
	})

	use({
		"kosayoda/nvim-lightbulb",
		requires = "antoinemadec/FixCursorHold.nvim",
		config = function()
			require("nvim-lightbulb").setup({ autocmd = { enabled = true } })
		end,
	})

	use({
		"jose-elias-alvarez/null-ls.nvim",
		config = function()
			local null_ls = require("null-ls")
			local builtins = require("null-ls.builtins")

			local on_attach = function(client, bufnr)
				-- null-ls formatting
				local augroup = vim.api.nvim_create_augroup("LspFormatting", {})
				if client.supports_method("textDocument/formatting") then
					vim.api.nvim_clear_autocmds({ group = augroup, buffer = bufnr })
					vim.api.nvim_create_autocmd("BufWritePre", {
						group = augroup,
						buffer = bufnr,
						callback = function()
							vim.lsp.buf.format({ bufnr = bufnr })
						end,
					})
				end
				vim.notify("Loaded Null-ls language server!")
			end

			local sources = {
				builtins.formatting.stylua,
				builtins.diagnostics.zsh,
				builtins.diagnostics.eslint_d,
				builtins.formatting.prettier_d_slim,
				builtins.formatting.elm_format,
				builtins.formatting.stylelint,
				builtins.diagnostics.stylelint,
			}

			null_ls.setup({
				debug = false,
				on_attach = on_attach,
				sources = sources,
			})
		end,
	})
end
