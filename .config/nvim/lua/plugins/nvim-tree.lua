local tree_cb = require("nvim-tree.config").nvim_tree_callback

vim.g.nvim_tree_special_files = {}

require("nvim-tree").setup({
	disable_netrw = false,
	hijack_netrw = false,
	open_on_setup = false,
	auto_close = true,
	open_on_tab = false,
	update_to_buf_dir  = {
		auto_open = false,
	},
	hijack_cursor = true,
	update_cwd = true,
	diagnostics = {
		enable = true,
	},
	filters = {
		custom = { ".git" }
	},
	view = {
		mappings = {
			list = {
				{ key = "l", cb = tree_cb("edit") },
				{ key = "h", cb = tree_cb("close_node") },
			}
		}
	}
})
