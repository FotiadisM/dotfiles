local ls = require("luasnip")
local types = require("luasnip.util.types")

local s = ls.snippet
local t = ls.text_node
local i = ls.insert_node
local c = ls.choice_node
local f = ls.function_node
local fmt = require("luasnip.extras.fmt").fmt
local fmta = require("luasnip.extras.fmt").fmta
local rep = require("luasnip.extras").rep

ls.config.set_config({
	history = true,
	updateevents = "TextChanged,TextChangedI",
	enable_autosnippets = true,
	ext_opts = {
		[types.choiceNode] = {
			active = {
				virt_text = { { "●", "Special" } },
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
})

ls.add_snippets("lua", {
	s("rr", fmt('require("{}"){}', { i(1), i(0) })),
	s("lr", fmt('local {} = require("{}"){}', { i(2), i(1), i(0) })),
	s("lf", fmt("local {} = function({})\n\t{}\nend{}", { i(1), i(2), i(3), i(0) })),
	s("mf", fmt("{}.{} = function({})\n\t{}\nend{}", { i(1), i(2), i(3), i(4), i(0) })),
})

ls.add_snippets("typescriptreact", {
	s(
		{ trig = "us", name = "useState" },
		fmt("const [{}, set{}] = useState<{}>({}){}", {
			i(1),
			f(function(str)
				return string.gsub(str[1][1], "^%l", string.upper)
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
})
