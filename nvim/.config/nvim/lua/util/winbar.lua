local M = {}

vim.api.nvim_set_hl(0, "WinBarModified", { fg = "#fd7f20" })

function M.set_winbar()
	local modified = vim.api.nvim_eval_statusline("%M", {}).str == "+" and "●" or ""
	modified = "%#WinBarModified#" .. modified .. "%* "
	local filename = vim.fn.expand("%:~:.")
	return "  " .. modified .. filename
end

return M
