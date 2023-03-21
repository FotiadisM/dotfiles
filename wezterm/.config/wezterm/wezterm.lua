local wezterm = require("wezterm")

-- colors:
--   primary:
--     background: "#0E1018"
--     foreground: "#ebdbb2"
--
--   normal:
--     black: "#282828"
--     red: "#cc241d"
--     green: "#98971a"
--     yellow: "#d79921"
--     blue: "#458588"
--     magenta: "#b16286"
--     cyan: "#689d6a"
--     white: "#dfaf87"
--
--   bright:
--     black: "#928374"
--     red: "#fb4934"
--     green: "#b8bb26"
--     yellow: "#fabd2f"
--     blue: "#83a598"
--     magenta: "#d3869b"
--     cyan: "#8ec07c"
--     white: "#ebdbb2"

local gruvbox = {
	foreground = "#ebdbb2",
	background = "#0E1018",
	cursor_bg = "#ebdbb2",
	cursor_border = "#ebdbb2",
	cursor_fg = "#24283b",
	selection_bg = "#282828",
	selection_fg = "#83a598",

	ansi = { "#282828", "#cc241d", "#98971a", "#d79921", "#458588", "#b16286", "#689d6a", "#dfaf87" },
	brights = { "#928374", "#fb4934", "#b8bb26", "#fabd2f", "#83a598", "#d3869b", "#8ec07c", "#ebdbb2" },
}

local tokyonight = {
	foreground = "#fffbf6",
	background = "#101421",
	cursor_bg = "#c0caf5",
	cursor_border = "#c0caf5",
	cursor_fg = "#24283b",
	selection_bg = "#364a82",
	selection_fg = "#c0caf5",

	ansi = { "#1d202f", "#f7768e", "#9ece6a", "#e0af68", "#7aa2f7", "#bb9af7", "#7dcfff", "#a9b1d6" },
	brights = { "#414868", "#f7768e", "#9ece6a", "#e0af68", "#7aa2f7", "#bb9af7", "#7dcfff", "#c0caf5" },
}

return {
	colors = gruvbox,
	enable_tab_bar = false,
	enable_scroll_bar = false,
	font_size = 11.8,
	font = wezterm.font_with_fallback({
		{ family = "JetBrains Mono", weight = "Bold" },
		{ family = "Symbols Nerd Font Mono", scale = 0.75 },
	}),
	window_padding = {
		left = 2,
		right = 0,
		top = 2,
		bottom = 0,
	},
	adjust_window_size_when_changing_font_size = false,
	audible_bell = "Disabled",
}
