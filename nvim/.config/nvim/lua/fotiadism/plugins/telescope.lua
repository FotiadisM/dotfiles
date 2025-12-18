return {
	"nvim-telescope/telescope.nvim",
	dependencies = {
		"nvim-lua/plenary.nvim",
		{
			"nvim-telescope/telescope-fzf-native.nvim",
			build = "make",
		},
	},
	config = function()
		local telescope = require("telescope")
		telescope.setup({
			defaults = {
				file_ignore_patterns = {
					".git/",
					"node_modules/",
					"vendor/",
					".terraform/",
					".yarn/",
					".next/",
					".venv",
					"__pycache__/",
					".mypy_cache/",
					".ruff_cache/",
					".devbox",
				},
			},
			extensions = {
				fzf = {
					fuzzy = true,
					override_generic_sorter = true,
					override_file_sorter = true,
				},
			},
		})

		telescope.load_extension("fzf")
	end,
}
