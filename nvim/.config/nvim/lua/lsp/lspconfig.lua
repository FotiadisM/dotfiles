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
	local function keymap(...)
		vim.api.nvim_buf_set_keymap(bufnr, ...)
	end

	require("lsp_signature").on_attach(lspSignatureCfg)
	require("illuminate").on_attach(client)

	-- Mappings.
	local opts = { noremap = true, silent = true }
	keymap("n", "gD", "<cmd>lua vim.lsp.buf.declaration()<CR>", opts)
	keymap("n", "gd", "<cmd>lua vim.lsp.buf.definition()<CR>", opts)
	keymap("n", "K", "<cmd>lua vim.lsp.buf.hover()<CR>", opts)
	keymap("n", "gi", "<cmd>lua vim.lsp.buf.implementation()<CR>", opts)
	keymap("n", "<space>k", "<cmd>lua vim.lsp.buf.signature_help()<CR>", opts)
	keymap("n", "<space>wa", "<cmd>lua vim.lsp.buf.add_workspace_folder()<CR>", opts)
	keymap("n", "<space>wr", "<cmd>lua vim.lsp.buf.remove_workspace_folder()<CR>", opts)
	keymap("n", "<space>wl", "<cmd>lua print(vim.inspect(vim.lsp.buf.list_workspace_folders()))<CR>", opts)
	keymap("n", "<space>D", "<cmd>lua vim.lsp.buf.type_definition()<CR>", opts)
	keymap("n", "<space>ca", "<cmd>lua vim.lsp.buf.code_action()<CR>", opts)
	keymap("n", "<space>rn", "<cmd>lua vim.lsp.buf.rename()<CR>", opts)
	keymap("n", "gr", "<cmd>lua vim.lsp.buf.references()<CR>", opts)
	keymap("n", "<space>e", "<cmd>lua vim.diagnostic.open_float()<CR>", opts)
	keymap("n", "[d", "<cmd>lua vim.diagnostic.goto_prev()<CR>", opts)
	keymap("n", "]d", "<cmd>lua vim.diagnostic.goto_next()<CR>", opts)
	keymap("n", "<space>q", "<cmd>lua vim.diagnostic.setqflist()<CR>", opts)
	keymap("n", "<space>f", ":lua vim.lsp.buf.formatting()<CR>", opts)
	keymap("n", "<space>rf", ":lua vim.lsp.buf.range_formatting()<CR>", opts)

	-- Set some keybinds conditional on server capabilities
	if client.resolved_capabilities.document_formatting then
		vim.cmd([[
		augroup lsp_format
			autocmd! * <buffer>
			autocmd BufWritePost <buffer> lua vim.lsp.buf.formatting_sync()
		augroup END
		]])
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
vim.cmd([[autocmd CursorHold,CursorHoldI * lua require('nvim-lightbulb').update_lightbulb()]])
