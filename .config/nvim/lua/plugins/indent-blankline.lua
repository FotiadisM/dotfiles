require("indent_blankline").setup({
	use_treesitter = true,
	show_first_indent_level = false,
	filetype_exclude = { "help", "NvimTree" },
	buftype_exclude = { "terminal" }
})
