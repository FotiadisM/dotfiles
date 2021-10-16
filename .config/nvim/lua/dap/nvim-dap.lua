local dap = require("dap")

dap.adapters.go = require("dap.languages.go").adapter
dap.configurations.go = require("dap.languages.go").configuration

vim.fn.sign_define("DapBreakpoint", {text='🛑', texthl='', linehl='', numhl=''})
