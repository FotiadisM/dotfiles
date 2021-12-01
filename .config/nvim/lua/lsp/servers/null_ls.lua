local null_ls = require("null-ls")

print("inside")

local sources = {
	null_ls.builtins.formatting.prettier,
	null_ls.builtins.formatting.gofumpt,
	null_ls.builtins.formatting.rustfmt,
	null_ls.builtins.formatting.stylua,

	null_ls.builtins.diagnostics.yamllint,
}

null_ls.config({ sources = sources })

M = {}
M.setup = function(config)
	config.root_dir = require("lspconfig").util.root_pattern("init.lua", "package.lock", "go.mod", ".git")
	return config
end

return M
