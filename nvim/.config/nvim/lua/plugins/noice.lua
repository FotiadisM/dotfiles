require("noice").setup({
	messages = {
		view_history = "vsplit",
		view_search = false,
	},
	popupmenu = {
		enabled = true,
		backend = "cmp",
	},
	history = {
		view = "vsplit",
	},
	routes = {
		{ -- hide written messages
			filter = {
				event = "msg_show",
				kind = "",
				find = "written",
			},
			opts = { skip = true },
		},
	},
})
