vim.api.nvim_create_user_command("QuitAll", "%bd | e# | bd#", {})

function P(v)
	print(vim.inspect(v))
end
