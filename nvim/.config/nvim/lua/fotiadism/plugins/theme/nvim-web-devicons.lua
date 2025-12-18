return {
	{
		"nvim-tree/nvim-web-devicons",
		dependencies = { "FotiadisM/nvim-material-icon" },
		config = function()
			require("nvim-web-devicons").setup({
				override = require("nvim-material-devicons").get_icons(),
			})
		end,
	},
	{
		"FotiadisM/nvim-material-icon",
		dev = true,
	},
}
