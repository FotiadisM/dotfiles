return {
	"nvim-tree/nvim-tree.lua",
	dependencies = { "nvim-tree/nvim-web-devicons" },
	config = function()
		require("nvim-tree").setup({
			-- hijack_unnamed_buffer_when_opening = true,
			sync_root_with_cwd = true,
			reload_on_bufenter = true,
			-- on_attach = "disable",
			select_prompts = true,
			view = {
				cursorline = true,
				adaptive_size = true,
				preserve_window_proportions = true,
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
				show_on_open_dirs = false,
			},
			filters = {
				custom = { "^.git$" },
			},
			git = {
				ignore = false,
				show_on_dirs = true,
				show_on_open_dirs = false,
			},
			on_attach = function(bufnr)
				local api = require("nvim-tree.api")

				local function opts(desc)
					return { desc = "nvim-tree: " .. desc, buffer = bufnr, noremap = true, silent = true, nowait = true }
				end

				-- default mappings
				api.config.mappings.default_on_attach(bufnr)

				vim.keymap.set("n", "l", api.node.open.edit, opts("Open"))
				vim.keymap.set("n", "h", api.node.navigate.parent_close, opts("Close Directory"))
				vim.keymap.set("n", "L", api.node.open.vertical, opts("Open: Vertical Split"))
				vim.keymap.set("n", "s", api.node.open.horizontal, opts("Open: Horizontal Split"))
			end,
		})

		require("nvim-tree.view").View.winopts.foldcolumn = "1"
	end,
}
