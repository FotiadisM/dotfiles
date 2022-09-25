vim.lsp.handlers["textDocument/hover"] = vim.lsp.with(vim.lsp.handlers.hover, { border = "rounded" })
vim.lsp.handlers["textDocument/signatureHelp"] = vim.lsp.with(vim.lsp.handlers.signature_help, { border = "rounded" })

vim.diagnostic.config({
	virtual_text = {
		prefix = "●",
		source = "if_many",
	},
	float = {
		source = "if_many",
	},
})

local on_attach = require("lsp").on_attach
local make_config = require("lsp").make_config

require("mason").setup()
require("mason-lspconfig").setup()

local lspconf = require("lspconfig")
lspconf["gopls"].setup(require("lsp.servers.gopls").setup(make_config(), on_attach))
lspconf["sumneko_lua"].setup(require("lsp.servers.sumneko_lua").setup(make_config(), on_attach))
lspconf["texlab"].setup(require("lsp.servers.texlab").setup(make_config(), on_attach))
lspconf["html"].setup(require("lsp.servers.html").setup(make_config(), on_attach))
lspconf["jsonls"].setup(require("lsp.servers.jsonls").setup(make_config(), on_attach))
lspconf["yamlls"].setup(require("lsp.servers.yamlls").setup(make_config(), on_attach))
lspconf["volar"].setup(require("lsp.servers.volar").setup(make_config(), on_attach))
require("typescript").setup({
	server = require("lsp.servers.tsserver").setup(make_config(), on_attach),
})
require("rust-tools").setup({
	server = require("lsp.servers.rust_analyzer").setup(make_config(), on_attach),
})
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

return {
	on_attach = on_attach,
	make_config = make_config,
}
