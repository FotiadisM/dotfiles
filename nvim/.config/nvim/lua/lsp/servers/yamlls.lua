local yamlls = {}

function yamlls.setup(config, _)
	config.settings = {
		redhat = { telemetry = { enabled = false } },
		yaml = {
			format = { enable = false },
			validate = true,
			hover = true,
			schemaStore = { enable = false },
			schemas = require("schemastore").yaml.schemas(),
		},
	}
	return require("yaml-companion").setup({
		lspconfig = config,
	})
end

return yamlls
