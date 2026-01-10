local wezterm = require("wezterm")
local config = {}

-- config.font = wezterm.font("JetBrains Mono")
config.font = wezterm.font("SauceCodePro Nerd Font", {
	weight = "Regular",
	stretch = "Normal",
	style = "Normal",
})
config.color_scheme = "Catppuccin Macchiato"
config.hide_tab_bar_if_only_one_tab = true

-- hyperlinks
-- Use the defaults as a base
config.hyperlink_rules = wezterm.default_hyperlink_rules()
-- Spawn a fish shell in login mode
config.default_prog = { "/home/linuxbrew/.linuxbrew/bin/zsh" }
return config
