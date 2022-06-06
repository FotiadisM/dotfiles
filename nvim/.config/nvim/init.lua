require("pluginsList")

require("theme")
require("options")
require("mappings")

-- if nvim starts with a directory as an argument, cd into it
vim.cmd([[
	autocmd VimEnter * if argc() == 1 && isdirectory(argv()[0]) | execute 'cd '.argv()[0] | wincmd l | endif
]])

function P(v)
	print(vim.inspect(v))
end

-- when treesitter folding is enabled, by default all folds are closed
-- when entering a file. this autocmd opens them
local gr = vim.api.nvim_create_augroup("open_folds", { clear = true })
vim.api.nvim_create_autocmd({ "BufEnter" }, {
	group = gr,
	pattern = "*",
	command = "normal zR",
})
