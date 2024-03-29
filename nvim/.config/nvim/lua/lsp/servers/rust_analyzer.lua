local rust = {}

function rust.setup(config, on_attach)
	config.on_attach = function(client, bufnr)
		on_attach(client, bufnr)
	end

	return config
end

return rust
