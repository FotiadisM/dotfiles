return {
	"lukas-reineke/indent-blankline.nvim",
	event = "BufReadPre",
	config = function()
		require("ibl").setup({
			scope = {
				show_start = false,
				show_end = false,
			},
			exclude = {
				filetypes = {
					"help",
					"man",
					"lspinfo",
					"packer",
					"noice",
					"lazy",
					"gitcommit",
					"NvimTree",
					"checkhealth",
					"TelescopePrompt",
					"TelescopeResults",
				},
				buftypes = {
					"terminal",
					"nofile",
					"quickfix",
					"prompt",
				},
			},
		})

		local hooks = require("ibl.hooks")
		hooks.register(hooks.type.WHITESPACE, hooks.builtin.hide_first_space_indent_level)
		hooks.register(hooks.type.WHITESPACE, hooks.builtin.hide_first_tab_indent_level)
	end,
}
