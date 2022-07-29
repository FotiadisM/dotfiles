require("impatient")

require("pluginsList")

require("theme")
require("options")
require("mappings")

-- if nvim starts with a directory as an argument, cd into it
vim.cmd([[
	autocmd VimEnter * if argc() == 1 && isdirectory(argv()[0]) | execute 'cd '.argv()[0] | wincmd l | endif
]])

function P(v)
	print(vim.inspect(v))
end

-- WSL yank support
vim.cmd([[
        let s:clip = '/mnt/c/Windows/System32/clip.exe'
        if executable(s:clip)
			augroup WSLYank
				autocmd!
				autocmd TextYankPost * if v:event.operator ==# 'y' | call system(s:clip, @0) | endif
			augroup END
        endif
]])

vim.g.do_filetype_lua = 1
vim.filetype.add({
	extension = {
		jenkinsfile = "groovy",
	},
	filename = {
		["NOTES.txt"] = "helm",
		["_helpers.tpl"] = "helm",
	},
})

vim.api.nvim_create_user_command("QuitAll", "%bd | e# | bd#", {})
