require("bufferline").setup({
	options = {
		diagnostics = "nvim_lsp",
		offsets = {{ filetype = "NvimTree", text = "File Explorer", highlight = "Directory", text_align = "left" }},
		separator_style = "thin",
		-- enforce_regular_tabs = false,
		-- always_show_bufferline = true,
		show_buffer_close_icons = false,
		show_tab_indicators = true,
	},
})
