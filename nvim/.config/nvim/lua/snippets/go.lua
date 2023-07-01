local ls = require("luasnip")

local s = ls.snippet
local sn = ls.snippet_node
local t = ls.text_node
local i = ls.insert_node
local f = ls.function_node
local d = ls.dynamic_node
local c = ls.choice_node
local fmt = require("luasnip.extras.fmt").fmt
local fmta = require("luasnip.extras.fmt").fmta

local ts_locals = require("nvim-treesitter.locals")

local function startswith(str, prefix)
	return str:sub(1, #prefix) == prefix
end

local function OR(str, ...)
	for _, v in pairs({ ... }) do
		if str == v then
			return true
		end
	end
	return false
end

local function str_to_Go_type(str, err_name)
	if str == "bool" then
		return t("false")
	end
	if OR(str, "int", "uint", "int8", "uint8", "int16", "uint16", "int32", "uint32", "int64", "uint64") then
		return t("0")
	end
	if OR(str, "float32", "float64") then
		return t("0.0")
	end
	if OR(str, "byte", "rune") then
		return t("0")
	end
	if str == "string" then
		return t('""')
	end
	if OR(str, "interface{}", "any") then
		return t("nil")
	end
	if startswith(str, "*") or startswith(str, "[]") or startswith(str, "map") or startswith(str, "chan") then
		return t("nil")
	end
	if str == "error" then
		if err_name then
			return c(1, {
				i(1, err_name),
				fmt(string.format('fmt.Errorf("{}: %%w", %s)', err_name), { i(1) }),
			})
		end
		return t("nil")
	end

	-- it's ether a struct or and interface, we can't know for sure
	-- so assume it's a struct
	return t(str .. "{}")
end

local handlers = {
	parameter_list = function(node, err_name)
		local out = {}
		for n in node:iter_children() do
			if n:type() == "parameter_declaration" then
				local text = vim.treesitter.get_node_text(n:field("type")[1], 0)
				local go_type = str_to_Go_type(text, err_name)
				table.insert(out, go_type)
				table.insert(out, t(", "))
			end
		end
		table.remove(out, #out)
		return out
	end,
	type_identifier = function(node, err_name)
		local text = vim.treesitter.get_node_text(node, 0)
		return { str_to_Go_type(text, err_name) }
	end,
}

local function get_function_node()
	local curr_node = vim.treesitter.get_node()
	if not curr_node then
		return
	end

	local function_node_types = {
		function_declaration = true,
		method_declaration = true,
		func_literal = true,
	}

	local curr_scope = ts_locals.get_scope_tree(curr_node, 0)
	for _, n in pairs(curr_scope) do
		if function_node_types[n:type()] then
			return n, n:type()
		end
	end

	return nil, nil
end

local function gen_snipet_node(err_name)
	local function_node, function_type = get_function_node()
	if not function_node then
		return t("")
	end

	local query_str = string.format("(%s result: (_) @result)", function_type)
	local query = vim.treesitter.query.parse("go", query_str)

	for _, node in query:iter_captures(function_node, 0) do
		if not handlers[node:type()] then
			return t("")
		end
		return handlers[node:type()](node, err_name)
	end
end

local function return_values(args)
	local err_name = args[1][1]
	return sn(nil, gen_snipet_node(err_name))
end

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
		{ trig = "iferr", name = "if error" },
		fmta(
			[[
		if <> != nil {<>
			return <>
		}
	]],
			{ i(1, "err"), i(2), d(3, return_values, { 1 }) }
		)
	),
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
		func (<>) <>(<>) <><><>{
			<>
		}
		]],
			{ i(1), i(2), i(3), f(addLeftParam, { 4 }), i(4), f(addRightParam, { 4 }), i(0) }
		)
	),
	s({ trig = "lerr", name = "log error" }, fmt('log.Error().Err(err).Msg("Failed to {}")', i(1))),
}
