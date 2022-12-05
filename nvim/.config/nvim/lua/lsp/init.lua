local on_attach = function(client, bufnr)
	require("illuminate").on_attach(client)

	-- Mappings
	local map = function(m, l, r, desc, opts)
		opts = opts or { buffer = bufnr, noremap = true, silent = true }
		desc = desc or ""
		opts.desc = desc
		vim.keymap.set(m, l, r, opts)
	end
	map("n", "gD", vim.lsp.buf.declaration, "go declaration")
	map("n", "gd", vim.lsp.buf.definition, "go definition")
	map("n", "K", vim.lsp.buf.hover, "hover")
	map("n", "gi", vim.lsp.buf.implementation, "go implementation")
	map("n", "<space>k", vim.lsp.buf.signature_help, "signature help")
	map("n", "<space>wa", vim.lsp.buf.add_workspace_folder, "add workspace folder")
	map("n", "<space>wr", vim.lsp.buf.remove_workspace_folder, "remove workspace folder")
	map("n", "<space>wl", function()
		print(vim.inspect(vim.lsp.buf.list_workspace_folders()))
	end, "list workspace folders")
	map("n", "<space>D", vim.lsp.buf.type_definition, "type definition")
	map("n", "<space>ca", vim.lsp.buf.code_action, "code action")
	map("n", "<space>rn", vim.lsp.buf.rename, "rename")
	map("n", "gr", vim.lsp.buf.references, "references")
	map("n", "<space>e", vim.diagnostic.open_float, "open diagnostics")
	map("n", "[d", vim.diagnostic.goto_prev, "diagnostics prev")
	map("n", "]d", vim.diagnostic.goto_next, "diagnostics next")
	map("n", "<space>cl", vim.diagnostic.setqflist, "diagnostics quicklist")
	map("n", "<space>f", vim.lsp.buf.format, "format")

	-- Set some keybinds conditional on server capabilities
	if client.server_capabilities.documentFormattingProvider then
		vim.api.nvim_create_autocmd("BufWritePre", {
			group = vim.api.nvim_create_augroup("lsp_format", { clear = true }),
			callback = function()
				vim.lsp.buf.format()
			end,
		})
	end

	if client.server_capabilities.codeLensProvider then
		map("n", "<space>lr", vim.lsp.codelens.run, "codelens")
		-- map("n", "<space>lr", vim.lsp.codelens.refresh, "codelens refreash")
		vim.api.nvim_create_autocmd({ "BufEnter", "CursorHold", "InsertLeave" }, {
			group = vim.api.nvim_create_augroup("lsp_codelens", { clear = true }),
			callback = function()
				vim.lsp.codelens.refresh()
			end,
		})
	end
end

local function make_config()
	local capabilities = require("cmp_nvim_lsp").default_capabilities()
	capabilities.textDocument.foldingRange = {
		dynamicRegistration = false,
		lineFoldingOnly = true,
	}
	return {
		capabilities = capabilities,
		on_attach = on_attach,
	}
end

return {
	on_attach = on_attach,
	make_config = make_config,
}
