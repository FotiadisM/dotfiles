return {
	-- file managing
	{
		"windwp/nvim-spectre",
		dependencies = "nvim-lua/plenary.nvim",
		config = true,
	},

	-- git
	{
		"NeogitOrg/neogit",
		cmd = "Neogit",
		dependencies = "nvim-lua/plenary.nvim",
		opts = { disable_commit_confirmation = true },
	},

	-- misc
	{
		"folke/ts-comments.nvim",
		opts = {},
		event = "VeryLazy",
	},
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
		dependencies = "nvim-treesitter/nvim-treesitter",
		ft = { "html", "typescriptreact", "javascript" },
		config = true,
	},
	{
		"folke/which-key.nvim",
		event = "VeryLazy",
		config = true,
	},
	{
		"brenoprata10/nvim-highlight-colors",
		event = "BufReadPre",
		opts = {
			render = "virtual",
		},
	},
	{
		"iamcco/markdown-preview.nvim",
		cmd = { "MarkdownPreviewToggle", "MarkdownPreview" },
		build = function()
			require("lazy").load({ plugins = { "markdown-preview.nvim" } })
			vim.fn["mkdp#util#install"]()
		end,
		config = function()
			vim.cmd([[do FileType]])
		end,
	},
	{
		"MeanderingProgrammer/render-markdown.nvim",
		dependencies = { "nvim-treesitter/nvim-treesitter", "nvim-tree/nvim-web-devicons" },
		cmd = "RenderMarkdown",
		opts = {
			code = {
				sign = false,
				width = "block",
				right_pad = 1,
			},
			heading = {
				sign = false,
				icons = {},
			},
			checkbox = {
				enabled = false,
			},
		},
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
		event = "VeryLazy",
		config = true,
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
	{
		"terrastruct/d2-vim",
		ft = "d2",
	},
	{
		"kndndrj/nvim-dbee",
		dependencies = {
			"MunifTanjim/nui.nvim",
		},
		build = function()
			require("dbee").install()
		end,
		config = true,
	},
}
