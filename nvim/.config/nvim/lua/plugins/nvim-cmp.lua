return {
	"hrsh7th/nvim-cmp",
	event = "InsertEnter",
	dependencies = {
		"hrsh7th/cmp-buffer",
		"hrsh7th/cmp-path",
		"hrsh7th/cmp-cmdline",
		"hrsh7th/cmp-nvim-lsp",
		"hrsh7th/cmp-nvim-lsp-document-symbol",

		"L3MON4D3/LuaSnip",
		"saadparwaiz1/cmp_luasnip",

		"onsails/lspkind-nvim",
		"windwp/nvim-autopairs",
	},
	config = function()
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
				["<C-n>"] = cmp.mapping(function(fallback)
					if cmp.visible() then
						cmp.select_next_item({ behavior = cmp.SelectBehavior.Select })
					else
						fallback()
					end
				end, { "i", "s" }),
				["<C-p>"] = cmp.mapping(function(fallback)
					if cmp.visible() then
						cmp.select_prev_item({ behavior = cmp.SelectBehavior.Select })
					else
						fallback()
					end
				end, { "i", "s" }),
				["<C-Space>"] = cmp.mapping.complete(),
				["<ESC>"] = cmp.mapping.close(),
				["<CR>"] = cmp.mapping.confirm(),
			},
			sources = {
				{ name = "nvim_lsp" },
				{ name = "luasnip" },
				{ name = "buffer", keyword_length = 4 },
				{ name = "path" },
			},
			completion = {
				completeopt = "menu,menuone",
			},
			formatting = {
				fields = { "kind", "abbr" },
				format = require("lspkind").cmp_format({
					mode = "symbol",
					maxwidth = 50,
					ellipsis_char = "...",
					before = require("util.tailwindcss").lspkind_format,
				}),
				expandable_indicator = false,
			},
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
