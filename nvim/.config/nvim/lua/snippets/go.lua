local ls = require("luasnip")

local s = ls.snippet
local i = ls.insert_node
local f = ls.function_node
local fmta = require("luasnip.extras.fmt").fmta

local addLeftParam = function(str)
	if string.find(str[1][1], ",") then
		return "("
	end
	return ""
end

local addRightParam = function(str)
	local ret = ""
	if string.find(str[1][1], ",") then
		ret = ")"
	end
	if str[1][1] ~= "" then
		ret = ret .. " "
	end
	return ret
end

return {
	s(
		{ trig = "ff", name = "func" },
		fmta(
			[[
		func <>(<>) <><><>{
			<>
		}
		]],
			{ i(1), i(2), f(addLeftParam, { 3 }), i(3), f(addRightParam, { 3 }), i(0) }
		)
	),
	s(
		{ trig = "mf", name = "method func" },
		fmta(
			[[
		func (<>) <>(<>) <><><> {
			<>
		}
		]],
			{ i(1), i(2), i(3), f(addLeftParam, { 4 }), i(4), f(addRightParam, { 4 }), i(0) }
		)
	),
}
