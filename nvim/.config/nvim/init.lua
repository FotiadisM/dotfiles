-- install lazy.nvim
local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not vim.loop.fs_stat(lazypath) then
	vim.fn.system({
		"git",
		"clone",
		"--filter=blob:none",
		"https://github.com/folke/lazy.nvim.git",
		"--branch=stable",
		lazypath,
	})
end
vim.opt.rtp:prepend(lazypath)

require("lazy").setup("plugins", {
	defaults = {
		lazy = true,
	},
	dev = {
		path = "~/src/neovim",
	},
	install = { colorscheme = { "tokyonight" } },
	rtp = {
		disabled_plugins = {
			"gzip",
			"matchit",
			"matchparen",
			"netrwPlugin",
			"tarPlugin",
			"tohtml",
			"tutor",
			"zipPlugin",
		},
	},
})

vim.cmd.colorscheme("gruvbox")

-- if nvim starts with a directory as an argument, cd into it
if vim.fn.argc() == 1 then
	local arg = vim.fn.argv()[1]
	if vim.fn.isdirectory(arg) == 1 then
		vim.fn.chdir(arg)
	end
end
