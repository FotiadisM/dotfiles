return {
	"folke/noice.nvim",
	event = "VeryLazy",
	dependencies = {
		"MunifTanjim/nui.nvim",
	},
	config = function()
		require("noice").setup({
			lsp = {
				progress = {
					enabled = false,
				},
				override = {
					["vim.lsp.util.convert_input_to_markdown_lines"] = true,
					["vim.lsp.util.stylize_markdown"] = true,
					["cmp.entry.get_documentation"] = true,
				},
				hover = {
					enabled = false,
				},
				signature = {
					enabled = false,
				},
			},
			presets = {
				bottom_search = true,
				long_message_to_split = true,
				inc_rename = false,
				lsp_doc_border = false,
			},
			views = {
				cmdline_popup = {
					position = { row = "35%", col = "50%" },
					size = { width = 60, height = "auto" },
				},
				popupmenu = {
					relative = "editor",
					position = { row = "48%", col = "50%" },
					size = { width = 60, height = 10 },
					border = { style = "rounded", padding = { 0, 1 } },
					win_options = {
						winhighlight = { Normal = "Normal", FloatBorder = "DiagnosticInfo" },
					},
				},
			},
			routes = {
				{
					view = "mini",
					filter = { event = "msg_showmode" },
				},
			},
		})
	end,
}
