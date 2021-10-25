require("tabset").setup({
	defaults = {
		tabwidth = 4,
		expandtab = false
	},
	languages = {
		go = {
			expandtab = false
		},
		{
			filetypes = { "javascript", "typescript", "javascriptreact", "typescriptreact", "json", "yaml", "vue", "html" },
			config = {
				tabwidth = 2
			}
		}
	}
})
