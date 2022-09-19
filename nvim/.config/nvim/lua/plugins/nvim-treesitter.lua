require("nvim-treesitter.configs").setup({
	ensure_installed = "all",
	highlight = {
		enable = true,
	},
	indent = {
		enable = false,
	},
	textobjects = {
		select = {
			enable = true,
			lookahead = true,
			keymaps = {
				["ab"] = "@block.outer",
				["ib"] = "@block.inner",
				["av"] = "@parameter.outer",
				["iv"] = "@parameter.inner",
				["af"] = "@function.outer",
				["if"] = "@function.inner",
				["al"] = "@loop.outer",
				["il"] = "@loop.inner",
				["ac"] = "@class.outer",
				["ic"] = "@class.inner",
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
	autopairs = { enable = true },
	autotag = { enable = true },
	context_commentstring = {
		enable = true,
		enable_autocmd = false,
	},
	playground = {
		enable = true,
	},
	query_linter = {
		enable = true,
	},
})
