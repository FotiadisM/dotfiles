-- using pcal to avoid errors on initial run
pcall(require, "impatient")

require("pluginsList")

-- if nvim starts with a directory as an argument, cd into it
if vim.fn.argc() == 1 then
	local arg = vim.fn.argv()[1]
	if vim.fn.isdirectory(arg) then
		vim.fn.chdir(arg)
	end
end
