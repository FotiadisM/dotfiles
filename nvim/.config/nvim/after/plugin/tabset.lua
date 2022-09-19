require("tabset").setup({
	defaults = {
		tabwidth = 4,
		expandtab = false,
	},
	languages = {
		go = {
			expandtab = false,
		},
		yaml = {
			tabwidth = 2,
			expandtab = true,
		},
		{
			filetypes = { "terraform", "helm" },
			config = {
				tabwidth = 2,
				expandtab = true,
			},
		},
		{
			filetypes = { "javascript", "typescript", "javascriptreact", "typescriptreact", "json", "vue", "html" },
			config = {
				tabwidth = 2,
			},
		},
	},
})
