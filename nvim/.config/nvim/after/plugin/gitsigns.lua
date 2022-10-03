require("gitsigns").setup({
	watch_gitdir = {
		interval = 100,
	},
	on_attach = function(bufnr)
		local gs = package.loaded.gitsigns

		local function map(mode, l, r, opts, desc)
			opts = opts or {}
			opts.buffer = bufnr
			opts.desc = desc
			vim.keymap.set(mode, l, r, opts)
		end

		-- Navigation
		map("n", "]c", function()
			if vim.wo.diff then
				return "]c"
			end
			vim.schedule(function()
				gs.next_hunk()
			end)
			return "<Ignore>"
		end, { expr = true }, "next git change")

		map("n", "[c", function()
			if vim.wo.diff then
				return "[c"
			end
			vim.schedule(function()
				gs.prev_hunk()
			end)
			return "<Ignore>"
		end, { expr = true }, "prev git change")

		-- Actions
		map({ "n", "v" }, "<leader>hs", gs.stage_hunk, {}, "stage hunk")
		map({ "n", "v" }, "<leader>hr", gs.reset_hunk, {}, "reset hunk")
		map("n", "<leader>hS", gs.stage_buffer, {}, "stage buffer")
		map("n", "<leader>hu", gs.undo_stage_hunk, {}, "undo stage hunk")
		map("n", "<leader>hp", gs.preview_hunk, {}, "preview hunk")
		map("n", "<leader>hb", function()
			gs.blame_line({ full = true })
		end, {}, "blame line")
		map("n", "<leader>hd", gs.diffthis, {}, "diff this")

		map("n", "<leader>tb", gs.toggle_current_line_blame, {}, "toggle blame")
		map("n", "<leader>td", gs.toggle_deleted, {}, "toggle deleted")

		-- Text object
		map({ "o", "x" }, "ih", ":<C-U>Gitsigns select_hunk<CR>")
	end,
})
