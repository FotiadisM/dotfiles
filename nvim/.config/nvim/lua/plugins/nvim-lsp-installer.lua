require("nvim-lsp-installer").setup({
	automatic_installation = {
		exclude = {
			"gopls",
			"clangd",
			"texlab",
		},
	},
})
