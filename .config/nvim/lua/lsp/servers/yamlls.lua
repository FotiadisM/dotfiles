local yamlls = {}

function yamlls.setup(config, on_attach)
	config.settings = {
		yaml = {
			schemas = {
				-- TODO: add schemas for kubernetes
			},
		},
	}
	return config
end

return yamlls
