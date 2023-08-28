local wezterm = require("wezterm")

local config = {}

config.default_prog = { "/opt/homebrew/bin/tmux", "new-session", "-DAs", "geek-1" }
config.font = wezterm.font_with_fallback({
	"FantasqueSansMono Nerd Font",
	"CodeNewRoman Nerd Font",
	"FiraCode Nerd Font",
	"Hasklug Nerd Font",
	"Hack Nerd Font",
	"ShureTechMono Nerd Font",
	"RobotoMono Nerd Font",
	"Iosevka Nerd Font",
	"CaskaydiaCove Nerd Font",
}, { weight = "Regular", stretch = "Normal", style = "Normal" })
config.font_size = 20.0
config.color_scheme = "tokyonight_storm"

return config
