-- Showing defaults
require("nvim-lightbulb").setup({
	autocmd = {
		enabled = true,
	},
})

vim.fn.sign_define("LightBulbSign", { texthl = "DiagnosticWarn" })
