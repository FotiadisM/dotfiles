local telescope = require("telescope")

telescope.setup({
	defaults = {
		file_ignore_patterns = { ".git", "node_modules" }
	},
	extensions = {
		fzf = {
			fuzzy = true,
			override_generic_sorter = true,
			override_file_sorter = true,
		}
	}
})

telescope.load_extension("fzf")
telescope.load_extension("packer")
telescope.load_extension("dap")
