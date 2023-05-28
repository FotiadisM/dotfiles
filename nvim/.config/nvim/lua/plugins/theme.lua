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

					hl.NvimTreeGitDirty = { fg = "#fd7f20" }
					hl.NvimTreeGitStaged = { fg = c.teal }
					hl.NvimTreeGitNew = { fg = "#03fcc2" }
					hl.NvimTreeGitDeleted = { fg = c.red1 }

					hl.IndentBlanklineContextChar = { fg = c.blue2 }
				end,
			})
		end,
	},
	{
		"ellisonleao/gruvbox.nvim",
		config = function()
			require("gruvbox").setup({
				contrast = "hard",
				palette_overrides = { dark0_hard = "#0E1018" },
				overrides = {
					Comment = { fg = "#81878f", italic = true, bold = true },
					Define = { link = "GruvboxPurple" },
					Macro = { link = "GruvboxPurple" },
					["@constant.builtin"] = { link = "GruvboxPurple" },
					["@storageclass.lifetime"] = { link = "GruvboxAqua" },
					["@text.note"] = { link = "TODO" },
					["@namespace.latex"] = { link = "Include" },
					["@namespace.rust"] = { link = "Include" },
					ContextVt = { fg = "#878788" },
					DiagnosticVirtualTextWarn = { fg = "#dfaf87" },

					-- fold
					Folded = { fg = "#fe8019", bg = "#3c3836" },
					FoldColumn = { fg = "#fe8019", bg = "#0E1018" },
					SignColumn = { bg = "#0E1018" },

					-- ui
					NonText = { fg = "#0E1018" },

					-- statusline
					StatusLine = { bg = "#ffffff", fg = "#0E1018" },
					StatusLineNC = { bg = "#3c3836", fg = "#0E1018" },
					CursorLineNr = { fg = "#fabd2f", bg = "" },
					GruvboxOrangeSign = { fg = "#dfaf87", bg = "" },
					GruvboxAquaSign = { fg = "#8EC07C", bg = "" },
					GruvboxGreenSign = { fg = "#b8bb26", bg = "" },
					GruvboxRedSign = { fg = "#fb4934", bg = "" },
					GruvboxBlueSign = { fg = "#83a598", bg = "" },
					WilderMenu = { fg = "#ebdbb2", bg = "" },
					WilderAccent = { fg = "#f4468f", bg = "" },
				},
			})
		end,
	},
	{
		"nvim-lualine/lualine.nvim",
		lazy = false,
		priority = 1000,
		dependencies = { "DaikyXendo/nvim-material-icon" },
		opts = {
			options = {
				theme = "auto",
				globalstatus = true,
			},
			extensions = { "nvim-tree" },
		},
	},
	{
		"DaikyXendo/nvim-material-icon",
		dependencies = { "kyazdani42/nvim-web-devicons" },
		lazy = false,
		priority = 1000,
		config = function()
			require("nvim-web-devicons").setup({
				override = require("nvim-material-icon").get_icons(),
			})
		end,
	},
}
