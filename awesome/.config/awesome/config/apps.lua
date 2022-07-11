return {
	--- Default terminal emulator
	default = {
		terminal = "alacritty",
		editor = "alacritty -e nvim",
		--- Default web browser
		web_browser = "firefox",
		--- Default file manager
		-- file_manager = "nautilus",
		--- Default network manager
		-- network_manager = "wezterm start nmtui",
		--- Default bluetooth manager
		-- bluetooth_manager = "blueman-manager",
		--- Default power manager
		-- power_manager = "xfce4-power-manager",
		--- Default app launcher
		app_launcher = "rofi -show drun",
	},
	--- List of binaries/shell scripts that will execute for a certain task
	utils = {},
}
