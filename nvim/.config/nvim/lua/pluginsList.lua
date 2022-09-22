local packer_bootstrap = nil
local install_path = vim.fn.stdpath("data") .. "/site/pack/packer/start/packer.nvim"
if vim.fn.empty(vim.fn.glob(install_path)) > 0 then
	packer_bootstrap = vim.fn.system({
		"git",
		"clone",
		"--depth",
		"1",
		"https://github.com/wbthomason/packer.nvim",
		install_path,
	})
	vim.cmd([[packadd packer.nvim]])
end

local packer = require("packer")
packer.startup({
	function(use)
		use("wbthomason/packer.nvim")

		-- theme
		use("folke/tokyonight.nvim")
		use({ "nvim-lualine/lualine.nvim", requires = "kyazdani42/nvim-web-devicons" })
		use({ "akinsho/nvim-bufferline.lua", requires = "kyazdani42/nvim-web-devicons" })

		-- file managing
		use({ "kyazdani42/nvim-tree.lua", requires = "kyazdani42/nvim-web-devicons" })
		use({
			"nvim-telescope/telescope.nvim",
			requires = {
				{ "nvim-lua/plenary.nvim" },
			},
		})
		use({ "nvim-telescope/telescope-packer.nvim", requires = "nvim-telescope/telescope.nvim" })
		use({ "nvim-telescope/telescope-fzf-native.nvim", run = "make", requires = "nvim-telescope/telescope.nvim" })
		use({ "windwp/nvim-spectre", requires = "nvim-lua/plenary.nvim" })

		-- language stuff
		use("nvim-treesitter/nvim-treesitter")
		use({ "nvim-treesitter/nvim-treesitter-textobjects", requires = "nvim-treesitter/nvim-treesitter" })
		use({ "nvim-treesitter/nvim-treesitter-context", requires = "nvim-treesitter/nvim-treesitter" })
		use({ "nvim-treesitter/nvim-tree-docs", requires = "nvim-treesitter/nvim-treesitter" })
		use({ "nvim-treesitter/playground", requires = "nvim-treesitter/nvim-treesitter" })
		use("neovim/nvim-lspconfig")
		use("williamboman/mason.nvim")
		use("williamboman/mason-lspconfig.nvim")
		use({ "kosayoda/nvim-lightbulb", requires = "antoinemadec/FixCursorHold.nvim" })
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
				"petertriho/cmp-git",
			},
			config = function()
				require("plugins.nvim-cmp")
			end,
		})
		use({
			"petertriho/cmp-git",
			requires = "nvim-lua/plenary.nvim",
			config = function()
				require("cmp_git").setup()
			end,
		})
		use("L3MON4D3/LuaSnip")
		use({
			"ThePrimeagen/refactoring.nvim",
			requires = {
				{ "nvim-lua/plenary.nvim" },
				{ "nvim-treesitter/nvim-treesitter" },
			},
		})

		-- language specific plugins
		use({ "towolf/vim-helm" })
		use("simrat39/rust-tools.nvim")
		use("jose-elias-alvarez/typescript.nvim")

		-- debugging
		use("mfussenegger/nvim-dap")
		use({ "rcarriga/nvim-dap-ui", requires = "mfussenegger/nvim-dap" })
		use({
			"theHamsta/nvim-dap-virtual-text",
			requires = { "mfussenegger/nvim-dap", "nvim-treesitter/nvim-treesitter" },
		})

		-- git
		use({ "lewis6991/gitsigns.nvim", requires = "nvim-lua/plenary.nvim" })
		use("sindrets/diffview.nvim")
		use({ "TimUntersberger/neogit", requires = "nvim-lua/plenary.nvim" })

		-- misc
		use("dstein64/vim-startuptime")
		use("lewis6991/impatient.nvim")
		use("ggandor/lightspeed.nvim")
		use("kylechui/nvim-surround")
		use({
			"windwp/nvim-autopairs",
			after = "nvim-cmp",
			config = function()
				require("plugins.nvim-autopairs")
			end,
		})
		use({
			"numToStr/Comment.nvim",
			requires = {
				{ "JoosepAlviste/nvim-ts-context-commentstring", requires = "nvim-treesitter/nvim-treesitter" },
			},
		})
		use("lukas-reineke/indent-blankline.nvim")
		use("folke/which-key.nvim")
		use("rcarriga/nvim-notify")
		use("NvChad/nvim-colorizer.lua")
		use({
			"NTBBloodbath/rest.nvim",
			ft = "http",
			requires = "nvim-lua/plenary.nvim",
			config = function()
				require("rest-nvim").setup()
			end,
		})
		use({ "folke/todo-comments.nvim", requires = "nvim-lua/plenary.nvim" })
		use("FotiadisM/tabset.nvim")
		use({
			"iamcco/markdown-preview.nvim",
			run = "cd app && npm install",
			setup = function()
				vim.g.mkdp_filetypes = { "markdown" }
			end,
			ft = { "markdown" },
		})
		use("stevearc/dressing.nvim")
		use("RRethy/vim-illuminate")
		-- TODO: enable this plugin when https://github.com/neovim/neovim/pull/17446 is merged
		use({
			"kevinhwang91/nvim-ufo",
			disable = true,
			requires = "kevinhwang91/promise-async",
			config = function()
				require("plugins.nvim-ufo")
			end,
		})
		use({ "aarondiel/spread.nvim", require = "nvim-treesitter" })
		use("b0o/schemastore.nvim")
		use({
			"someone-stole-my-name/yaml-companion.nvim",
			requires = {
				{ "neovim/nvim-lspconfig" },
				{ "nvim-lua/plenary.nvim" },
				{ "nvim-telescope/telescope.nvim" },
			},
		})
		use("j-hui/fidget.nvim")
		use("axieax/urlview.nvim")
	end,
	config = {
		profile = {
			enable = true,
		},
	},
})

if packer_bootstrap then
	packer.sync()
end
