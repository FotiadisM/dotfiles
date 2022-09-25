-- using pcal to avoid errors on initial run
pcall(require, "impatient")

require("pluginsList")

-- if nvim starts with a directory as an argument, cd into it
vim.cmd([[
	autocmd VimEnter * if argc() == 1 && isdirectory(argv()[0]) | execute 'cd '.argv()[0] | wincmd l | endif
]])
