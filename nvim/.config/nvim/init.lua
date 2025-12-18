local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not (vim.uv or vim.loop).fs_stat(lazypath) then
	local lazyrepo = "https://github.com/folke/lazy.nvim.git"
	local out = vim.fn.system({ "git", "clone", "--filter=blob:none", "--branch=stable", lazyrepo, lazypath })
	if vim.v.shell_error ~= 0 then
		vim.api.nvim_echo({
			{ "Failed to clone lazy.nvim:\n", "ErrorMsg" },
			{ out, "WarningMsg" },
			{ "\nPress any key to exit..." },
		}, true, {})
		vim.fn.getchar()
		os.exit(1)
	end
end
vim.opt.rtp:prepend(lazypath)

require("lazy").setup({
	spec = {
		{ import = "fotiadism/plugins" },
	},
	defaults = {
		lazy = true,
		version = "*",
	},
	dev = {
		path = "~/src/neovim",
	},
	install = { colorscheme = { "tokyonight" } },
	change_detection = {
		notify = false,
	},
	performance = {
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
	},
})

vim.cmd.colorscheme("tokyonight-night")

-- if nvim starts with a directory as an argument, cd into it
if vim.fn.argc() == 1 then
	local arg = vim.fn.argv()[1]
	if vim.fn.isdirectory(arg) == 1 then
		vim.fn.chdir(arg)
	end
end
