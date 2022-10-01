local helm = function(path)
	while path ~= "/" do
		path = vim.fn.fnamemodify(path, ":h")
		if vim.fn.fnamemodify(path, ":t") == "templates" then
			path = vim.fn.fnamemodify(path, ":h")
			if vim.fn.filereadable(path .. "/Chart.yaml") == 1 then
				return "helm"
			end
		end
		return "yaml"
	end
end

vim.filetype.add({
	extension = {
		yaml = helm,
		tpl = helm,
	},
})
