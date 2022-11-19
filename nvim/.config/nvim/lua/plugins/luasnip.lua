local ls = require("luasnip")
local types = require("luasnip.util.types")

local s = ls.snippet
local sn = ls.snippet_node
local t = ls.text_node
local i = ls.insert_node
local f = ls.function_node
local c = ls.choice_node
local d = ls.dynamic_node
local fmt = require("luasnip.extras.fmt").fmt
local fmta = require("luasnip.extras.fmt").fmta
local rep = require("luasnip.extras").rep

local ts_locals = require("nvim-treesitter.locals")
local ts_utils = require("nvim-treesitter.ts_utils")

ls.config.set_config({
	history = true,
	updateevents = "TextChanged,TextChangedI",
	enable_autosnippets = true,
	ext_opts = {
		[types.choiceNode] = {
			active = {
				virt_text = { { "● Choice Node", "Special" } },
			},
		},
	},
})

ls.add_snippets("all", {
	s(
		"todo",
		c(1, {
			t("TODO(FotiadisM): "),
			t("NOTE(FotiadisM): "),
			t("WARN(FotiadisM): "),
			t("BUG(FotiadisM): "),
		})
	),
}, { key = "unique" })

ls.add_snippets("lua", {
	s("rr", fmt('require("{}"){}', { i(1), i(0) })),
	s("lr", fmt('local {} = require("{}"){}', { i(2), i(1), i(0) })),
	s("lf", fmt("local {} = function({})\n\t{}\nend{}", { i(1), i(2), i(3), i(0) })),
	s("mf", fmt("{}.{} = function({})\n\t{}\nend{}", { i(1), i(2), i(3), i(4), i(0) })),
}, { key = "unique" })

ls.add_snippets("typescriptreact", {
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
}, { key = "unique" })

local transforms = {
	int = function(_, _)
		return t("0")
	end,

	bool = function(_, _)
		return t("false")
	end,

	string = function(_, _)
		return t([[""]])
	end,

	error = function(_, info)
		if info then
			info.index = info.index + 1

			return c(info.index, {
				t(info.err_name),
				t(string.format('errors.Wrap(%s, "%s")', info.err_name, info.func_name)),
			})
		else
			return t("err")
		end
	end,

	-- Types with a "*" mean they are pointers, so return nil
	[function(text)
		return string.find(text, "*", 1, true) ~= nil
	end] = function(_, _)
		return t("nil")
	end,
}

local transform = function(text, info)
	local condition_matches = function(condition, ...)
		if type(condition) == "string" then
			return condition == text
		else
			return condition(...)
		end
	end

	for condition, result in pairs(transforms) do
		if condition_matches(condition, text, info) then
			return result(text, info)
		end
	end

	return t(text)
end

local handlers = {
	parameter_list = function(node, info)
		local result = {}

		local count = node:named_child_count()
		for idx = 0, count - 1 do
			local matching_node = node:named_child(idx)
			local type_node = matching_node:field("type")[1]
			table.insert(result, transform(vim.treesitter.get_node_text(type_node, 0), info))
			if idx ~= count - 1 then
				table.insert(result, t({ ", " }))
			end
		end

		return result
	end,

	type_identifier = function(node, info)
		local text = vim.treesitter.get_node_text(node, 0)
		return { transform(text, info) }
	end,
}

local function golang_get_retun_value(info)
	local cursor_node = ts_utils.get_node_at_cursor()
	local scope = ts_locals.get_scope_tree(cursor_node, 0)

	local function_node
	for _, v in ipairs(scope) do
		if ({
			function_declaration = true,
			method_declaration = true,
			func_literal = true,
		})[v:type()] then
			function_node = v
			break
		end
	end
	if not function_node then
		print("Not inside of a function")
		return t("")
	end

	local query = vim.treesitter.parse_query(
		"go",
		[[
      [
        (method_declaration result: (_) @id)
        (function_declaration result: (_) @id)
        (func_literal result: (_) @id)
      ]
    ]]
	)

	for _, node in query:iter_captures(function_node, 0) do
		if handlers[node:type()] then
			return handlers[node:type()](node, info)
		end
	end
end

ls.add_snippets("go", {
	s(
		"ife",
		fmta(
			[[
	<val>, <err> := <f>
	if <err_same> != nil {
		return <result>
	}
	<finish>
	]],
			{
				val = i(1),
				err = i(2, "err"),
				f = i(3),
				err_same = rep(2),
				result = d(4, function(args)
					return sn(nil, golang_get_retun_value({ index = 0, err_name = args[1][1], func_name = args[2][1] }))
				end, { 2, 3 }),
				finish = i(0),
			}
		)
	),
}, { key = "unique" })
