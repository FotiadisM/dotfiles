local M = {}

vim.api.nvim_set_hl(0, "WinBarModified", { fg = "#fd7f20" })

function M.winbar()
	local modified = vim.api.nvim_eval_statusline("%M", {}).str == "+" and "●" or ""
	return "%=%#WinBarModified#" .. modified .. "%* %f"
end

return M
