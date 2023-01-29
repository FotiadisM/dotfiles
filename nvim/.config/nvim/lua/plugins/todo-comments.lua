return {
	"folke/todo-comments.nvim",
	dependencies = "nvim-lua/plenary.nvim",
	cmd = "TodoQuickFix",
	event = "BufReadPre",
	config = function()
		require("todo-comments").setup({
			highlight = {
				keyword = "bg",
				pattern = [[.*<(KEYWORDS)(\([^\)]*\))?:]],
			},
			search = {
				pattern = [[\b(KEYWORDS)(\([^\)]*\))?:]],
			},
		})
	end,
}
