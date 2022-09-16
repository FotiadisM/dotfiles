local keymap = vim.keymap.set
local opts = { noremap = true, silent = true }

keymap("i", "jj", "<ESC>", { noremap = true })
keymap("v", "<space>", "<ESC>", { noremap = true })
keymap("i", "<C-s>", "<ESC>:w<CR>a", { noremap = true })
keymap("n", "<C-s>", ":w<CR>", { noremap = true })

keymap("n", "j", "gj", { noremap = true })
keymap("n", "k", "gk", { noremap = true })
keymap("v", "j", "gj", { noremap = true })
keymap("v", "k", "gk", { noremap = true })

-- close current buffer and jump to previous one
keymap("n", "<space>q", ":bp<bar>sp<bar>bn<bar>bd<CR>", opts)

-- don't 'copy' empty lines when 'dd'
keymap("n", "dd", function()
	local line_data = vim.api.nvim_win_get_cursor(0) -- returns {row, col}
	local current_line = vim.api.nvim_buf_get_lines(0, line_data[1] - 1, line_data[1], false)
	if current_line[1] == "" then
		return '"_dd'
	else
		return "dd"
	end
end, { noremap = true, expr = true })

-- copy to clipboard
keymap("", "<C-c>", '"+y', opts)

-- easily source files
keymap("n", "<leader>l", ":so%<CR>", {})

-- moving between windows
keymap("n", "<C-h>", "<C-w>h", opts)
keymap("n", "<C-j>", "<C-w>j", opts)
keymap("n", "<C-k>", "<C-w>k", opts)
keymap("n", "<C-l>", "<C-w>l", opts)

-- resize windows
keymap("n", "<C-Up>", ":resize +1<CR>", opts)
keymap("n", "<C-Down>", ":resize -1<CR>", opts)
keymap("n", "<C-Left>", ":vertical resize +1<CR>", opts)
keymap("n", "<C-Right>", ":vertical resize -1<CR>", opts)

-- move lines quicly
keymap("n", "[e", ":<C-u>execute 'move -1-'. v:count1<CR>", opts)
keymap("v", "K", ":m '<-2<CR>gv=gv", opts)
keymap("n", "]e", ":<C-u>execute 'move +'. v:count1<CR>", opts)
keymap("v", "J", ":m '>+1<CR>gv=gv", opts)

-- quicly add empty lines
keymap("n", "[<space>", ":<C-u>put! =repeat(nr2char(10), v:count1)<CR>", opts)
keymap("n", "]<space>", ":<C-u>put =repeat(nr2char(10), v:count1)<CR>", opts)

-- remap C-a due to tmux
keymap("n", "<A-a>", "<C-a>", opts)
keymap("v", "<A-a>", "<C-a>gv", opts)
keymap("v", "g<A-a>", "g<C-a>gv", opts)
keymap("n", "<A-x>", "<C-x>", opts)
keymap("v", "<A-x>", "<C-x>gv", opts)
keymap("v", "g<A-x>", "g<C-x>gv", opts)

-- edit macros
keymap("n", "<leader>m", ":<C-u><C-r><C-r>='let @'. v:register .' = '. string(getreg(v:register))<CR><C-f><Left>", opts)

-- don't move cursor when concatenating lines
keymap("n", "J", "mzJ`z", opts)

-- don't lose selection when shifting
keymap("x", "<", "<gv", opts)
keymap("x", ">", ">gv", opts)

-- disable ex mode
keymap("n", "Q", "<nop>", opts)
keymap("n", "q:", "<nop>", opts)

-- toggle spelling
keymap("n", "<leader>s", ":set spell!<CR>", opts)

-- quickfix mappings
keymap("n", "<space>cc", function()
	local gf_open = false
	for _, win in pairs(vim.fn.getwininfo()) do
		if win["quickfix"] == 1 then
			gf_open = true
		end
	end

	if gf_open then
		vim.cmd([[cclose]])
		return
	end
	vim.cmd([[copen]])
end, opts)
keymap("n", "<space>cn", ":cnext<CR>", opts)
keymap("n", "<space>cp", ":cprev<CR>", opts)

-- nvim-tree
keymap("n", "<leader>b", ":NvimTreeToggle<CR>", opts)

-- luasnip
local ls = require("luasnip")
keymap({ "i", "s" }, "<C-k>", function()
	if ls.expand_or_jumpable() then
		ls.expand_or_jump()
	end
end, opts)
keymap({ "i", "s" }, "<C-j>", function()
	if ls.jumpable(-1) then
		ls.jump(-1)
	end
end, opts)
keymap({ "i", "s" }, "<C-l>", function()
	if ls.choice_active() then
		ls.change_choice(1)
	end
end, opts)

-- bufferline
keymap("n", "gb", ":BufferLinePick<CR>", opts)
keymap("n", "L", ":BufferLineCycleNext<CR>", opts)
keymap("n", "<space>l", ":BufferLineMoveNext<CR>", opts)
keymap("n", "H", ":BufferLineCyclePrev<CR>", opts)
keymap("n", "<space>h", ":BufferLineMovePrev<CR>", opts)

-- telescope
keymap("n", "gt", require("telescope.builtin").builtin, opts)
keymap("n", "gf", function()
	require("telescope.builtin").find_files({ hidden = true })
end, opts)
keymap("n", "gh", require("telescope.builtin").help_tags, opts)
keymap("n", "<leader>fg", require("telescope.builtin").live_grep, opts)
keymap("n", "<leader>fb", require("telescope.builtin").buffers, opts)
keymap("n", "<leader>fh", require("telescope.builtin").help_tags, opts)
keymap("n", "<leader>fp", require("telescope").extensions.packer.packer, opts)
keymap("n", "<leader>fgb", require("telescope.builtin").git_branches, opts)
keymap("n", "<leader>fgc", require("telescope.builtin").git_commits, opts)

-- debugging
keymap("n", "<leader>dc", require("dap").continue, opts)
keymap("n", "<leader>dt", require("dap").terminate, opts)
keymap("n", "<leader>dq", require("dap").repl.close, opts)
keymap("n", "<F10>", require("dap").step_over, opts)
keymap("n", "<F11>", require("dap").step_into, opts)
keymap("n", "<F12>", require("dap").step_out, opts)
keymap("n", "<leader>du", require("dapui").toggle, opts)
keymap("n", "<leader>db", require("dap").toggle_breakpoint, opts)

-- refactoring
keymap({ "n", "v" }, "<leader>r", require("refactoring").select_refactor, opts)

-- nvim-spectre
keymap("n", "<leader>S", require("spectre").open, opts)

-- spread.nvim
keymap("n", "gS", require("spread").out, opts)
keymap("n", "gJ", require("spread").combine, opts)
