vim.api.nvim_create_user_command("QuitAll", "%bd | e# | bd#", {})

vim.api.nvim_create_user_command("Neogit", function()
	require("neogit").open()
end, {})
