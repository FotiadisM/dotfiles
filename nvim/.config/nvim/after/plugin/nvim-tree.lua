require("nvim-tree").setup({
	-- hijack_unnamed_buffer_when_opening = true,
	sync_root_with_cwd = true,
	reload_on_bufenter = true,
	-- on_attach = "disable",
	select_prompts = true,
	view = {
		adaptive_size = true,
		preserve_window_proportions = true,
		mappings = {
			list = {
				{ key = "l", action = "edit" },
				{ key = "h", action = "close_node" },
				{ key = "L", action = "vsplit" },
				{ key = "s", action = "split" },
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
	git = {
		ignore = false,
	},
})

-- quit nvim if the only window is NvimTree
vim.api.nvim_create_autocmd("BufEnter", {
	group = vim.api.nvim_create_augroup("nvimtree_close", { clear = true }),
	pattern = "NvimTree_*",
	callback = function()
		local layout = vim.api.nvim_call_function("winlayout", {})
		if
			layout[1] == "leaf"
			and vim.api.nvim_buf_get_option(vim.api.nvim_win_get_buf(layout[2]), "filetype") == "NvimTree"
			and layout[3] == nil
		then
			vim.cmd("confirm quit")
		end
	end,
})

vim.api.nvim_set_hl(0, "NvimTreeIndentMarker", { fg = "#0db9d7" })
vim.api.nvim_set_hl(0, "NvimTreeFolderIcon", { fg = "#0db9d7" })

vim.api.nvim_set_hl(0, "NvimTreeGitDirty", { fg = "#fd7f20" })
vim.api.nvim_set_hl(0, "NvimTreeGitStaged", { fg = "#1abc9c" })
vim.api.nvim_set_hl(0, "NvimTreeGitRenamed", { fg = "#800080" })
vim.api.nvim_set_hl(0, "NvimTreeGitDeleted", { fg = "#db4b4b" })
