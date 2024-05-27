local ls = require("luasnip")

local s = ls.snippet
local i = ls.insert_node
local fmt = require("luasnip.extras.fmt").fmt

return {
	s(
		{ trig = "try", name = "try_except" },
		fmt(
			[[
try:
    {}
except {} as e:
    {}
{}]],
			{
				i(1),
				i(2, "Exception"),
				i(3),
				i(0),
			}
		)
	),
}
