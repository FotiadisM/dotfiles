local colors = {
	dark = "#1f2335",
	white = "#ffffff",
	gray = "#CCCCCC",
	blue = "#2ac3de",
	purple = "#9d7cd8",
	orange = "#ff9e64",
	green = "#9ece6a",
	teal = "#1abc9c",
	red = "#f7768e",
}

return {
	normal = {
		a = { bg = colors.blue, fg = colors.dark, gui = "bold" },
		b = { bg = colors.dark, fg = colors.white },
		c = { bg = colors.dark, fg = colors.gray },
	},
	insert = {
		a = { bg = colors.teal, fg = colors.dark, gui = "bold" },
		b = { bg = colors.dark, fg = colors.white },
		c = { bg = colors.dark, fg = colors.gray },
	},
	visual = {
		a = { bg = colors.green, fg = colors.dark, gui = "bold" },
		b = { bg = colors.dark, fg = colors.white },
		c = { bg = colors.dark, fg = colors.gray },
	},
	replace = {
		a = { bg = colors.red, fg = colors.dark, gui = "bold" },
		b = { bg = colors.dark, fg = colors.white },
		c = { bg = colors.dark, fg = colors.gray },
	},
	command = {
		a = { bg = colors.orange, fg = colors.dark, gui = "bold" },
		b = { bg = colors.dark, fg = colors.white },
		c = { bg = colors.dark, fg = colors.gray },
	},
	inactive = {
		a = { bg = colors.purple, fg = colors.gray, gui = "bold" },
		b = { bg = colors.dark, fg = colors.white },
		c = { bg = colors.dark, fg = colors.gray },
	},
}
