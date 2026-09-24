return {
	{
		"nvim-treesitter/nvim-treesitter",
		branch = "main",
		lazy = false,
		build = ":TSUpdate",
		config = function()
			local treesitter = require("nvim-treesitter")
			treesitter.setup()
			treesitter.install("stable")

			vim.api.nvim_create_autocmd("FileType", {
				callback = function()
					-- vim.bo.indentexpr = "v:lua.require'nvim-treesitter'.indentexpr()"
					pcall(vim.treesitter.start)
				end,
			})

			-- Treesitter folding
			-- vim.wo.foldexpr = "v:lua.vim.treesitter.foldexpr()"

			vim.treesitter.language.register("starlark", "tiltfile")
		end,
	},
	{
		"nvim-treesitter/nvim-treesitter-context",
		event = "BufReadPre",
		config = true,
	},
}
