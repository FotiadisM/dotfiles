local html = {}

function html.setup(config, on_attach)
	config.on_attach = function(client, bufnr)
		client.server_capabilities.documentFormattingProvider = false
		on_attach(client, bufnr)
	end

	return config
end

return html
