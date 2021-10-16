require("nvim-autopairs").setup({
	check_ts = true,
	enable_check_bracket_line = false,
	ignored_next_char = "[%w%.]" -- will ignore alphanumeric and `.` symbol
})

require("nvim-autopairs.completion.cmp").setup({
	map_cr = true,
	map_complete = false,
	auto_select = true,
	insert = false,
	map_char = { -- modifies the function or method delimiter by filetypes
		all = '(',
		tex = '{'
	}
})

