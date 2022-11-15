require("noice").setup({
	presets = {
		bottom_search = true,
		long_message_to_split = true,
		lsp_doc_border = true,
	},
	routes = {
		{
			filter = {
				event = "msg_show",
				kind = "",
				find = "written",
			},
			opts = { skip = true },
		},
	},
})
