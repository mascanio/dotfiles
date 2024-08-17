local wezterm = require("wezterm")
local config = {}

-- config.font = wezterm.font("JetBrains Mono")
config.font = wezterm.font("SauceCodePro Nerd Font", {
	weight = "Regular",
	stretch = "Normal",
	style = "Normal",
})
config.color_scheme = "Catppuccin Macchiato"

return config
