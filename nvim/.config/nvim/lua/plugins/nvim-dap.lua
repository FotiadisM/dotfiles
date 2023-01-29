return {
	"mfussenegger/nvim-dap",
	dependencies = {
		"rcarriga/nvim-dap-ui",
		"theHamsta/nvim-dap-virtual-text",
		"leoluz/nvim-dap-go",
	},
	config = function()
		require("dap")
		require("dapui").setup()
		require("nvim-dap-virtual-text").setup()

		require("dap-go").setup()

		vim.fn.sign_define("DapBreakpoint", { text = "🛑", texthl = "DiagnosticError" })
	end,
}
