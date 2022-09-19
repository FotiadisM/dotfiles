require("bufferline").setup({
	options = {
		diagnostics = "nvim_lsp",
		offsets = { { filetype = "NvimTree", text = "File Explorer", highlight = "Directory", text_align = "left" } },
		separator_style = "thick",
		show_buffer_close_icons = false,
		show_tab_indicators = true,
	},
})
