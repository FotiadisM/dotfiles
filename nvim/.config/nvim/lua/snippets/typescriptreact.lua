local ls = require("luasnip")

local s = ls.snippet
local i = ls.insert_node
local f = ls.function_node
local fmt = require("luasnip.extras.fmt").fmt
local fmta = require("luasnip.extras.fmt").fmta
local rep = require("luasnip.extras").rep

return {
	s(
		{ trig = "us", name = "useState" },
		fmt("const [{}, set{}] = useState<{}>({}){}", {
			i(1),
			f(function(str)
				return string.gsub(str[1][1], "^%l", string.upper) -- capitalize first letter
			end, { 1 }),
			i(2),
			i(3),
			i(0),
		})
	),
	s(
		{ trig = "comp", name = "createComponent" },
		fmta(
			[[
	type <>Props = {
		<>
	};

	const <> = ({<>}: <>Props): JSX.Element =>> {
		return <>
	}]],
			{ rep(1), i(2), i(1), i(3), rep(1), i(0) }
		)
	),
}
