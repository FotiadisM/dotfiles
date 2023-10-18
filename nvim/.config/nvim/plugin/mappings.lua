local map = function(m, l, r, desc, opts)
	opts = opts or { noremap = true, silent = true }
	desc = desc or nil
	opts.desc = desc
	vim.keymap.set(m, l, r, opts)
end

map("i", "jj", "<ESC>")
map("v", "<space>", "<ESC>")
map({ "n", "i" }, "<C-s>", "<CMD>w<CR>")

map("n", "j", "gj")
map("n", "k", "gk")
map("v", "j", "gj")
map("v", "k", "gk")

-- close current buffer and jump to previous one
map("n", "<space>q", ":bp<bar>sp<bar>bn<bar>bd<CR>", "close buffer")

-- don't 'copy' empty lines when 'dd'
map("n", "dd", function()
	local line_data = vim.api.nvim_win_get_cursor(0) -- returns {row, col}
	local current_line = vim.api.nvim_buf_get_lines(0, line_data[1] - 1, line_data[1], false)
	if current_line[1] == "" then
		return '"_dd'
	else
		return "dd"
	end
end, "", { noremap = true, expr = true })

-- copy to clipboard
map("", "<C-c>", '"+y')

-- easily source files
map("n", "<leader>l", ":so%<CR>", "source buffer")

-- greatest remap ever
-- don't copy text when pasting in vidual mode
map("x", "p", '"_dP')

-- moving between windows
map("n", "<C-h>", "<C-w>h")
map("n", "<C-j>", "<C-w>j")
map("n", "<C-k>", "<C-w>k")
map("n", "<C-l>", "<C-w>l")

-- resize windows
map("n", "<C-Up>", ":resize +1<CR>")
map("n", "<C-Down>", ":resize -1<CR>")
map("n", "<C-Left>", ":vertical resize +1<CR>")
map("n", "<C-Right>", ":vertical resize -1<CR>")

-- move lines quicly
map("n", "[e", ":<C-u>execute 'move -1-'. v:count1<CR>")
map("v", "K", ":m '<-2<CR>gv=gv")
map("n", "]e", ":<C-u>execute 'move +'. v:count1<CR>")
map("v", "J", ":m '>+1<CR>gv=gv")

-- quicly add empty lines
map("n", "[<space>", ":<C-u>put! =repeat(nr2char(10), v:count1)<CR>")
map("n", "]<space>", ":<C-u>put =repeat(nr2char(10), v:count1)<CR>")

-- remap C-a due to tmux
map("n", "<A-a>", "<C-a>")
map("v", "<A-a>", "<C-a>gv")
map("v", "g<A-a>", "g<C-a>gv")
map("n", "<A-x>", "<C-x>")
map("v", "<A-x>", "<C-x>gv")
map("v", "g<A-x>", "g<C-x>gv")

-- edit macros
map("n", "<leader>m", ":<C-u><C-r><C-r>='let @'. v:register .' = '. string(getreg(v:register))<CR><C-f><Left>")

-- don't move cursor when concatenating lines
map("n", "J", "mzJ`z")

-- don't lose selection when shifting
map("x", "<", "<gv")
map("x", ">", ">gv")

-- disable ex mode
map("n", "Q", "<nop>")
map("n", "q:", "<nop>")

-- toggle spelling
map("n", "<leader>s", ":set spell!<CR>")

-- quickfix mappings
map("n", "<space>cc", function()
	for _, win in pairs(vim.fn.getwininfo()) do
		if win["quickfix"] == 1 then
			return ":cclose<CR>"
		end
	end
	return ":copen<CR>"
end, "toggle quickfix", { silent = true, expr = true })
map("n", "<space>cn", ":cnext<CR>", "cnext")
map("n", "<space>cp", ":cprev<CR>", "cprev")

-- nvim-tree
map("n", "<space>s", function()
	require("nvim-tree.api").tree.toggle()
end, "toggle NvimTree")
map("n", "<space>S", function()
	require("nvim-tree.api").tree.open({ find_file = true })
end, "toggle NvimTree")

