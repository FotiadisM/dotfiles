return {
	"L3MON4D3/LuaSnip",
	build = "make install_jsregexp",
	config = function()
		local ls = require("luasnip")
		local types = require("luasnip.util.types")

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

		require("luasnip.loaders.from_lua").load({
			paths = { vim.fn.stdpath("config") .. "/lua/fotiadism/snippets" },
		})
	end,
}
