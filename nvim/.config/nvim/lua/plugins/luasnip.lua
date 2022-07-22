local ls = require("luasnip")
local types = require("luasnip.util.types")

local s = ls.snippet
local i = ls.insert_node
local fmt = require("luasnip.extras.fmt").fmt

ls.config.set_config({
	history = true,
	updateevents = "TextChanged,TextChangedI",
	enable_autosnippets = true,
	ext_opts = {
		[types.choiceNode] = {
			active = {
				virt_text = { { "<-", "Error" } },
			},
		},
	},
})

ls.add_snippets("lua", {
	s("lr", fmt('local {} = require("{}"){}', { i(2), i(1), i(0) })),
})