-- luasnip
map({ "i", "s" }, "<C-k>", function()
	if require("luasnip").expand_or_jumpable() then
		require("luasnip").expand_or_jump()
	end
end)
map({ "i", "s" }, "<C-j>", function()
	if require("luasnip").jumpable(-1) then
		require("luasnip").jump(-1)
	end
end)
map({ "i", "s" }, "<C-l>", function()
	if require("luasnip").choice_active() then
		require("luasnip").change_choice(1)
	end
end)
map("n", "<space><space>e", function()
	require("luasnip.loaders").edit_snippet_files()
end, "edit snippets")
map("n", "<space><space>s", function()
	require("luasnip.extras.snippet_list").open()
end, "edit snippets")
map("n", "<space><space>r", function()
	require("luasnip.loaders.from_lua").load({
		paths = vim.fn.stdpath("config") .. "/lua/snippets",
	})
end, "refresh snippets")
-- stylua: ignore start

-- harpoon
map("n", "<space>h", function() require("harpoon.ui").toggle_quick_menu() end, "harpoon menu")
map("n", "<space>l", function() require("harpoon.mark").add_file() end, "harpoon menu")
map("n", "1", function () require("harpoon.ui").nav_file(1) end, "harpoon move to 1")
map("n", "2", function () require("harpoon.ui").nav_file(2) end, "harpoon move to 2")
map("n", "3", function () require("harpoon.ui").nav_file(3) end, "harpoon move to 3")
map("n", "4", function () require("harpoon.ui").nav_file(4) end, "harpoon move to 4")
map("n", "5", function () require("harpoon.ui").nav_file(5) end, "harpoon move to 5")

-- telescope
map("n", "gf", function()
	require("telescope.builtin").find_files({
		follow = true,
		hidden = true,
		no_ignore = true,
		no_ignore_parent = true,
	})
end, "find_files")
map("n", "<leader>fh", function() require("telescope.builtin").find_files({
	cwd = "~/.config/nvim",
	follow = true,
	hidden = true
}) end, "nvim config")
map("n", "gt", function() require("telescope.builtin").builtin() end, "telescope builtins")
map("n", "gh", function() require("telescope.builtin").help_tags() end, "help_tags")
map("n", "gb", function() require("telescope.builtin").buffers() end, "buffers")
map("n", "<leader>fg", function() require("telescope.builtin").live_grep() end, "live_grep")
map("n", "<leader>fd", function() require("telescope.builtin").diagnostics() end, "diagnostics")
map("n", "<space>gb", function() require("telescope.builtin").git_branches() end, "git branches")
map("n", "<space>gc", function() require("telescope.builtin").git_commits() end, "git commits")
map("n", "<space>gs", function() require("telescope.builtin").git_status() end, "git status")

-- debugging
map("n", "<leader>dc", function()
	require("dap").continue()
	require("dapui").open()
end, "dap continue")
map( "n", "<leader>dt", function()
	require("dap").terminate()
	require("dapui").close()
end, "dap terminate")
map("n", "<F10>", function() require("dap").step_over() end, "step_over")
map("n", "<F11>", function() require("dap").step_into() end, "step_into")
map("n", "<F12>", function() require("dap").step_out() end, "step_out")
map("n", "<leader>dr", function() require("dap").restart() end, "dap restart")
map("n", "<leader>db", function() require("dap").toggle_breakpoint() end, "dap toggle_breakpoint")
map("n", "<leader>du", function() require("dapui").toggle() end, "dap toggle dapui")

-- refactoring
map({ "n", "v" }, "<leader>r", function() require("refactoring").select_refactor() end, "refactoring")

-- nvim-spectre
map("n", "<leader>S", function() require("spectre").open() end, "toggle spectre")

-- spread.nvim
map("n", "gS", function() require("spread").out() end, "spread out")
map("n", "gJ", function() require("spread").combine() end, "spread combine")

-- nvim-ufo
map("n", "zR", function() require("ufo").openAllFolds() end, "open all folds")
map("n", "zM", function() require("ufo").closeAllFolds() end, "close all folds")

-- other.nvim
map("n", "<space>o", function() require("other").open() end, "open other file")
vim.keymap.set("n", "<space><space>o", require("other").clear, {
	noremap = true,
	silent = true,
	desc = "clear other file"
})

-- urlview.nvim
map("n", "<space>u", function ()
	require("urlview").search("lazy")
end, "open a plugin's github page")

-- nvim-navbuddy
map("n", "<space>n", function ()
	require("nvim-navbuddy").open()
end, "open navbuddy")
