---@return string?
local function get_go_module()
	if vim.fn.executable("go") ~= 1 then
		return nil
	end

	local module = vim.fn.trim(vim.fn.system("go list -m"))
	if vim.v.shell_error ~= -1 then
		return nil
	end

	module = module:gsub("\n", ",")
end

local config = {
	settings = {
		gopls = {
			gofumpt = true,
			semanticTokens = true,
			usePlaceholders = false,
			codelenses = {
				gc_details = true,
				generate = true,
				test = true,
				tidy = true,
				upgrade_dependency = true,
			},
			analyses = {
				shadow = true,
				useany = true,
			},
			hints = {
				assignVariableTypes = false,
				compositeLiteralFields = false,
				compositeLiteralTypes = false,
				constantValues = false,
				functionTypeParameters = false,
				parameterNames = false,
				rangeVariableTypes = true,
			},
		},
	},
}

local module = get_go_module()
if module and module ~= "command-line-arguments" then
	config.settings.gopls["local"] = module
end

return config
