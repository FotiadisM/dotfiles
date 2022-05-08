require("bufferline").setup({
	options = {
		diagnostics = "nvim_lsp",
		offsets = { { filetype = "NvimTree", text = "File Explorer", highlight = "Directory", text_align = "left" } },
		separator_style = "thin",
		show_buffer_close_icons = true,
		show_tab_indicators = true,
	},
})
