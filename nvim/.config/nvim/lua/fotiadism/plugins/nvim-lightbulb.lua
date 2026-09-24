return {
	"kosayoda/nvim-lightbulb",
	enabled = false,
	event = "LspAttach",
	config = function()
		require("nvim-lightbulb").setup({
			autocmd = {
				enabled = true,
			},
		})
		vim.fn.sign_define("LightBulbSign", { texthl = "DiagnosticWarn" })
	end,
}
