local pyright = {}

function pyright.setup(config, _)
	config.settings = {
		python = {
			analysis = {
				autoSearchPaths = true,
				diagnosticMode = "workspace",
				useLibraryCodeForTypes = true,
			},
		},
	}

	return config
end

return pyright
