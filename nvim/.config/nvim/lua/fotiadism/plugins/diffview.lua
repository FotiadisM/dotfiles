return {
	"sindrets/diffview.nvim",
	cmd = { "DiffviewOpen", "DiffviewFileHistory" },
	config = function()
		local actions = require("diffview.actions")
		require("diffview").setup({
			keymaps = {
				view = {
					{
						"n",
						"<C-n>",
						actions.select_next_entry,
						{ desc = "Open the diff for the next file" },
					},
					{
						"n",
						"<C-p>",
						actions.select_prev_entry,
						{ desc = "Open the diff for the previous file" },
					},
					{
						"n",
						"<tab>",
						nil,
					},
					{
						"n",
						"<S-tab>",
						nil,
					},
				},
				file_panel = {
					{
						"n",
						"<C-n>",
						actions.select_next_entry,
						{ desc = "Open the diff for the next file" },
					},
					{
						"n",
						"<C-p>",
						actions.select_prev_entry,
						{ desc = "Open the diff for the previous file" },
					},
					{
						"n",
						"<tab>",
						nil,
					},
					{
						"n",
						"<S-tab>",
						nil,
					},
				},
				file_history_panel = {
					{
						"n",
						"<C-n>",
						actions.select_next_entry,
						{ desc = "Open the diff for the next file" },
					},
					{
						"n",
						"<C-p>",
						actions.select_prev_entry,
						{ desc = "Open the diff for the previous file" },
					},
					{
						"n",
						"<tab>",
						nil,
					},
					{
						"n",
						"<S-tab>",
						nil,
					},
				},
			},
		})
	end,
}
