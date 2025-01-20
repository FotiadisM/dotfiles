local icons = {
	Text = "",
	Method = "",
	Function = "",
	Constructor = "",
	Field = "",
	Variable = "",
	Class = "",
	Interface = "",
	Module = "",
	Property = "",
	Unit = "",
	Value = "",
	Enum = "",
	Keyword = "",
	Snippet = "",
	Color = "",
	File = "",
	Reference = "",
	Folder = "",
	EnumMember = "",
	Constant = "",
	Struct = "",
	Event = "",
	Operator = "",
	TypeParameter = "",
}

return {
	"saghen/blink.cmp",
	version = "*",
	dependencies = { "L3MON4D3/LuaSnip" },
	---@module 'blink.cmp'
	---@type blink.cmp.Config
	opts = {
		keymap = {
			preset = "default",
			["<Tab>"] = {},
			["<S-Tab>"] = {},
			["<CR>"] = { "select_and_accept", "fallback" },
			cmdline = {
				preset = "default",
			},
		},
		snippets = { preset = "luasnip" },

		appearance = {
			use_nvim_cmp_as_default = true,
			nerd_font_variant = "mono",
		},

		completion = {
			menu = {
				border = "rounded",
				scrollbar = false,
				draw = {
					padding = 2,
					columns = { { "kind_icon" }, { "label", "label_description", "kind", gap = 1 } },
					components = {
						kind_icon = {
							text = function(ctx)
								return icons[ctx.kind] .. ctx.icon_gap
							end,
						},
					},
				},
			},
			documentation = { auto_show = true, window = { border = "rounded" } },
		},
	},
}
