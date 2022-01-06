local nl = require("null-ls")

local sources = {
	-- null_ls.builtins.formatting.prettier,
	nl.builtins.formatting.prettierd, -- faster than prettier, doesn't support range formatting
	nl.builtins.formatting.gofumpt,
	nl.builtins.formatting.rustfmt,
	nl.builtins.formatting.stylua,

	nl.builtins.diagnostics.yamllint,
}

local on_attach = function(_, bufnr)
	local function keymap(...)
		vim.api.nvim_buf_set_keymap(bufnr, ...)
	end

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
	keymap("n", "<space>e", "<cmd>lua vim.lsp.diagnostic.show_line_diagnostics()<CR>", opts)
	keymap("n", "[d", "<cmd>lua vim.lsp.diagnostic.goto_prev()<CR>", opts)
	keymap("n", "]d", "<cmd>lua vim.lsp.diagnostic.goto_next()<CR>", opts)
	keymap("n", "<space>q", "<cmd>lua vim.lsp.diagnostic.set_loclist()<CR>", opts)
	keymap("n", "<space>f", ":lua vim.lsp.buf.formatting()<CR>", opts)
	keymap("n", "<space>rf", ":lua vim.lsp.buf.range_formatting_sync()<CR>", opts)

	vim.cmd([[
	augroup lsp_format
		autocmd! * <buffer>
		autocmd BufWritePost <buffer> lua vim.lsp.buf.formatting_sync()
	augroup END
	]])
end

nl.setup({
	sources = sources,
	on_attach = on_attach,
})
