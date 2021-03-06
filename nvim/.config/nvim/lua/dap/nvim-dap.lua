local dap = require("dap")

dap.defaults.fallback.force_external_terminal = true
dap.defaults.fallback.external_terminal = {
	command = "alacritty",
	args = { "-e" },
}

dap.adapters.go = require("dap.languages.go").adapter
dap.configurations.go = require("dap.languages.go").configuration

vim.fn.sign_define("DapBreakpoint", { text = "🛑", texthl = "DiagnosticError" })
