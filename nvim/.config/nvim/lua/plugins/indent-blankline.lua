return {
	"lukas-reineke/indent-blankline.nvim",
	event = "BufReadPre",
	config = function()
		require("indent_blankline").setup({
			use_treesitter = true,
			show_first_indent_level = false,
			filetype_exclude = {
				"help",
				"man",
				"packer",
				"lspinfo",
				"lsp-installer",
				"checkhealth",
				"NvimTree",
				"noice",
			},
			buftype_exclude = { "terminal" },
		})
	end,
}
