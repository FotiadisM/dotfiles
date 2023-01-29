return {
	"FotiadisM/tabset.nvim",
	event = "BufReadPre",
	config = function()
		require("tabset").setup({
			defaults = {
				tabwidth = 4,
				expandtab = false,
			},
			languages = {
				go = {
					expandtab = false,
				},
				{
					filetypes = { "yaml", "terraform", "helm", "proto" },
					config = {
						tabwidth = 2,
						expandtab = true,
					},
				},
				{
					filetypes = {
						"javascript",
						"typescript",
						"javascriptreact",
						"typescriptreact",
						"json",
						"vue",
						"html",
					},
					config = {
						tabwidth = 2,
					},
				},
			},
		})
	end,
}
