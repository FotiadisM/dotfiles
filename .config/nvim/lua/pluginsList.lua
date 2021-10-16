local packer = require("packer")
local use = packer.use

return packer.startup({
	function()
		use "wbthomason/packer.nvim"

		-- theme
		use "folke/tokyonight.nvim"
		use {
			"hoob3rt/lualine.nvim",
			requires = { "kyazdani42/nvim-web-devicons", opt = true }
		}
		use {
			"akinsho/nvim-bufferline.lua",
			requires = "kyazdani42/nvim-web-devicons",
			config = function() require("plugins.bufferline") end
		}

		-- file managing
		use {
			"kyazdani42/nvim-tree.lua",
			requires = "kyazdani42/nvim-web-devicons",
			config = function() require("plugins.nvim-tree") end
		}

		use {
			"nvim-telescope/telescope.nvim",
			requires = "nvim-lua/plenary.nvim",
			module = "telescope",
			after = {
				"telescope-fzf-native.nvim",
				"telescope-packer.nvim",
				"telescope-dap.nvim"
			},
			config = function() require("plugins.telescope") end
		}
		use { "nvim-telescope/telescope-fzf-native.nvim", run = "make" }
		use "nvim-telescope/telescope-packer.nvim"
		use {
			"nvim-telescope/telescope-dap.nvim",
			requires = "mfussenegger/nvim-dap"
		}
		use {
			"windwp/nvim-spectre",
			requires = "nvim-lua/plenary.nvim",
			module = "spectre",
			config = function() require("spectre").setup() end
		}

		-- language stuff
		use {
			"nvim-treesitter/nvim-treesitter",
			run = ":TSUpdate",
			requires = {
				"nvim-treesitter/nvim-treesitter-textobjects"
			},
			config = function() require("plugins.nvim-treesitter") end
		}
		use {
			"neovim/nvim-lspconfig",
			config = function() require("lsp.lspconfig") end
		}
		use "williamboman/nvim-lsp-installer"
		use "kosayoda/nvim-lightbulb"
		use "onsails/lspkind-nvim"
		use "ray-x/lsp_signature.nvim"
		use {
			"hrsh7th/nvim-cmp",
			requires = {
				"hrsh7th/cmp-nvim-lsp",
				"hrsh7th/cmp-nvim-lua",
				"hrsh7th/cmp-buffer",
				"hrsh7th/cmp-path",
				"hrsh7th/cmp-calc",
				"kdheepak/cmp-latex-symbols",
				"ray-x/cmp-treesitter"
			},
			config = function() require("plugins.nvim-cmp") end
		}
		use { "simrat39/symbols-outline.nvim", cmd = "SymbolsOutline" }

		-- snipets
		use "L3MON4D3/LuaSnip"
		use "saadparwaiz1/cmp_luasnip"

		-- debugging
		use {
			"mfussenegger/nvim-dap",
			config = function() require("dap.nvim-dap") end
		}
		use {
			"rcarriga/nvim-dap-ui",
			requires = "mfussenegger/nvim-dap",
			config = function() require("dapui").setup() end
		}

		-- git
		use {
			"lewis6991/gitsigns.nvim",
			requires = "nvim-lua/plenary.nvim",
			config = function() require("plugins.gitsigns") end
		}
		use {
			"sindrets/diffview.nvim",
			cmd = "DiffviewOpen",
			config = function() require("diffview").setup() end
		}

		-- misc
		use "tpope/vim-surround"
		use {
			"norcalli/nvim-colorizer.lua",
			config = function() require("colorizer").setup() end
		}
		use {
			"windwp/nvim-autopairs",
			after = "nvim-cmp",
			config = function()
				require("plugins.nvim-autopairs")
			end
		}
		use "windwp/nvim-ts-autotag"
		use {
			"terrortylor/nvim-comment",
			cmd = "CommentToggle",
			config = function() require("plugins.nvim-comment") end

		}
		use "JoosepAlviste/nvim-ts-context-commentstring"
		use {
			"lukas-reineke/indent-blankline.nvim",
			config = function() require("plugins.indent-blankline") end
		}
		use {
			"akinsho/nvim-toggleterm.lua",
			cmd = "ToggleTerm",
			config = function() require("toggleterm").setup() end
		}
		use {
			"folke/which-key.nvim",
			config = function() require("which-key").setup() end
		}
		use {
			"rcarriga/nvim-notify",
			config = function() vim.notify = require("notify") end
		}
		use {
			"NTBBloodbath/rest.nvim",
			requires = "nvim-lua/plenary.nvim",
			config = function() require("rest-nvim").setup() end
		}
		use {
			"folke/todo-comments.nvim",
			requires = "nvim-lua/plenary.nvim",
			config = function() require("todo-comments").setup() end
		}

	end,
	config = {
		profile ={
			enable = true,
			threshold = 1
		}
	}
})
