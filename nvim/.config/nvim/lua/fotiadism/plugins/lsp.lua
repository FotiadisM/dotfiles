local severity = vim.diagnostic.severity
vim.diagnostic.config({
	virtual_text = {
		prefix = "●",
		source = "if_many",
	},
	float = {
		source = "if_many",
	},
	signs = {
		text = {
			[severity.ERROR] = " 󰅙",
			[severity.WARN] = " ",
			[severity.HINT] = " 󰋼",
			[severity.INFO] = " 󰌵",
		},
	},
})

vim.api.nvim_create_autocmd("LspAttach", {
	group = vim.api.nvim_create_augroup("lsp_attach_config", { clear = true }),
	callback = function(args)
		local map = function(m, l, r, desc, opts)
			opts = opts or { buffer = args.buf, noremap = true, silent = true }
			desc = desc or nil
			opts.desc = desc
			vim.keymap.set(m, l, r, opts)
		end

		map("n", "gD", vim.lsp.buf.declaration, "go declaration")
		map("n", "gd", vim.lsp.buf.definition, "go definition")
		map("n", "gr", vim.lsp.buf.references, "references")
		map("n", "K", vim.lsp.buf.hover, "hover")
		map("n", "gi", vim.lsp.buf.implementation, "go implementation")
		map("n", "<space>k", vim.lsp.buf.signature_help, "signature help")
		map("n", "<space>ca", vim.lsp.buf.code_action, "code action")
		map("n", "<space>rn", vim.lsp.buf.rename, "rename")
		map("n", "<space>rl", vim.lsp.codelens.run, "run codelens")
		map("n", "<space>e", vim.diagnostic.open_float, "open diagnostics")
		map("n", "<space>cl", vim.diagnostic.setqflist, "diagnostics quicklist")
		map("n", "<space>f", vim.lsp.buf.format, "format")

		-- stylua: ignore start
		map("n", "<space>ds", function() require("telescope.builtin").lsp_document_symbols() end, "document symbols")
		map("n", "<space>ws", function() require("telescope.builtin").lsp_dynamic_workspace_symbols() end,
			"workspace symbols")
		-- stylua: ignore end

		-- lesser used lsp functionality
		map("n", "<space>D", vim.lsp.buf.type_definition, "type definition")
		map("n", "<space>wa", vim.lsp.buf.add_workspace_folder, "add workspace folder")
		map("n", "<space>wr", vim.lsp.buf.remove_workspace_folder, "remove workspace folder")
		map("n", "<space>wl", function()
			print(vim.inspect(vim.lsp.buf.list_workspace_folders()))
		end, "list workspace folders")

		local client = vim.lsp.get_client_by_id(args.data.client_id)
		if not client then
			return
		end

		-- Set some keybinds conditional on server capabilities
		if client.server_capabilities.documentFormattingProvider then
			local disabled_lsp_formatters = { "ts_ls", "html" }
			vim.api.nvim_create_autocmd("BufWritePre", {
				group = vim.api.nvim_create_augroup("lsp_format", { clear = true }),
				callback = function()
					vim.lsp.buf.format({
						filter = function(lsp_client)
							for _, value in ipairs(disabled_lsp_formatters) do
								if lsp_client.name == value then
									return false
								end
							end

							return true
						end,
					})
				end,
			})
		end

		if client.server_capabilities.codeLensProvider then
			vim.api.nvim_create_autocmd({ "BufEnter", "CursorHold", "InsertLeave" }, {
				group = vim.api.nvim_create_augroup("lsp_codelens_refresh", { clear = true }),
				callback = function()
					vim.lsp.codelens.refresh({ bufnr = 0 })
				end,
			})
		end
	end,
})

vim.lsp.config("*", {
	capabilities = {
		textDocument = {
			foldingRange = {
				lineFoldingOnly = true,
				dynamicRegistration = false,
			},
		},
	},
})

return {
	{
		"neovim/nvim-lspconfig",
		lazy = false,
	},
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
		lazy = false,
		config = true,
	},
	{
		"williamboman/mason-lspconfig.nvim",
		lazy = false,
		dependencies = { "williamboman/mason.nvim", "neovim/nvim-lspconfig" },
		opts = {
			ensure_installed = {
				"lua_ls",
				"gopls",
				"ts_ls",
				"html",
				"jsonls",
				"yamlls",
				"pyright",
				"ruff",
				"bashls",
				"dockerls",
				"tailwindcss",
				"eslint",
				"terraformls",
				"kcl",
				"buf_ls",
				"tilt_ls",
			},
			automatic_enable = {
				exclude = {
					"ts_ls",
				},
			},
		},
	},
	{
		"folke/lazydev.nvim",
		ft = "lua",
		opts = {
			library = {
				-- See the configuration section for more details
				-- Load luvit types when the `vim.uv` word is found
				{ path = "${3rd}/luv/library", words = { "vim%.uv" } },
			},
		},
	},
	{
		"nvimtools/none-ls.nvim",
		lazy = false,
		dependencies = "nvim-lua/plenary.nvim",
		config = function()
			local nl = require("null-ls")

			local sources = {
				nl.builtins.code_actions.gomodifytags,
				nl.builtins.code_actions.impl,

				nl.builtins.formatting.prettierd,
				nl.builtins.formatting.goimports,
				nl.builtins.formatting.stylua,
				nl.builtins.formatting.buf,
				nl.builtins.formatting.isort,

				nl.builtins.diagnostics.golangci_lint,
				nl.builtins.diagnostics.buf,
			}

			nl.setup({
				sources = sources,
			})
		end,
	},
	{
		"jay-babu/mason-null-ls.nvim",
		lazy = false,
		dependencies = { "williamboman/mason.nvim", "nvimtools/none-ls.nvim" },
		opts = { automatic_installation = true },
	},
	{
		"b0o/schemastore.nvim",
	},
	{
		"pmizio/typescript-tools.nvim",
		ft = { "javascript", "typescript", "javascriptreact", "typescriptreact" },
		dependencies = { "nvim-lua/plenary.nvim", "neovim/nvim-lspconfig" },
		opts = {},
	},
}
