local go = {}

function go.setup(config, on_attach)
	config.on_attach = function(client, bufnr)
		client.server_capabilities.documentFormattingProvider = false
		on_attach(client, bufnr)
	end

	config.settings = {
		gopls = {
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
				rangeVariableTypes = false,
			},
		},
	}

	return config
end

return go
