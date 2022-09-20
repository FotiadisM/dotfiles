local lspSignatureCfg = {
	hint_enable = false,
	handler_opts = {
		border = "single",
	},
	zindex = 50, -- signatureHelp behind completion items
}

local on_attach = function(client, bufnr)
	require("lsp_signature").on_attach(lspSignatureCfg)
	require("illuminate").on_attach(client)

	-- Mappings.
	local keymap = vim.keymap.set
	local opts = { buffer = bufnr, noremap = true, silent = true }
	keymap("n", "gD", vim.lsp.buf.declaration, opts)
	keymap("n", "gd", vim.lsp.buf.definition, opts)
	keymap("n", "K", vim.lsp.buf.hover, opts)
	keymap("n", "gi", vim.lsp.buf.implementation, opts)
	keymap("n", "<space>k", vim.lsp.buf.signature_help, opts)
	keymap("n", "<space>wa", vim.lsp.buf.add_workspace_folder, opts)
	keymap("n", "<space>wr", vim.lsp.buf.remove_workspace_folder, opts)
	keymap("n", "<space>wl", function()
		print(vim.inspect(vim.lsp.buf.list_workspace_folders()))
	end, opts)
	keymap("n", "<space>D", vim.lsp.buf.type_definition, opts)
	keymap("n", "<space>ca", vim.lsp.buf.code_action, opts)
	keymap("n", "<space>rn", vim.lsp.buf.rename, opts)
	keymap("n", "gr", vim.lsp.buf.references, opts)
	keymap("n", "<space>e", vim.diagnostic.open_float, opts)
	keymap("n", "[d", vim.diagnostic.goto_prev, opts)
	keymap("n", "]d", vim.diagnostic.goto_next, opts)
	keymap("n", "<space>cl", vim.diagnostic.setqflist, opts)
	keymap("n", "<space>f", vim.lsp.buf.formatting, opts)
	keymap("n", "<space>rf", vim.lsp.buf.range_formatting, opts)

	-- Set some keybinds conditional on server capabilities
	if client.resolved_capabilities.document_formatting then
		vim.api.nvim_create_autocmd({ "BufWritePre" }, {
			group = vim.api.nvim_create_augroup("lsp_format", { clear = true }),
			callback = function()
				vim.lsp.buf.formatting_sync()
			end,
		})
	end

	if client.resolved_capabilities.code_lens then
		keymap("n", "<space>lr", vim.lsp.codelens.run, opts)
		-- keymap("n", "<space>lr", vim.lsp.codelens.refresh, opts)
		vim.api.nvim_create_autocmd({ "BufEnter", "CursorHold", "InsertLeave" }, {
			group = vim.api.nvim_create_augroup("lsp_codelens", { clear = true }),
			callback = function()
				vim.lsp.codelens.refresh()
			end,
		})
	end

	if vim.bo[bufnr].buftype ~= "" or vim.bo[bufnr].filetype == "helm" then
		vim.diagnostic.disable(bufnr)
		vim.defer_fn(function()
			vim.diagnostic.reset(nil, bufnr)
		end, 1000)
	end
end

local function make_config()
	local capabilities = vim.lsp.protocol.make_client_capabilities()
	capabilities = require("cmp_nvim_lsp").update_capabilities(capabilities)
	return {
		capabilities = capabilities,
		on_attach = on_attach,
	}
end

return {
	on_attach = on_attach,
	make_config = make_config,
}
