local latex = {}

function latex.setup(config, on_attach)
	config.on_attach = function(client, bufnr)
		client.server_capabilities.document_formatting = false
		on_attach(client, bufnr)
	end

	config.settings = {
		texlab = {
			diagnosticsDelay = 100,
			build = {
				onSave = true,
				args = {
					"-synctex=1",
					"-interaction=nonstopmode",
					"-file-line-error",
					"-pdf",
					"-outdir=build",
					"%f"
				},
			},
		}
	}

	return config
end

return latex

