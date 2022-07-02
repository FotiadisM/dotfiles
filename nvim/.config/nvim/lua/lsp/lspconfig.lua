vim.lsp.handlers["textDocument/hover"] = vim.lsp.with(vim.lsp.handlers.hover, { border = "single" })

vim.lsp.handlers["textDocument/signatureHelp"] = vim.lsp.with(vim.lsp.handlers.signature_help, { border = "single" })

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
	keymap("n", "<space>q", vim.diagnostic.setqflist, opts)
	keymap("n", "<space>f", vim.lsp.buf.formatting, opts)
	keymap("n", "<space>rf", vim.lsp.buf.range_formatting, opts)

	-- Set some keybinds conditional on server capabilities
	if client.resolved_capabilities.document_formatting then
		local gr = vim.api.nvim_create_augroup("lsp_format", { clear = true })
		vim.api.nvim_create_autocmd({ "BufWritePre" }, {
			group = gr,
			buffer = bufnr,
			callback = function()
				vim.lsp.buf.formatting_sync()
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

require("plugins.nvim-lsp-installer")
local lspconf = require("lspconfig")

lspconf["gopls"].setup(require("lsp.servers.gopls").setup(make_config(), on_attach))
lspconf["sumneko_lua"].setup(require("lsp.servers.sumneko_lua").setup(make_config(), on_attach))
lspconf["texlab"].setup(require("lsp.servers.texlab").setup(make_config(), on_attach))
lspconf["html"].setup(require("lsp.servers.html").setup(make_config(), on_attach))
lspconf["jsonls"].setup(require("lsp.servers.jsonls").setup(make_config(), on_attach))
lspconf["tsserver"].setup(require("lsp.servers.tsserver").setup(make_config(), on_attach))
lspconf["yamlls"].setup(require("lsp.servers.yamlls").setup(make_config(), on_attach))
lspconf["volar"].setup(require("lsp.servers.volar").setup(make_config(), on_attach))
lspconf["rust_analyzer"].setup(require("lsp.servers.rust_analyzer").setup(make_config(), on_attach))

lspconf["clangd"].setup(make_config())
lspconf["bashls"].setup(make_config())
lspconf["dockerls"].setup(make_config())
lspconf["tailwindcss"].setup(make_config())
lspconf["terraformls"].setup(make_config())

require("lsp.servers.null_ls").setup(on_attach)

local signs = { Error = " ", Warn = " ", Hint = " ", Info = " " }
for type, icon in pairs(signs) do
	local hl = "DiagnosticSign" .. type
	vim.fn.sign_define(hl, { text = icon, texthl = hl, numhl = hl })
end

-- show lightbulb when a code actions is available
vim.api.nvim_create_autocmd({ "CursorHold", "CursorHoldI" }, {
	pattern = "*",
	callback = function()
		require("nvim-lightbulb").update_lightbulb()
	end,
})
