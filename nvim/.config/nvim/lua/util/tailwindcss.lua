local M = {}

M.lspkind_format = function(entry, vim_item)
	local doc = entry.completion_item.documentation

	if vim_item.kind == "Color" and type(doc) == "string" then
		local _, _, r, g, b = doc:find("rgba?%((%d+), (%d+), (%d+)")
		if r then
			local color = string.format("%02x%02x%02x", r, g, b)
			local group = "TailwindColorFg" .. color
			local opts = { fg = "#" .. color }

			if vim.fn.hlID(group) < 1 then
				vim.api.nvim_set_hl(0, group, opts)
			end

			vim_item.kind_hl_group = group
		end
	end

	return vim_item
end

return M
