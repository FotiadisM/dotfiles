local term_augroup = vim.api.nvim_create_augroup("term_augroup", { clear = true })

vim.api.nvim_create_autocmd("TermOpen", {
	group = term_augroup,
	callback = function()
		vim.o.number = false
		vim.o.relativenumber = false
		vim.cmd.startinsert()
	end,
})

vim.api.nvim_create_autocmd("TermClose", {
	group = term_augroup,
	callback = function()
		vim.cmd.bdelete()
	end,
})

local winbar_filetype_exclude = {
	"help",
	"term",
	"packer",
	"neogitstatus",
	"NvimTree",
	"spectre_panel",
}

local is_winbar_exclude = function()
	if vim.tbl_contains(winbar_filetype_exclude, vim.bo.filetype) then
		return true
	end
	return false
end

vim.api.nvim_create_autocmd("BufEnter", {
	group = vim.api.nvim_create_augroup("winbar_togle", { clear = true }),
	callback = function()
		if is_winbar_exclude() then
			if vim.o.winbar then
				vim.o.winbar = nil
			end
			return
		else
			vim.o.winbar = "%{%luaeval('require(\"util\").winbar()')%}"
		end
	end,
})
