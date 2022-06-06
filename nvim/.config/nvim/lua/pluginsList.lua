local packer = require("packer")
local use = packer.use

return packer.startup({
	function()
		use("wbthomason/packer.nvim")

		-- theme
		use("folke/tokyonight.nvim")
		use({
			"nvim-lualine/lualine.nvim",
			requires = { "kyazdani42/nvim-web-devicons", opt = true },
		})
		use({
			"akinsho/nvim-bufferline.lua",
			requires = "kyazdani42/nvim-web-devicons",
			config = function()
				require("plugins.bufferline")
			end,
		})

		-- file managing
		use({
			"kyazdani42/nvim-tree.lua",
			cmd = "NvimTreeToggle",
			requires = "kyazdani42/nvim-web-devicons",
			config = function()
				require("plugins.nvim-tree")
			end,
		})
		use({
			"FotiadisM/yanil",
			requires = { "nvim-lua/plenary.nvim", "kyazdani42/nvim-web-devicons" },
			config = function()
				require("plugins.yanil")
			end,
		})
		use({
			"nvim-telescope/telescope.nvim",
			requires = "nvim-lua/plenary.nvim",
			module = "telescope",
			after = {
				"telescope-fzf-native.nvim",
				"telescope-packer.nvim",
			},
			config = function()
				require("plugins.telescope")
			end,
		})
		use({ "nvim-telescope/telescope-fzf-native.nvim", run = "make" })
		use("nvim-telescope/telescope-packer.nvim")
		use({
			"windwp/nvim-spectre",
			requires = "nvim-lua/plenary.nvim",
			module = "spectre",
			config = function()
				require("spectre").setup()
			end,
		})

		-- language stuff
		use({
			"nvim-treesitter/nvim-treesitter",
			run = ":TSUpdate",
			requires = {
				"nvim-treesitter/nvim-treesitter-textobjects",
			},
			config = function()
				require("plugins.nvim-treesitter")
			end,
		})
		use({
			"anuvyklack/pretty-fold.nvim",
			config = function()
				require('pretty-fold').setup()
			end
		})
		use({
			"neovim/nvim-lspconfig",
			config = function()
				require("lsp.lspconfig")
			end,
		})
		use("williamboman/nvim-lsp-installer")
		use("kosayoda/nvim-lightbulb")
		use("onsails/lspkind-nvim")
		use("ray-x/lsp_signature.nvim")
		use({
			"jose-elias-alvarez/null-ls.nvim",
			require = { "nvim-lua/plenary.nvim", "neovim/nvim-lspconfig" },
		})
		use({
			"hrsh7th/nvim-cmp",
			requires = {
				"hrsh7th/cmp-nvim-lsp",
				"hrsh7th/cmp-nvim-lua",
				"hrsh7th/cmp-buffer",
				"hrsh7th/cmp-path",
				"saadparwaiz1/cmp_luasnip",
				"hrsh7th/cmp-cmdline",
				"hrsh7th/cmp-nvim-lsp-document-symbol",
			},
			config = function()
				require("plugins.nvim-cmp")
			end,
		})
		use("L3MON4D3/LuaSnip")
		use({ "simrat39/symbols-outline.nvim", cmd = "SymbolsOutline" })
		use({
			"ThePrimeagen/refactoring.nvim",
			requires = {
				{ "nvim-lua/plenary.nvim" },
				{ "nvim-treesitter/nvim-treesitter" },
			},
			config = function()
				require("plugins.refactoring")
			end,
		})

		-- language specific plugins
		use({ "towolf/vim-helm" })

		-- debugging
		use({
			"mfussenegger/nvim-dap",
			config = function()
				require("dap.nvim-dap")
			end,
		})
		use({
			"rcarriga/nvim-dap-ui",
			requires = "mfussenegger/nvim-dap",
			config = function()
				require("dapui").setup()
			end,
		})
		use({
			"theHamsta/nvim-dap-virtual-text",
			requires = { "mfussenegger/nvim-dap", "nvim-treesitter/nvim-treesitter" },
			config = function()
				require("nvim-dap-virtual-text").setup()
			end,
		})

		-- git
		use({
			"lewis6991/gitsigns.nvim",
			requires = "nvim-lua/plenary.nvim",
			config = function()
				require("plugins.gitsigns")
			end,
		})
		use({
			"sindrets/diffview.nvim",
			cmd = "DiffviewOpen",
			config = function()
				require("diffview").setup()
			end,
		})
		use({
			"TimUntersberger/neogit",
			requires = "nvim-lua/plenary.nvim",
			config = function()
				require("neogit").setup()
			end,
		})

		-- misc
		use("tpope/vim-surround")
		use("ggandor/lightspeed.nvim")
		use({
			"norcalli/nvim-colorizer.lua",
			disable = true,
			config = function()
				require("colorizer").setup()
			end,
		})
		use("tpope/vim-repeat")
		use({
			"windwp/nvim-autopairs",
			after = "nvim-cmp",
			config = function()
				require("plugins.nvim-autopairs")
			end,
		})
		use({
			"windwp/nvim-ts-autotag",
			requires = "nvim-treesitter/nvim-treesitter",
		})
		use({
			"numToStr/Comment.nvim",
			config = function()
				require("plugins.comment")
			end,
		})
		use({
			"AckslD/nvim-neoclip.lua",
			config = function()
				require("neoclip").setup()
			end,
		})
		use({
			"lukas-reineke/indent-blankline.nvim",
			config = function()
				require("plugins.indent-blankline")
			end,
		})
		use({
			"akinsho/nvim-toggleterm.lua",
			cmd = "ToggleTerm",
			config = function()
				require("toggleterm").setup()
			end,
		})
		use({
			"folke/which-key.nvim",
			config = function()
				require("which-key").setup()
			end,
		})
		use({
			"rcarriga/nvim-notify",
			config = function()
				vim.notify = require("notify")
			end,
		})
		use({
			"NTBBloodbath/rest.nvim",
			ft = "http",
			requires = "nvim-lua/plenary.nvim",
			config = function()
				require("rest-nvim").setup()
			end,
		})
		use({
			"folke/todo-comments.nvim",
			requires = "nvim-lua/plenary.nvim",
			config = function()
				require("plugins.todo-comments")
			end,
		})
		use({
			"FotiadisM/tabset.nvim",
			config = function()
				require("plugins.tabset")
			end,
		})
		use("davidgranstrom/nvim-markdown-preview")
		use({
			"stevearc/dressing.nvim",
			config = function()
				require("dressing").setup()
			end,
		})
		use("RRethy/vim-illuminate")
	end,
	config = {
		profile = {
			enable = true,
			threshold = 1,
		},
	},
})
