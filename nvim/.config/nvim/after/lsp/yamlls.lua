return {
	settings = {
		redhat = { telemetry = { enabled = false } },
		yaml = {
			format = { enable = false },
			validate = true,
			hover = true,
			schemaStore = { enable = false, url = "" },
		},
	},
	before_init = function(_, config)
        -- can't assign new table because of
        -- https://github.com/neovim/neovim/issues/27740#issuecomment-1978629315
        config.settings.yaml.schemas = require("schemastore").yaml.schemas()
    end,
}
