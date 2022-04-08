local keymap = vim.api.nvim_set_keymap
local opts = { noremap = true, silent = true }

keymap("i", "jj", "<ESC>", { noremap = true })
keymap("v", "<space>", "<ESC>", { noremap = true })
keymap("i", "<C-s>", "<ESC>:w<CR>a", { noremap = true })
keymap("n", "<C-s>", ":w<CR>", { noremap = true })

-- close current buffer and jump to previous one
keymap("n", "<leader>q", ":bp<bar>sp<bar>bn<bar>bd<CR>", opts)

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
keymap("n", "<C-Up>", ":resize +3<CR>", opts)
keymap("n", "<C-Down>", ":resize -3<CR>", opts)
keymap("n", "<C-Left>", ":vertical resize +3<CR>", opts)
keymap("n", "<C-Right>", ":vertical resize -3<CR>", opts)

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

-- quickfix list mappings
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
keymap("n", "<leader>cc", ":lua Mappings.toggle_qf()<CR>", opts)
keymap("n", "<leader>cc", "<ESC>:lua Mappings.toggle_qf()<CR>a", opts)
keymap("n", "<leader>cn", ":cnext<CR>", opts)
keymap("n", "<leader>cp", ":cprev<CR>", opts)
keymap("n", "<leader>cl", ":lua vim.diagnostic.setqflist()<CR>", opts)

-- nvim-tree
keymap("n", "<leader>b", ":NvimTreeToggle<CR>", opts)

-- yanil
-- keymap("n", "<leader>b", ":lua require('yanil.canvas').toggle()<CR>", opts)

-- luasnip
local ls = require("luasnip")
vim.keymap.set({ "i", "s" }, "<C-k>", function()
	if ls.expand_or_jumpable() then
		ls.expand_or_jump()
	end
end, opts)
vim.keymap.set({ "i", "s" }, "<C-j>", function()
	if ls.jumpable(-1) then
		ls.jump(-1)
	end
end, opts)
vim.keymap.set({ "i", "s" }, "<C-l>", function()
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
keymap("n", "gf", ":lua require('telescope.builtin').find_files({ hidden = true })<CR>", opts)
keymap("n", "<leader>ff", ":lua require('telescope.builtin').find_files({ hidden = true })<CR>", opts)
keymap("n", "<leader>fg", ":lua require('telescope.builtin').live_grep()<CR>", opts)
keymap("n", "<leader>fb", ":lua require('telescope.builtin').buffers()<CR>", opts)
keymap("n", "<leader>fh", ":lua require('telescope.builtin').help_tags()<CR>", opts)
keymap("n", "<leader>fp", ":lua require('telescope').extensions.packer.packer()<CR>", opts)
keymap("n", "<leader>fn", ":lua require('telescope').extensions.neoclip.default()<CR>", opts)
keymap("n", "<leader>fgb", ":lua require('telescope.builtin').git_branches()<CR>", opts)
keymap("n", "<leader>fgc", ":lua require('telescope.builtin').git_commits()<CR>", opts)

-- debugging
keymap("n", "<leader>dc", ":lua require('dap').continue()<CR>", opts)
keymap("n", "<leader>dt", ":lua require('dap').terminate()<CR>", opts)
keymap("n", "<leader>dq", ":lua require('dap').repl.close()<CR>", opts)
keymap("n", "<F10>", ":lua require('dap').step_over()<CR>", opts)
keymap("n", "<F11>", ":lua require('dap').step_into()<CR>", opts)
keymap("n", "<F12>", ":lua require('dap').step_out()<CR>", opts)
keymap("n", "<leader>du", ":lua require('dapui').toggle()<CR>", opts)
keymap("n", "<leader>db", ":lua require('dap').toggle_breakpoint()<CR>", opts)

-- nvim-toggleterm
keymap("n", "<leader>t", ":ToggleTerm<CR>", opts)
keymap("n", "<leader>T", ":ToggleTerm direction='float'<CR>", opts)

-- refactoring
keymap("v", "<leader>r", "<Esc>:lua M.refactors()<CR>", opts)

-- nvim-spectre
keymap("n", "<leader>S", ":lua require('spectre').open()<CR>", opts)
