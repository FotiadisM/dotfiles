local helm = function(path)
	for dir in vim.fs.parents(path) do
		if vim.fn.fnamemodify(dir, ":t") == "templates" then
			if vim.fn.filereadable(vim.fs.dirname(dir) .. "/Chart.yaml") == 1 then
				return "helm"
			end
		end
	end
	return "yaml"
end

vim.filetype.add({
	filename = {
		Tiltfile = "tiltfile",
	},
	extension = {
		yaml = helm,
		tpl = helm,
		k = "kcl",
	},
	pattern = {
		[".env.*"] = "sh",
	},
})
