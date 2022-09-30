local map = function(m, l, r, desc, opts)
	opts = opts or { noremap = true, silent = true }
	desc = desc or ""
	opts.desc = desc
	vim.keymap.set(m, l, r, opts)
end

map("i", "jj", "<ESC>", { noremap = true })
map("v", "<space>", "<ESC>", { noremap = true })
map("i", "<C-s>", "<ESC>:w<CR>a", { noremap = true })
map("n", "<C-s>", ":w<CR>", { noremap = true })

map("n", "j", "gj", { noremap = true })
map("n", "k", "gk", { noremap = true })
map("v", "j", "gj", { noremap = true })
map("v", "k", "gk", { noremap = true })

-- close current buffer and jump to previous one
map("n", "<space>q", ":bp<bar>sp<bar>bn<bar>bd<CR>")

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
map("n", "<leader>b", function()
	require("nvim-tree").toggle()
end, "toggle NvimTree")

-- luasnip
local ls = require("luasnip")
map({ "i", "s" }, "<C-k>", function()
	if ls.expand_or_jumpable() then
		ls.expand_or_jump()
	end
end)
map({ "i", "s" }, "<C-j>", function()
	if ls.jumpable(-1) then
		ls.jump(-1)
	end
end)
map({ "i", "s" }, "<C-l>", function()
	if ls.choice_active() then
		ls.change_choice(1)
	end
end)

-- bufferline
map("n", "gb", ":BufferLinePick<CR>")
map("n", "L", ":BufferLineCycleNext<CR>")
map("n", "<space>l", ":BufferLineMoveNext<CR>")
map("n", "H", ":BufferLineCyclePrev<CR>")
map("n", "<space>h", ":BufferLineMovePrev<CR>")

-- telescope
map("n", "gt", function()
	require("telescope.builtin").builtin()
end, "Telescope builtin")
map("n", "gh", function()
	require("telescope.builtin").help_tags()
end, "help_tags")
map("n", "gf", function()
	require("telescope.builtin").find_files({
		follow = true,
		hidden = true,
		no_ignore = true,
		no_ignore_parent = true,
	})
end, "find_files")
map("n", "<leader>fb", function()
	require("telescope.builtin").live_grep()
end, "live_grep")
map("n", "<leader>fh", function()
	require("telescope.builtin").find_files({ cwd = "~/.config/nvim", follow = true, hidden = true })
end, "nvim config")
map("n", "<leader>fp", function()
	require("telescope").extensions.packer.packer()
end, "packer")
map("n", "<leader>fgb", function()
	require("telescope.builtin").git_branches()
end, "git_branches")
map("n", "<leader>fgc", function()
	require("telescope.builtin").git_commits()
end, "git_commits")

-- debugging
map("n", "<leader>dc", function()
	require("dap").continue()
end, "continue")
map("n", "<leader>dt", function()
	require("dap").terminate()
end, "terminate")
map("n", "<leader>dq", function()
	require("dap").repl.close()
end, "repl.close")
map("n", "<F10>", function()
	require("dap").step_over()
end, "step_over")
map("n", "<F11>", function()
	require("dap").step_into()
end, "step_into")
map("n", "<F12>", function()
	require("dap").step_out()
end, "step_out")
map("n", "<leader>db", function()
	require("dap").toggle_breakpoint()
end, "toggle_breakpoint")
map("n", "<leader>du", function()
	require("dapui").toggle()
end, "toggle dapui")

-- refactoring
map({ "n", "v" }, "<leader>r", function()
	require("refactoring").select_refactor()
end, "refactoring")

-- nvim-spectre
map("n", "<leader>S", function()
	require("spectre").open()
end, "toggle spectre")

-- spread.nvim
map("n", "gS", function()
	require("spread").out()
end, "spread out")

map("n", "gJ", function()
	require("spread").combine()
end, "spread combine")
