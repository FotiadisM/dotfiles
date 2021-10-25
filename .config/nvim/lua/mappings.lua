local keymap = vim.api.nvim_set_keymap
local opts = { noremap = true, silent = true }

keymap("i", "jj", "<ESC>", { noremap = true })
keymap("i", "<C-s>", "<ESC>:w<CR>a", { noremap = true })
keymap("n", "<C-s>", ":w<CR>", { noremap = true })

keymap("n", "Y", "y$", {})

-- close current buffer and jump to previous one
keymap("n", "<leader>q", ":bp<bar>sp<bar>bn<bar>bd<CR>", opts)

-- copy to clipboard
keymap("", "<C-c>", "\"+y", opts)

-- moving between windows
keymap("n", "<C-h>", "<C-w>h", opts)
keymap("n", "<C-j>", "<C-w>j", opts)
keymap("n", "<C-k>", "<C-w>k", opts)
keymap("n", "<C-l>", "<C-w>l", opts)

-- resize windows
keymap("n", "<C-Up>", ":resize +3<CR>", opts)
keymap("n", "<C-Down>", ":resize -3<CR>", opts)
keymap("n", "<C-Left>", ":vertical resize +3<CR>", opts)
keymap("n", "<C-Right>", ":vertical resize +3<CR>", opts)

-- move lines quicly
keymap("n", "[e", ":<C-u>execute 'move -1-'. v:count1<CR>", opts)
keymap("n", "]e", ":<C-u>execute 'move +'. v:count1<CR>", opts)

-- quicly add empty lines
keymap("n", "[<space>", ":<C-u>put! =repeat(nr2char(10), v:count1)<CR>", opts)
keymap("n", "]<space>", ":<C-u>put =repeat(nr2char(10), v:count1)<CR>", opts)

-- edit macros
keymap("n", "<leader>m", ":<C-u><C-r><C-r>='let @'. v:register .' = '. string(getreg(v:register))<CR><C-f><Left>", opts)

-- don't lose selection when shifting
keymap("x", "<", "<gv", opts)
keymap("x", ">", ">gv", opts)

-- disable ex mode
keymap("n", "Q", "<nop>", opts)
keymap("n", "q:", "<nop>", opts)

-- toggle spelling
keymap("n", "<leader>s", ":set spell!<CR>", opts)

Mappings = {}
Mappings.toggle_qf = function()
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
end
keymap("n", "<leader>c", ":lua Mappings.toggle_qf()<CR>", opts)

-- nvim-tree
keymap("n", "<leader>b", ":NvimTreeToggle<CR>", opts)

-- bufferline
keymap("n", "L", ":BufferLineCycleNext<CR>", opts)
keymap("n", "<space>l", ":BufferLineMoveNext<CR>", opts)
keymap("n", "H", ":BufferLineCyclePrev<CR>", opts)
keymap("n", "<space>h", ":BufferLineMovePrev<CR>", opts)

-- telescope
keymap("n", "<leader>ff", ":lua require('telescope.builtin').find_files()<CR>", opts)
keymap("n", "<leader>fg", ":lua require('telescope.builtin').live_grep()<CR>", opts)
keymap("n", "<leader>fb", ":lua require('telescope.builtin').buffers()<CR>", opts)
keymap("n", "<leader>fh", ":lua require('telescope.builtin').help_tags()<CR>", opts)
keymap("n", "<leader>fp", ":lua require('telescope').extensions.packer.plugins()<CR>", opts)
keymap("n", "<leader>fc", ":lua require('telescope').extensions.neoclip.default()<CR>", opts)
keymap("n", "<leader>fgb", ":lua require('telescope.builtin').git_branches()<CR>", opts)
keymap("n", "<leader>fgc", ":lua require('telescope.builtin').git_commits()<CR>", opts)

-- debugging
keymap("n", "<F5>", ":lua require('dap').continue()<CR>", opts)
keymap("n", "<F10>", ":lua require('dap').step_over()<CR>", opts)
keymap("n", "<F11>", ":lua require('dap').step_into()<CR>", opts)
keymap("n", "<F12>", ":lua require('dap').step_out()<CR>", opts)
keymap("n", "<leader>du", ":lua require('dapui').toggle()<CR>", opts)
keymap("n", "<leader>db", ":lua require('dap').toggle_breakpoint()<CR>", opts)

-- nvim-toggleterm
keymap("n", "<leader>t", ":ToggleTerm<CR>", opts)
keymap("n", "<leader>T", ":ToggleTerm direction='float'<CR>", opts)

-- refactoring
vim.api.nvim_set_keymap("v", "<leader>r", "<Esc>:lua M.refactors()<CR>", opts)
