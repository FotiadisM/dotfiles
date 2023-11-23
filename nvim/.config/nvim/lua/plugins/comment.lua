return {
	"numToStr/Comment.nvim",
	event = "BufReadPre",
	dependencies = {
		{ "JoosepAlviste/nvim-ts-context-commentstring", dependencies = "nvim-treesitter/nvim-treesitter" },
	},
	config = function()
		vim.g.skip_ts_context_commentstring_module = true
		require("Comment").setup({
			ignore = "^$",
			pre_hook = require("ts_context_commentstring.integrations.comment_nvim").create_pre_hook(),
		})
	end,
}
