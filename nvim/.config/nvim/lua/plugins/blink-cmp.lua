local icons = {
	Copilot = "",

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
	{
		"zbirenbaum/copilot.lua",
		opts = {
			panel = { enabled = false },
			suggestion = { enabled = false },
		},
	},
	{
		"saghen/blink.cmp",
		version = "*",
		dependencies = { "L3MON4D3/LuaSnip", "giuxtaposition/blink-cmp-copilot" },
		---@module 'blink.cmp'
		---@type blink.cmp.Config
		opts = {
			sources = {
				default = { "lsp", "path", "snippets", "buffer", "copilot" },
				providers = {
					copilot = {
						name = "copilot",
						module = "blink-cmp-copilot",
						async = true,
						-- score_offset = 25,
						transform_items = function(_, items)
							local CompletionItemKind = require("blink.cmp.types").CompletionItemKind
							local kind_idx = #CompletionItemKind + 1
							CompletionItemKind[kind_idx] = "Copilot"
							for _, item in ipairs(items) do
								item.kind = kind_idx
							end
							return items
						end,
					},
				},
			},

			keymap = {
				preset = "default",
				["<Tab>"] = {},
				["<S-Tab>"] = {},
				["<CR>"] = { "select_and_accept", "fallback" },
			},

			cmdline = {
				keymap = {
					["<Tab>"] = { "show", "accept" }, -- recommended, as the default keymap will only show and select the next item
				},
				completion = { menu = { auto_show = true } },
			},

			snippets = { preset = "luasnip" },

			appearance = {
				use_nvim_cmp_as_default = true,
				nerd_font_variant = "mono",
				kind_icons = icons,
			},

			completion = {
				list = {
					selection = {
						preselect = function(ctx)
							return ctx.mode ~= "cmdline" and not require("blink.cmp").snippet_active({ direction = 1 })
						end,
					},
				},
				accept = {
					auto_brackets = {
						enabled = false,
					},
				},
				menu = {
					border = "rounded",
					scrollbar = false,
					draw = {
						padding = 2,
						columns = { { "kind_icon" }, { "label", "label_description", "kind", gap = 1 } },
					},
				},
				documentation = { auto_show = true, window = { border = "rounded" } },
			},
		},
	},
}
