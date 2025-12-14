local ls = require("luasnip")

local s = ls.snippet
local t = ls.text_node
local c = ls.choice_node

return {
	s(
		"td",
		c(1, {
			t("TODO(FotiadisM): "),
			t("BUG(FotiadisM): "),
		})
	),
}
