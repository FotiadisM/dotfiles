local M = {}

function M.setup(on_attach)
	local nl = require("null-ls")

	local sources = {
		nl.builtins.code_actions.gomodifytags,
		nl.builtins.code_actions.impl,

		nl.builtins.formatting.prettierd,
		nl.builtins.formatting.goimports,
		nl.builtins.formatting.stylua,
		nl.builtins.formatting.buf,
		nl.builtins.formatting.isort,

		nl.builtins.diagnostics.golangci_lint,
		nl.builtins.diagnostics.buf,
	}

	nl.setup({
		sources = sources,
		on_attach = on_attach,
	})
end

return M
