local M = {}

function M.setup(on_attach)
	local nl = require("null-ls")

	local sources = {
		-- null_ls.builtins.formatting.prettier,
		nl.builtins.formatting.prettierd, -- faster than prettier, doesn't support range formatting
		nl.builtins.formatting.gofumpt,
		nl.builtins.formatting.rustfmt,
		nl.builtins.formatting.stylua,

		-- nl.builtins.diagnostics.yamllint,
	}

	nl.setup({
		sources = sources,
		on_attach = on_attach,
	})
end

return M

