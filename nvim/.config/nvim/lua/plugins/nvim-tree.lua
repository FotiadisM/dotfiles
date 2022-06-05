require("nvim-tree").setup({
	disable_netrw = false,
	hijack_netrw = false,
	open_on_setup = false,
	open_on_tab = false,
	update_to_buf_dir = {
		auto_open = false,
	},
	hijack_cursor = true,
	update_cwd = true,
	renderer = {
		special_files = {},
	},
	diagnostics = {
		enable = true,
	},
	filters = {
		custom = { ".git" },
	},
	git = {
		ignore = false,
	},
	view = {
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
})

vim.cmd([[autocmd BufEnter * ++nested if winnr('$') == 1 && bufname() == 'NvimTree_' . tabpagenr() | quit | endif]])
