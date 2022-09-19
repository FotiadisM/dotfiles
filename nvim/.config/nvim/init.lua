-- using pcal to avoid errors on initial run
pcall(require, "impatient")

require("pluginsList")

require("mappings")

-- if nvim starts with a directory as an argument, cd into it
vim.cmd([[
	autocmd VimEnter * if argc() == 1 && isdirectory(argv()[0]) | execute 'cd '.argv()[0] | wincmd l | endif
]])

function P(v)
	print(vim.inspect(v))
end
