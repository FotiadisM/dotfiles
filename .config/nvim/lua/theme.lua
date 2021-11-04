vim.g.tokyonight_style = "night"
vim.g.tokyonight_transparent_sidebar = true
vim.cmd([[colorscheme tokyonight]])

require("lualine").setup({
	options = {
		theme = "tokyonight",
	},
	extensions = { "nvim-tree" },
})
