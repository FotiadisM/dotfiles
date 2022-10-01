local json = {}

function json.setup(config, on_attach)
	config.on_attach = function(client, bufnr)
		client.server_capabilities.document_formatting = false
		on_attach(client, bufnr)
	end
	config.settings = {
		json = {
			schemas = require("schemastore").json.schemas(),
			validate = { enable = true },
		},
	}

	return config
end

return json
