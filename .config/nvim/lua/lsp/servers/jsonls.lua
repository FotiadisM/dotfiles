local json = {}

function json.setup(config, on_attach)
	config.on_attach = function(client, bufnr)
		client.resolved_capabilities.document_formatting = false
		on_attach(client, bufnr)
	end
	config.settings = {
		json = {
			schemas = {
				{
					fileMatch = { "tsconfig.json" },
					url = "https://json.schemastore.org/tsconfig.json",
				},
			},
		},
	}

	return config
end

return json
