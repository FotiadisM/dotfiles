local yamlls = {}

function yamlls.setup(config, _)
	return require("yaml-companion").setup({
		lspconfig = config,
	})
end

return yamlls
