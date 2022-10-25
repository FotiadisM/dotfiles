require("noice").setup({
	cmdline = {
		format = {
			search_down = {
				view = "cmdline",
			},
			search_up = {
				view = "cmdline",
			},
		},
	},
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
