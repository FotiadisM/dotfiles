require("nvim-autopairs").setup({
	check_ts = true,
	enable_check_bracket_line = false,
	ignored_next_char = "[%w%.]" -- will ignore alphanumeric and `.` symbol
})

local cmp_autopairs = require("nvim-autopairs.completion.cmp")
require("cmp").event:on("confirm_done", cmp_autopairs.on_confirm_done())
