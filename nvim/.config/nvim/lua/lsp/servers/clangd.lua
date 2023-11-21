local clangd = {}

function clangd.setup(config, _)
	config.cmd = { "clangd", "--enable-config" }
	config.filetypes = { "c", "cpp", "objc", "objcpp", "cuda" }

	return config
end

return clangd
