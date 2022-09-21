require("nvim-tree").setup({
	disable_netrw = false,
	hijack_netrw = false,
	open_on_setup = false,
	open_on_tab = false,
	hijack_cursor = true,
	update_cwd = true,
	view = {
		adaptive_size = true,
		mappings = {
			list = {
				{ key = "l", action = "edit" },
				{ key = "h", action = "close_node" },
				{ key = "v", action = "vsplit" },
				{ key = "x", action = "split" },
				{ key = "]c", action = "cd" },
				{ key = "[c", action = "dir_up" },
			},
		},
	},
	renderer = {
		root_folder_modifier = ":t",
		indent_markers = {
			enable = true,
		},
		icons = {
			glyphs = {
				git = {
					unstaged = "●",
					staged = "●",
					unmerged = "",
					renamed = "●",
					untracked = "●",
					deleted = "●",
					ignored = "●",
				},
			},
		},
		special_files = {},
	},
	diagnostics = {
		enable = true,
		show_on_dirs = true,
	},
	filesystem_watchers = {
		enable = true,
	},
	git = {
		ignore = false,
	},
	actions = {
		open_file = {
			resize_window = false,
		},
	},
})

-- quit nvim if the only window is NvimTree
vim.cmd([[autocmd BufEnter * ++nested if winnr('$') == 1 && bufname() == 'NvimTree_' . tabpagenr() | quit | endif]])

vim.api.nvim_set_hl(0, "NvimTreeIndentMarker", { fg = "#0db9d7" })
vim.api.nvim_set_hl(0, "NvimTreeFolderIcon", { fg = "#0db9d7" })

vim.api.nvim_set_hl(0, "NvimTreeGitDirty", { fg = "#fd7f20" })
vim.api.nvim_set_hl(0, "NvimTreeGitStaged", { fg = "#1abc9c" })
vim.api.nvim_set_hl(0, "NvimTreeGitRenamed", { fg = "#800080" })
vim.api.nvim_set_hl(0, "NvimTreeGitDeleted", { fg = "#db4b4b" })
