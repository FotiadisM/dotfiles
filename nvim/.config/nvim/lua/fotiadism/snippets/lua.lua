local ls = require("luasnip")

local s = ls.snippet
local i = ls.insert_node
local fmt = require("luasnip.extras.fmt").fmt

return {
	s("rr", fmt('require("{}"){}', { i(1), i(0) })),
	s("lr", fmt('local {} = require("{}")\n{}', { i(2), i(1), i(0) })),
	s("lf", fmt("local {} = function({})\n\t{}\nend{}", { i(1), i(2), i(3), i(0) })),
	s("mf", fmt("{}.{} = function({})\n\t{}\nend{}", { i(1), i(2), i(3), i(4), i(0) })),
}
