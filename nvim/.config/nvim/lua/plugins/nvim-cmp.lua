return {
	"hrsh7th/nvim-cmp",
	dependencies = {
		"hrsh7th/cmp-buffer",
		"hrsh7th/cmp-path",
		"hrsh7th/cmp-cmdline",
		"hrsh7th/cmp-nvim-lsp",
		"hrsh7th/cmp-nvim-lsp-document-symbol",
		"hrsh7th/cmp-nvim-lsp-signature-help",
		{ "petertriho/cmp-git", dependencies = "nvim-lua/plenary.nvim" },

		"L3MON4D3/LuaSnip",
		"saadparwaiz1/cmp_luasnip",

		"onsails/lspkind-nvim",
		"windwp/nvim-autopairs",
	},
	config = function()
		local has_words_before = function()
			local line, col = unpack(vim.api.nvim_win_get_cursor(0))
			return col ~= 0 and vim.api.nvim_buf_get_lines(0, line - 1, line, true)[1]:sub(col, col):match("%s") == nil
		end

		require("cmp_git").setup()
		local cmp = require("cmp")

		cmp.setup({
			snippet = {
				expand = function(args)
					require("luasnip").lsp_expand(args.body)
				end,
			},
			window = {
				completion = cmp.config.window.bordered(),
				documentation = cmp.config.window.bordered(),
			},
			mapping = {
				["<Tab>"] = cmp.mapping(function(fallback)
					if cmp.visible() then
						cmp.select_next_item({ behavior = cmp.SelectBehavior.Select })
					elseif has_words_before() then
						cmp.complete()
					else
						fallback()
					end
				end, { "i", "s" }),
				["<S-Tab>"] = cmp.mapping(function(fallback)
					if cmp.visible() then
						cmp.select_prev_item({ behavior = cmp.SelectBehavior.Select })
					else
						fallback()
					end
				end, { "i", "s" }),
				["<C-Space>"] = cmp.mapping.complete(),
				["<ESC>"] = cmp.mapping.close(),
				["<CR>"] = cmp.mapping.confirm({
					behavior = cmp.ConfirmBehavior.Replace,
					select = true,
				}),
			},
			sources = {
				{ name = "nvim_lsp" },
				{ name = "luasnip" },
				{ name = "nvim_lsp_signature_help" },
				{ name = "buffer", keyword_length = 4 },
				{ name = "path" },
			},
			completion = {
				completeopt = "menu,menuone",
			},
			formatting = {
				format = require("lspkind").cmp_format({
					with_text = true,
					maxwidth = 50,
					menu = {
						buffer = "Buffer",
						nvim_lsp = "LSP",
						luasnip = "LuaSnip",
						nvim_lua = "Lua",
						latex_symbols = "Latex",
					},
				}),
			},
		})

		cmp.setup.filetype("gitcommit", {
			sources = cmp.config.sources({
				{ name = "cmp_git" },
			}, {
				{ name = "buffer" },
			}),
		})

		cmp.setup.cmdline("/", {
			mapping = cmp.mapping.preset.cmdline(),
			sources = {
				{ name = "buffer" },
				{ name = "nvim_lsp_document_symbol" },
			},
			completion = {
				completeopt = "menu,menuone,noselect",
			},
		})

		cmp.setup.cmdline("?", {
			mapping = cmp.mapping.preset.cmdline(),
			sources = {
				{ name = "buffer" },
				{ name = "nvim_lsp_document_symbol" },
			},
			completion = {
				completeopt = "menu,menuone,noselect",
			},
		})

		cmp.setup.cmdline(":", {
			mapping = cmp.mapping.preset.cmdline(),
			sources = cmp.config.sources({
				{ name = "path" },
			}, {
				{ name = "cmdline" },
			}),
			completion = {
				completeopt = "menu,menuone,noselect",
			},
		})

		cmp.event:on("confirm_done", require("nvim-autopairs.completion.cmp").on_confirm_done())
	end,
}
