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
					filetypes = { "python" },
					config = {
						tabwidth = 4,
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
						"d2",
					},
					config = {
						tabwidth = 2,
						expandtab = true,
					},
				},
			},
		})
	end,
}
