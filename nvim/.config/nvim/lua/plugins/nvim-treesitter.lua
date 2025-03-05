return {
	{ "nvim-treesitter/playground", cmd = "TSPlaygroundToggle" },
	{
		"nvim-treesitter/nvim-treesitter-context",
		event = "BufReadPre",
		config = true,
	},
	{
		"nvim-treesitter/nvim-treesitter-textobjects",
		event = "BufReadPre",
	},
	{
		"nvim-treesitter/nvim-treesitter",
		build = ":TSUpdate",
		config = function()
			require("nvim-treesitter.configs").setup({
				ensure_installed = "all",
				highlight = {
					enable = true,
				},
				indent = {
					enable = false,
				},
				incremental_selection = {
					enable = true,
				},
				textobjects = {
					select = {
						enable = true,
						lookahead = true,
						keymaps = {
							["ab"] = "@block.outer",
							["ib"] = "@block.inner",
							["ac"] = "@call.outer",
							["ic"] = "@call.inner",
							["ao"] = "@class.outer",
							["io"] = "@class.inner",
							["ad"] = "@conditional.outer",
							["id"] = "@conditional.inner",
							["af"] = "@function.outer",
							["if"] = "@function.inner",
							["al"] = "@loop.outer",
							["il"] = "@loop.inner",
						},
					},
					move = {
						enable = true,
						set_jumps = true,
						goto_next_start = {
							["]f"] = "@function.outer",
						},
						goto_next_end = {
							["]F"] = "@function.outer",
						},
						goto_previous_start = {
							["[f"] = "@function.outer",
						},
						goto_previous_end = {
							["[F"] = "@function.outer",
						},
					},
					swap = {
						enable = true,
						swap_next = {
							["<leader>a"] = "@parameter.inner",
						},
						swap_previous = {
							["<leader>A"] = "@parameter.inner",
						},
					},
				},
				playground = {
					enable = true,
				},
				query_linter = {
					enable = true,
				},
				autotag = { enable = true },
			})

			vim.treesitter.language.register("starlark", "tiltfile")
		end,
	},
}
