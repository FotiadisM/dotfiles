local lua = {}

function lua.setup(config, on_attach)
	config.on_attach = function(client, bufnr)
		client.server_capabilities.documentFormattingProvider = false
		on_attach(client, bufnr)
	end

	return config
end

return lua
