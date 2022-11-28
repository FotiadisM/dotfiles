local lua = {}

function lua.setup(config, on_attach)
	config.settings = {
		Lua = {
			runtime = {
				-- Tell the language server which version of Lua you're using (most likely LuaJIT in the case of Neovim)
				version = "LuaJIT",
			},
			diagnostics = {
				-- Get the language server to recognize the `vim` global
				globals = { "vim" },
				workspaceDelay = 1000,
			},
			workspace = {
				-- Make the server aware of Neovim runtime files
				library = vim.api.nvim_get_runtime_file("", true),
				checkThirdParty = false,
			},
			-- Do not send telemetry data containing a randomized but unique identifier
			telemetry = {
				enable = false,
			},
		},
	}

	config.on_attach = function(client, bufnr)
		client.server_capabilities.documentFormattingProvider = false
		on_attach(client, bufnr)
	end

	return config
end

return lua
