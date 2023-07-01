return {
	{
		"neovim/nvim-lspconfig",
		dependencies = {
			"j-hui/fidget.nvim",

			"williamboman/mason.nvim",
			"williamboman/mason-lspconfig.nvim",
			"jayp0521/mason-null-ls.nvim",

			{ "jose-elias-alvarez/null-ls.nvim", dependencies = "nvim-lua/plenary.nvim" },

			"folke/neodev.nvim",
			"simrat39/rust-tools.nvim",
			"b0o/schemastore.nvim",
			{ "someone-stole-my-name/yaml-companion.nvim", dependencies = "nvim-lua/plenary.nvim" },
			{ "pmizio/typescript-tools.nvim", dependencies = { "nvim-lua/plenary.nvim", "neovim/nvim-lspconfig" } },

			"SmiteshP/nvim-navbuddy",
		},
		lazy = false,
		config = function()
			vim.lsp.handlers["textDocument/hover"] = vim.lsp.with(vim.lsp.handlers.hover, { border = "rounded" })
			vim.lsp.handlers["textDocument/signatureHelp"] =
				vim.lsp.with(vim.lsp.handlers.signature_help, { border = "rounded" })

			vim.diagnostic.config({
				virtual_text = {
					prefix = "●",
					source = "if_many",
				},
				float = {
					source = "if_many",
				},
			})

			local on_attach = require("lsp").on_attach
			local make_config = require("lsp").make_config

			require("fidget").setup({
				text = { spinner = "dots" },
				sources = {
					["null-ls"] = {
						ignore = true,
					},
				},
			})

			require("mason").setup()
			require("mason-lspconfig").setup({
				ensure_installed = { "tsserver" },
				automatic_installation = { exclude = { "clangd", "rust_analyzer" } },
			})

			local lspconf = require("lspconfig")

			require("neodev").setup()
			lspconf["lua_ls"].setup(require("lsp.servers.sumneko_lua").setup(make_config(), on_attach))

			lspconf["gopls"].setup(require("lsp.servers.gopls").setup(make_config(), on_attach))
			lspconf["texlab"].setup(require("lsp.servers.texlab").setup(make_config(), on_attach))
			lspconf["html"].setup(require("lsp.servers.html").setup(make_config(), on_attach))
			lspconf["jsonls"].setup(require("lsp.servers.jsonls").setup(make_config(), on_attach))
			lspconf["yamlls"].setup(require("lsp.servers.yamlls").setup(make_config(), on_attach))
			lspconf["volar"].setup(require("lsp.servers.volar").setup(make_config(), on_attach))
			require("typescript-tools").setup(require("lsp.servers.tsserver").setup(make_config(), on_attach))
			require("rust-tools").setup({
				server = require("lsp.servers.rust_analyzer").setup(make_config(), on_attach),
			})
			local clangd = make_config()
			clangd.filetypes = { "c", "cpp", "objc", "objcpp", "cuda" }
			lspconf["clangd"].setup(clangd)
			lspconf["bashls"].setup(make_config())
			lspconf["dockerls"].setup(make_config())
			lspconf["tailwindcss"].setup(make_config())
			lspconf["terraformls"].setup(make_config())

			require("lsp.servers.null_ls").setup(on_attach)
			require("mason-null-ls").setup({ automatic_installation = true })

			local signs = { Error = " 󰅙", Warn = " ", Hint = " 󰋼", Info = " 󰌵" }
			for type, icon in pairs(signs) do
				local hl = "DiagnosticSign" .. type
				vim.fn.sign_define(hl, { text = icon, texthl = hl, numhl = hl })
			end

			return {
				on_attach = on_attach,
				make_config = make_config,
			}
		end,
	},
	{
		"SmiteshP/nvim-navbuddy",
		dependencies = { "neovim/nvim-lspconfig", "SmiteshP/nvim-navic", "MunifTanjim/nui.nvim" },
		opts = { lsp = { auto_attach = true } },
	},
}
