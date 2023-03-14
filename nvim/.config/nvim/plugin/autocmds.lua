-- better term ui/ux
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

-- create directories when needed, when saving a file
vim.api.nvim_create_autocmd("BufWritePre", {
	group = vim.api.nvim_create_augroup("auto_create_dir", { clear = true }),
	callback = function(event)
		local file = vim.loop.fs_realpath(event.match) or event.match

		vim.fn.mkdir(vim.fn.fnamemodify(file, ":p:h"), "p")
		local backup = vim.fn.fnamemodify(file, ":p:~:h")
		backup = backup:gsub("[/\\]", "%%")
		vim.go.backupext = backup
	end,
})

vim.api.nvim_create_autocmd("RecordingEnter", {
	group = vim.api.nvim_create_augroup("recording_enter", { clear = true }),
	callback = function()
		vim.o.cmdheight = 1
	end,
})

vim.api.nvim_create_autocmd("RecordingLeave", {
	group = vim.api.nvim_create_augroup("recording_leave", { clear = true }),
	callback = function()
		vim.o.cmdheight = 0
	end,
})
