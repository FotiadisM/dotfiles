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
			})
		end,
	},
	{
		"ellisonleao/gruvbox.nvim",
		lazy = false,
		priority = 1000,
		config = function()
			require("gruvbox").setup({
				contrast = "hard",
				palette_overrides = { dark0_hard = "#0E1018" },
				overrides = {
					-- Comment = {fg = "#626A73", italic = true, bold = true},
					-- #736B62,  #626273, #627273
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

					-- new git colors
					-- DiffAdd = { bold = true, reverse = false, fg = "", bg = "#2a4333" },
					-- DiffChange = { bold = true, reverse = false, fg = "", bg = "#333841" },
					-- DiffDelete = { bold = true, reverse = false, fg = "#442d30", bg = "#442d30" },
					-- DiffText = { bold = true, reverse = false, fg = "", bg = "#213352" },
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
		dependencies = { "DaikyXendo/nvim-material-icon" },
		lazy = false,
		priority = 1000,
		config = function()
			-- custom tokyonight inspired theme
			local colors = {
				dark = "#1f2335",
				white = "#ffffff",
				gray = "#CCCCCC",
				blue = "#2ac3de",
				purple = "#9d7cd8",
				orange = "#ff9e64",
				green = "#9ece6a",
				teal = "#1abc9c",
				red = "#f7768e",
			}

			local theme = {
				normal = {
					a = { bg = colors.blue, fg = colors.dark, gui = "bold" },
					b = { bg = colors.dark, fg = colors.white },
					c = { bg = colors.dark, fg = colors.gray },
				},
				insert = {
					a = { bg = colors.teal, fg = colors.dark, gui = "bold" },
					b = { bg = colors.dark, fg = colors.white },
					c = { bg = colors.dark, fg = colors.gray },
				},
				visual = {
					a = { bg = colors.green, fg = colors.dark, gui = "bold" },
					b = { bg = colors.dark, fg = colors.white },
					c = { bg = colors.dark, fg = colors.gray },
				},
				replace = {
					a = { bg = colors.red, fg = colors.dark, gui = "bold" },
					b = { bg = colors.dark, fg = colors.white },
					c = { bg = colors.dark, fg = colors.gray },
				},
				command = {
					a = { bg = colors.orange, fg = colors.dark, gui = "bold" },
					b = { bg = colors.dark, fg = colors.white },
					c = { bg = colors.dark, fg = colors.gray },
				},
				inactive = {
					a = { bg = colors.purple, fg = colors.gray, gui = "bold" },
					b = { bg = colors.dark, fg = colors.white },
					c = { bg = colors.dark, fg = colors.gray },
				},
			}

			require("lualine").setup({
				options = {
					theme = "onedark",
				},
				extensions = { "nvim-tree" },
			})
		end,
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
