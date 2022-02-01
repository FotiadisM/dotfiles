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
})

local pc = require("nvim-treesitter.parsers").get_parser_configs()

pc.http = {
	install_info = {
		url = "https://github.com/NTBBloodbath/tree-sitter-http",
		files = { "src/parser.c" },
		branch = "main",
	},
}

pc.gotmpl = {
	install_info = {
		url = "https://github.com/ngalaiko/tree-sitter-go-template",
		files = { "src/parser.c" },
	},
	filetype = "gotmpl",
	-- used_by = { "gohtmltmpl", "gotexttmpl", "gotmpl", "yaml" },
	used_by = { "gohtmltmpl", "gotexttmpl", "gotmpl" },
}
