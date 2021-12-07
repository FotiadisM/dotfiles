local yamlls = {}

function yamlls.setup(config, on_attach)
	config.settings = {
		yaml = {
			schemas = {
				["https://json.schemastore.org/github-workflow.json"] = "/.github/workflows/*",
				["https://raw.githubusercontent.com/compose-spec/compose-spec/master/schema/compose-spec.json"] = "docker-compose.y*",
			},
		},
	}
	return config
end

return yamlls
