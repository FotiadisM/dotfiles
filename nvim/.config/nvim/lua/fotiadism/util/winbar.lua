local M = {}

function M.set_winbar()
	local modified = vim.api.nvim_eval_statusline("%M", {}).str == "+" and "●" or ""
	modified = "%#WinBarModified#" .. modified .. "%* "
	local filename = vim.fn.expand("%:~:.")
	return "  " .. modified .. filename
end

return M
