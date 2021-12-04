vim.lsp.handlers["textDocument/hover"] = vim.lsp.with(vim.lsp.handlers.hover, { border = "single" })

vim.lsp.handlers["textDocument/signatureHelp"] = vim.lsp.with(vim.lsp.handlers.signature_help, { border = "single" })

local lspSignatureCfg = {
	hint_enable = false,
	handler_opts = {
		border = "single",
	},
	zindex = 50, -- signatureHelp behind completion items
}

-- lspkeymaps
local on_attach = function(client, bufnr)
	local function buf_set_keymap(...)
		vim.api.nvim_buf_set_keymap(bufnr, ...)
	end

	require("lsp_signature").on_attach(lspSignatureCfg)

	-- Mappings.
	local opts = { noremap = true, silent = true }
	buf_set_keymap("n", "gD", "<cmd>lua vim.lsp.buf.declaration()<CR>", opts)
	buf_set_keymap("n", "gd", "<cmd>lua vim.lsp.buf.definition()<CR>", opts)
	buf_set_keymap("n", "K", "<cmd>lua vim.lsp.buf.hover()<CR>", opts)
	buf_set_keymap("n", "gi", "<cmd>lua vim.lsp.buf.implementation()<CR>", opts)
	buf_set_keymap("n", "<space>k", "<cmd>lua vim.lsp.buf.signature_help()<CR>", opts)
	buf_set_keymap("n", "<space>wa", "<cmd>lua vim.lsp.buf.add_workspace_folder()<CR>", opts)
	buf_set_keymap("n", "<space>wr", "<cmd>lua vim.lsp.buf.remove_workspace_folder()<CR>", opts)
	buf_set_keymap("n", "<space>wl", "<cmd>lua print(vim.inspect(vim.lsp.buf.list_workspace_folders()))<CR>", opts)
	buf_set_keymap("n", "<space>D", "<cmd>lua vim.lsp.buf.type_definition()<CR>", opts)
	buf_set_keymap("n", "<space>ca", "<cmd>lua vim.lsp.buf.code_action()<CR>", opts)
	buf_set_keymap("n", "<space>rn", "<cmd>lua vim.lsp.buf.rename()<CR>", opts)
	buf_set_keymap("n", "gr", "<cmd>lua vim.lsp.buf.references()<CR>", opts)
	buf_set_keymap("n", "<space>e", "<cmd>lua vim.lsp.diagnostic.show_line_diagnostics()<CR>", opts)
	buf_set_keymap("n", "[d", "<cmd>lua vim.lsp.diagnostic.goto_prev()<CR>", opts)
	buf_set_keymap("n", "]d", "<cmd>lua vim.lsp.diagnostic.goto_next()<CR>", opts)
	buf_set_keymap("n", "<space>q", "<cmd>lua vim.lsp.diagnostic.set_loclist()<CR>", opts)

	-- Set some keybinds conditional on server capabilities
	if client.resolved_capabilities.document_formatting then
		buf_set_keymap("n", "<space>f", "<cmd>lua vim.lsp.buf.formatting()<CR>", opts)
		vim.cmd([[
		augroup lsp_format
			autocmd! * <buffer>
			autocmd BufWritePost <buffer> lua vim.lsp.buf.formatting_sync()
			augroup END
		]])
	elseif client.resolved_capabilities.document_range_formatting then
		buf_set_keymap("n", "<space>rf", "<cmd>lua vim.lsp.buf.range_formatting()<CR>", opts)
	end
end

-- config that activates keymaps and enables snippet support
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
lspconf["clangd"].setup(make_config())

-- need to first call require(...).setup(...), then lspconf["null_ls"].setup()
-- to work
local conf = require("lsp.servers.null_ls").setup(make_config())
lspconf["null-ls"].setup(conf)

-- nvim-lsp-installer
local lsp_installer = require("nvim-lsp-installer")

lsp_installer.on_server_ready(function(server)
	local config = make_config()

	if server.name == "sumneko_lua" then
		config = require("lsp.servers.sumneko_lua").setup(config, on_attach)
	end

	if server.name == "texlab" then
		config = require("lsp.servers.texlab").setup(config, on_attach)
	end

	if server.name == "html" then
		config = require("lsp.servers.html").setup(config, on_attach)
	end

	if server.name == "jsonls" then
		config = require("lsp.servers.jsonls").setup(config, on_attach)
	end

	if server.name == "tsserver" then
		config = require("lsp.servers.tsserver").setup(config, on_attach)
	end

	if server.name == "yamlls" then
		config = require("lsp.servers.yamlls").setup(config, on_attach)
	end

	if server.name == "volar" then
		config = require("lsp.servers.volar").setup(config, on_attach)
	end

	if server.name == "rust_analyzer" then
		config = require("lsp.servers.rust_analyzer").setup(config, on_attach)
	end

	server:setup(config)
	vim.cmd([[ do User LspAttachBuffers ]])
end)

-- replace the default lsp diagnostic letters with prettier symbols
vim.fn.sign_define("LspDiagnosticsSignError", { text = "", numhl = "LspDiagnosticsDefaultError" })
vim.fn.sign_define("LspDiagnosticsSignWarning", { text = "", numhl = "LspDiagnosticsDefaultWarning" })
vim.fn.sign_define("LspDiagnosticsSignInformation", { text = "", numhl = "LspDiagnosticsDefaultInformation" })
vim.fn.sign_define("LspDiagnosticsSignHint", { text = "", numhl = "LspDiagnosticsDefaultHint" })

-- show lightbulb when a code actions is available
vim.cmd([[autocmd CursorHold,CursorHoldI * lua require('nvim-lightbulb').update_lightbulb()]])
