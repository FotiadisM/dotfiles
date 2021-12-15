local yamlls = {}

function yamlls.setup(config, _)
	config.settings = {
		yaml = {
			schemas = {
				["https://json.schemastore.org/github-workflow.json"] = "/.github/workflows/*",
				["https://raw.githubusercontent.com/compose-spec/compose-spec/master/schema/compose-spec.json"] = "docker-compose.ya?ml",
				["https://json.schemastore.org/prettierrc.json"] = ".prettierrc.ya?ml",
				["https://json.schemastore.org/eslintrc.json"] = ".eslintrc.ya?ml",
			},
		},
	}
	return config
end

return yamlls
