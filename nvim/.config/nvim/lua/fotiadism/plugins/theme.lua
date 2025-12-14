return {
	{
		"folke/tokyonight.nvim",
		lazy = false,
		priority = 1000,
		config = function()
			require("tokyonight").setup({
				sidebars = {
					"qf",
					"terminal",
					"spectre_panel",
				},
				lualine_bold = true,
				on_highlights = function(hl, c)
					hl.WinBar = { bg = c.bg_dark }
					hl.WinBarModified = { fg = "#fd7f20" }
					hl.FoldColumn = { bg = c.bg_dark }

					hl.NvimTreeIndentMarker = { fg = c.blue2 }
					hl.NvimTreeFolderIcon = { fg = c.blue2 }

					hl.NvimTreeGitDirtyIcon = { fg = "#fd7f20" }
					hl.NvimTreeGitStagedIcon = { fg = c.teal }
					hl.NvimTreeGitNewIcon = { fg = "#03fcc2" }
					hl.NvimTreeGitDeletedIcon = { fg = c.red1 }

					hl.IndentBlanklineContextChar = { fg = c.blue2 }
				end,
			})
		end,
	},
	{
		"nvim-lualine/lualine.nvim",
		lazy = false,
		priority = 1000,
		dependencies = { "nvim-tree/nvim-web-devicons" },
		opts = {
			options = {
				theme = "auto",
				globalstatus = true,
			},
		},
	},
	{
		"nvim-tree/nvim-web-devicons",
		dependencies = { "FotiadisM/nvim-material-icon" },
		config = function()
			require("nvim-web-devicons").setup({
				override = require("nvim-material-devicons").get_icons(),
			})
		end,
	},
	{
		"FotiadisM/nvim-material-icon",
		dev = true,
	},
}
