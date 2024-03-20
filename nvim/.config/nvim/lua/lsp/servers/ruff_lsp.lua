local ruff = {}

function ruff.setup(config, on_attach)
	config.on_attach = function(client, bufnr)
		client.server_capabilities.hoverProvider = false
		on_attach(client, bufnr)
	end

	return config
end

return ruff
