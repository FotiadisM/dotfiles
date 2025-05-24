return {
	{
		"j-hui/fidget.nvim",
		event = "LspAttach",
		opts = {
			progress = {
				suppress_on_insert = true,
				ignore = { "null-ls" },
			},
		},
	},
	{
		"williamboman/mason.nvim",
		config = true,
	},
	{
		"simrat39/rust-tools.nvim",
	},
	{
		"b0o/schemastore.nvim",
	},
	{
		"someone-stole-my-name/yaml-companion.nvim",
		dependencies = "nvim-lua/plenary.nvim",
	},
	{
		"pmizio/typescript-tools.nvim",
		dependencies = { "nvim-lua/plenary.nvim", "neovim/nvim-lspconfig" },
	},
	{
		"folke/lazydev.nvim",
		ft = "lua",
		opts = {
			library = {
				{ path = "${3rd}/luv/library", words = { "vim%.uv" } },
			},
			enabled = function(root_dir)
				-- disable when a .luarc.json file is found
				return not vim.uv.fs_stat(root_dir .. "/.luarc.json")
			end,
		},
	},
	{
		"neovim/nvim-lspconfig",
		dependencies = {
			{ "williamboman/mason-lspconfig.nvim", dependencies = "williamboman/mason.nvim" },
			{ "nvimtools/none-ls.nvim", dependencies = "nvim-lua/plenary.nvim" },
			{ "jayp0521/mason-null-ls.nvim", dependencies = "williamboman/mason.nvim" },
		},
		lazy = false,
		config = function()
			vim.diagnostic.config({
				virtual_text = {
					prefix = "●",
					source = "if_many",
				},
				float = {
					source = "if_many",
				},
			})

			vim.lsp.inlay_hint.enable(true, nil)
			local signs = { Error = " 󰅙", Warn = " ", Hint = " 󰋼", Info = " 󰌵" }
			for type, icon in pairs(signs) do
				local hl = "DiagnosticSign" .. type
				vim.fn.sign_define(hl, { text = icon, texthl = hl, numhl = hl })
			end

			local on_attach = require("lsp").on_attach
			local make_config = require("lsp").make_config

			local lspconf = require("lspconfig")

			lspconf["lua_ls"].setup(require("lsp.servers.lua_ls").setup(make_config(), on_attach))
			lspconf["gopls"].setup(require("lsp.servers.gopls").setup(make_config(), on_attach))
			lspconf["texlab"].setup(require("lsp.servers.texlab").setup(make_config(), on_attach))
			lspconf["html"].setup(require("lsp.servers.html").setup(make_config(), on_attach))
			lspconf["jsonls"].setup(require("lsp.servers.jsonls").setup(make_config(), on_attach))
			lspconf["yamlls"].setup(require("lsp.servers.yamlls").setup(make_config(), on_attach))
			lspconf["volar"].setup(require("lsp.servers.volar").setup(make_config(), on_attach))
			lspconf["clangd"].setup(require("lsp.servers.clangd").setup(make_config(), on_attach))
			lspconf["pyright"].setup(require("lsp.servers.pyright").setup(make_config(), on_attach))
			lspconf["ruff"].setup(make_config())
			lspconf["bashls"].setup(make_config())
			lspconf["dockerls"].setup(make_config())
			lspconf["tailwindcss"].setup(make_config())
			lspconf["terraformls"].setup(make_config())
			lspconf["kcl"].setup(make_config())
			lspconf["buf_ls"].setup(make_config())
			lspconf["tilt_ls"].setup(make_config())
			require("typescript-tools").setup(require("lsp.servers.ts_ls").setup(make_config(), on_attach))
			require("rust-tools").setup({
				server = require("lsp.servers.rust_analyzer").setup(make_config(), on_attach),
			})
			require("lsp.servers.null_ls").setup(on_attach)

			require("mason-lspconfig").setup({
				automatic_enable = false,
				ensure_installed = { "ts_ls" },
				automatic_installation = { exclude = { "clangd", "rust_analyzer" } },
			})
			require("mason-null-ls").setup({ automatic_installation = true })

			return {
				on_attach = on_attach,
				make_config = make_config,
			}
		end,
	},
}
