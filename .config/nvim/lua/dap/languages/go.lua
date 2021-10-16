return {
	adapter = {
		type = "server",
		host = "127.0.0.1",
		port = 38697,
	},
	configuration = {
		{
			type = "go",
			name = "Debug",
			request = "launch",
			program = "${file}"
		},
		{
			type = "go",
			name = "Debug test",
			request = "launch",
			mode = "test",
			program = "${file}"
		},
		{
			type = "go",
			name = "Debug test (go.mod)",
			request = "launch",
			mode = "test",
			program = "./${relativeFileDirname}"
		}
	}
}
