local M = {}

function M.setup(on_attach)
	local nl = require("null-ls")

	local sources = {
		-- null_ls.builtins.formatting.prettier,
		nl.builtins.formatting.prettierd, -- faster than prettier, doesn't support range formatting
		nl.builtins.formatting.goimports,
		nl.builtins.formatting.gofumpt,
		nl.builtins.formatting.stylua,

		nl.builtins.diagnostics.golangci_lint.with({
			args = { "run", "--fix=false", "--out-format=json", "$DIRNAME", "--path-prefix", "$ROOT" },
		}),
	}

	nl.setup({
		sources = sources,
		on_attach = on_attach,
	})
end

return M
