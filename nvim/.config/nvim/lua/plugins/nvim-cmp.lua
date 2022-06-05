local has_words_before = function()
	local line, col = unpack(vim.api.nvim_win_get_cursor(0))
	return col ~= 0 and vim.api.nvim_buf_get_lines(0, line - 1, line, true)[1]:sub(col, col):match("%s") == nil
end

require("plugins.luasnip")
local cmp = require("cmp")

cmp.setup({
	snippet = {
		expand = function(args)
			require("luasnip").lsp_expand(args.body)
		end,
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
			behavior = cmp.ConfirmBehavior.Insert,
			select = true,
		}),
	},
	sources = {
		{ name = "nvim_lsp" },
		{ name = "luasnip" },
		{ name = "buffer", keyword_length = 4 },
		{ name = "path" },
		{ name = "nvim_lua" },
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
