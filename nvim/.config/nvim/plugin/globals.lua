function P(v)
	print(vim.inspect(v))
end

function _G.r(name)
	return require(name)
end

function R(name)
	require("plenary.reload").reload_module(name)
	return require(name)
end
