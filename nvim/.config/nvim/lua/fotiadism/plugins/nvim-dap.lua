return {
	{
		"mfussenegger/nvim-dap",
		dependencies = { "theHamsta/nvim-dap-virtual-text", "leoluz/nvim-dap-go" },
		config = function()
			require("dap")
			vim.fn.sign_define("DapBreakpoint", { text = "🛑", texthl = "DiagnosticError" })

			require("nvim-dap-virtual-text").setup()
			require("dap-go").setup()
		end,
	},
	{
		"rcarriga/nvim-dap-ui",
		dependencies = { "mfussenegger/nvim-dap", "nvim-neotest/nvim-nio" },
		config = function()
			require("dapui").setup()
		end,
	},
}
