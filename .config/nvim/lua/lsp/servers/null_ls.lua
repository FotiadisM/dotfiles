local null_ls = require("null-ls")

print("inside")

local sources = {
	null_ls.builtins.formatting.prettier,
	null_ls.builtins.formatting.gofumpt,

	null_ls.builtins.code_actions.gitsigns
}

null_ls.config({ sources = sources })
