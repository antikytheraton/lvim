local wezterm = require("wezterm")
local mux = wezterm.mux
local act = wezterm.action

-- wezterm.on("gui-startup", function()
-- 	local tab, pane, window = mux.spawn_window({})
-- 	window:gui_window():maximize()
-- end)

local config = {}
if wezterm.config_builder then
	config = wezterm.config_builder()
end

config.default_prog = { "/opt/homebrew/bin/tmux", "new-session", "-DAs", "geek-1" }
-- config.default_prog = { "/opt/homebrew/bin/fish", "-l" }
-- config.audible_bell = "Disabled"

config.font = wezterm.font_with_fallback({
	"Iosevka Nerd Font",
	"JetBrainsMono Nerd Font",
	"CaskaydiaCove NF",
	"UbuntuMono Nerd Font",
	"Monaspace Krypton",
	"Monaspace Xenon",
	"Monaspace Radon",
	"Monaspace Argon",
	"CaskaydiaCove Nerd Font",
	"Monaspace Neon",
	"Mononoki Nerd Font",
	"MesloLGSDZ Nerd Font",
	"RobotoMono Nerd Font",
	"CodeNewRoman Nerd Font",
	"EnvyCodeR Nerd Font",
	"ShureTechMono Nerd Font",
	"FantasqueSansMono Nerd Font",
	"Hasklug Nerd Font",
	"Hack Nerd Font",
	"FiraCode Nerd Font",
	"InconsolataGo NF",
	"Hurmit Nerd Font",
	"IntoneMono Nerd Font",
	"DejaVuSansM Nerd Font",
}, {
	weight = "DemiBold",
	stretch = "Normal",
	style = "Normal",
})

config.font_size = 18.0
-- config.color_scheme = "tokyonight_storm"
config.color_scheme = "catppuccin-mocha"
-- config.color_scheme = "rose-pine"
-- config.line_height = 1.0
-- config.window_background_opacity = 0.3
-- config.macos_window_background_blur = 20

-- make clickable hyperlinks work
config.hyperlink_rules = {

	-- Linkify things that look like URLs and the host has a TLD name.
	-- Compiled-in default. Used if you don't specify any hyperlink_rules.
	{
		regex = "\\b\\w+://[\\w.-]+\\.[a-z]{2,15}\\S*\\b",
		format = "$0",
	},

	-- linkify email addresses
	-- Compiled-in default. Used if you don't specify any hyperlink_rules.
	{
		regex = [[\b\w+@[\w-]+(\.[\w-]+)+\b]],
		format = "mailto:$0",
	},

	-- file:// URI
	-- Compiled-in default. Used if you don't specify any hyperlink_rules.
	{
		regex = [[\bfile://\S*\b]],
		format = "$0",
	},

	-- Linkify things that look like URLs with numeric addresses as hosts.
	-- E.g. http://127.0.0.1:8000 for a local development server,
	-- or http://192.168.1.1 for the web interface of many routers.
	{
		regex = [[\b\w+://(?:[\d]{1,3}\.){3}[\d]{1,3}\S*\b]],
		format = "$0",
	},

	-- Make task numbers clickable
	-- The first matched regex group is captured in $1.
	{
		regex = [[\b(MP-\d+)\b]],
		format = "https://motimatic.atlassian.net/browse/$1",
	},

	-- Make username/project paths clickable. This implies paths like the following are for GitHub.
	-- ( "nvim-treesitter/nvim-treesitter" | wbthomason/packer.nvim | wez/wezterm | "wez/wezterm.git" )
	-- As long as a full URL hyperlink regex exists above this it should not match a full URL to
	-- GitHub or GitLab / BitBucket (i.e. https://gitlab.com/user/project.git is still a whole clickable URL)
	{
		regex = [[["]?([\w\d]{1}[-\w\d]+)(/){1}([-\w\d\.]+)["]?]],
		format = "https://www.github.com/$1/$3",
	},
}

return config
