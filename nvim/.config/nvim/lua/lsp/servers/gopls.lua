local go = {}

function go.setup(config, _)
	config.settings = {
		gopls = {
			-- ["local"] = "github.com/FotiadisM/mock-microservice",
			gofumpt = true,
			semanticTokens = true,
			usePlaceholders = false,
			codelenses = {
				gc_details = true,
				generate = true,
				test = true,
				tidy = true,
				upgrade_dependency = true,
			},
			analyses = {
				shadow = true,
				useany = true,
			},
			hints = {
				assignVariableTypes = false,
				compositeLiteralFields = false,
				compositeLiteralTypes = false,
				constantValues = false,
				functionTypeParameters = false,
				parameterNames = false,
				rangeVariableTypes = true,
			},
		},
	}

	if vim.fn.executable("go") ~= 1 then
		return config
	end

	local module = vim.fn.trim(vim.fn.system("go list -m"))
	if vim.v.shell_error ~= 0 then
		return config
	end

	module = module:gsub("\n", ",")
	config.settings.gopls["local"] = module

	return config
end

return go
