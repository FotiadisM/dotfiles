local go = {}

function go.setup(config, _)
	config.settings = {
		gopls = {
			gofumpt = true,
			codelenses = {
				gc_details = true,
				generate = true,
				test = true,
				tidy = true,
				upgrade_dependency = true,
			},
			usePlaceholders = true,
			analyses = {
				fieldalignment = false,
				nilness = true,
				shadow = true,
				unusedparams = false,
				unusedwrite = true,
				useany = true,
				unusedvariable = true,
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

	return config
end

return go
