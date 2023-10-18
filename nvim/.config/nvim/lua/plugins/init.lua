return {
	-- file managing
	{
		"windwp/nvim-spectre",
		dependencies = "nvim-lua/plenary.nvim",
		config = true,
	},

	-- git
	{
		"sindrets/diffview.nvim",
		cmd = { "DiffviewOpen", "DiffviewFileHistory" },
		config = true,
	},
	{
		"NeogitOrg/neogit",
		cmd = "Neogit",
		dependencies = "nvim-lua/plenary.nvim",
		opts = { disable_commit_confirmation = true },
	},

	-- misc
	{
		"ThePrimeagen/harpoon",
		dependencies = "nvim-lua/plenary.nvim",
	},
	{
		"ThePrimeagen/refactoring.nvim",
		dependencies = {
			"nvim-lua/plenary.nvim",
			"nvim-treesitter/nvim-treesitter",
		},
		config = true,
	},
	{
		"ggandor/leap.nvim",
		dependencies = { "tpope/vim-repeat", "ggandor/flit.nvim" },
		event = "BufReadPre",
		config = function()
			require("flit").setup()
			require("leap").set_default_keymaps()
		end,
	},
	{
		"kylechui/nvim-surround",
		event = "BufReadPre",
		config = true,
	},
	{
		"windwp/nvim-ts-autotag",
		ft = { "html", "typescriptreact", "vue" },
		dependencies = "nvim-treesitter/nvim-treesitter",
	},
	{
		"folke/which-key.nvim",
		event = "VeryLazy",
		config = true,
	},
	{
		"NvChad/nvim-colorizer.lua",
		event = "BufReadPre",
		opts = { user_default_options = { names = false } },
	},
	{
		"NTBBloodbath/rest.nvim",
		dependencies = "nvim-lua/plenary.nvim",
		ft = "http",
		config = true,
	},
	{
		"iamcco/markdown-preview.nvim",
		build = "cd app && npm install",
		ft = "markdown",
		config = function()
			vim.g.mkdp_filetypes = { "markdown" }
		end,
	},
	{
		"stevearc/dressing.nvim",
		event = "VeryLazy",
	},
	{
		"RRethy/vim-illuminate",
		lazy = false,
	},
	{
		"kevinhwang91/nvim-ufo",
		dependencies = "kevinhwang91/promise-async",
		event = "BufReadPre",
		config = true,
	},
	{
		"aarondiel/spread.nvim",
		dependencies = "nvim-treesitter/nvim-treesitter",
	},
	{
		"axieax/urlview.nvim",
		cmd = "UrlView",
		config = true,
	},
	{
		"FotiadisM/other.nvim",
		dev = true,
		config = true,
	},
	{
		"tomiis4/Hypersonic.nvim", -- regex explainer
		cmd = { "Hypersonic" },
		config = true,
	},
}
