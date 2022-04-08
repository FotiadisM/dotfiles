local ls = require("luasnip")
local types = require("luasnip.util.types")

local s = ls.snippet
local t = ls.text_node
local i = ls.insert_node
local fmt = require("luasnip.extras.fmt").fmt
local rep = require("luasnip.extras").rep

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

ls.snippets = {
	lua = {
		s("test", t("hello")),
		s("req", fmt('local {} = require("{}")', { i(0), i(1) })),
	},
}
