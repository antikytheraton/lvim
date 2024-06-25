local wezterm = require("wezterm")
local act = wezterm.action
local session_manager = require("wezterm-session-manager/session-manager")

-- wezterm.on("gui-startup", function()
-- 	local tab, pane, window = mux.spawn_window({})
-- 	window:gui_window():maximize()
-- end)

-- Session Manager
wezterm.on("save_state", function(window, pane)
	session_manager.save_state(window, pane)
end)
wezterm.on("load_state", function()
	session_manager.load_state()
end)
wezterm.on("restore_state", function(window)
	session_manager.restore_state(window)
end)

---------------------------------------------------------------------------------------------
-- CONFIG
---------------------------------------------------------------------------------------------

-- This table will hold the configuration.
local config = {}
-- In newer versions of wezterm, use the config_builder which will
-- help provide clearer error messages
if wezterm.config_builder then
	config = wezterm.config_builder()
end

-- selecting gpu driver
for _, gpu in ipairs(wezterm.gui.enumerate_gpus()) do
	if gpu.backend == "Metal" and gpu.device_type == "IntegratedGpu" then
		config.webgpu_preferred_adapter = gpu
		config.front_end = "WebGpu"
		break
	end
end

-- custom startup programm
config.default_prog = { "/opt/homebrew/bin/fish", "-l" }
-- config.default_prog = { "/opt/homebrew/bin/tmux", "new-session", "-DAs", "geek-1" }
-- config.default_prog = { "~/.cargo/bin/zellij" }

-- Font
config.font_size = 20.0
config.font = wezterm.font_with_fallback({
	"Iosevka NF",
	"Iosevka Nerd Font", -- __main__ </> WWW
	"Monaspace Argon",
	"Monaspace Neon",
	"Monaspace Krypton",
	"Monaspace Xenon",
	"Monaspace Radon",
	"JetBrainsMono Nerd Font",
	"FiraCode Nerd Font",
	"CaskaydiaCove NF",
	"UbuntuMono Nerd Font",
	"CaskaydiaCove Nerd Font",
	"Mononoki Nerd Font",
	"MesloLGSDZ Nerd Font",
	"RobotoMono Nerd Font",
	"CodeNewRoman Nerd Font",
	"EnvyCodeR Nerd Font",
	"ShureTechMono Nerd Font",
	"FantasqueSansMono Nerd Font",
	"Hasklug Nerd Font",
	"Hack Nerd Font",
	"InconsolataGo NF",
	"Hurmit Nerd Font",
	"IntoneMono Nerd Font",
	"DejaVuSansM Nerd Font",
}, {
	-- weight = "DemiBold",
	weight = "Regular",
	stretch = "Normal",
	style = "Normal",
})

config.font_rules = {
	{ -- Italic
		intensity = "Normal",
		italic = true,
		font = wezterm.font({
			-- family = "Iosevka Nerd Font",
			family = "Monaspace Radon", -- script like
			-- family = "FantasqueSansMono Nerd Font",
			-- family = "Monaspace Xenon", -- courier like
			style = "Italic",
		}),
	},
	{ -- Bold
		intensity = "Bold",
		italic = false,
		font = wezterm.font({
			family = "Iosevka NF",
			weight = "ExtraBold",
			-- weight = "Bold",
		}),
	},
	{ -- Bold Italic
		intensity = "Bold",
		italic = true,
		font = wezterm.font({
			family = "Monaspace Radon", -- script like
			-- family = "Iosevka NF",
			-- family = "FantasqueSansMono Nerd Font",
			style = "Italic",
			weight = "Bold",
		}),
	},
}

-- Cursor
config.default_cursor_style = "BlinkingBlock"
config.animation_fps = 30
config.cursor_blink_ease_in = "Constant"
config.cursor_blink_ease_out = "Constant"

-- config.color_scheme = "tokyonight_storm"
config.color_scheme = "catppuccin-mocha"
-- config.color_scheme = "nord"
-- config.color_scheme = "rose-pine"
-- config.color_scheme = "Everforest Dark (Gogh)"

-- Window
config.line_height = 1.0
config.window_background_opacity = 0.8
config.macos_window_background_blur = 50
config.window_decorations = "INTEGRATED_BUTTONS|RESIZE" -- removes close, minimize and so on
-- config.window_decorations = "RESIZE" -- removes close, minimize and so on
config.window_close_confirmation = "AlwaysPrompt"
config.window_padding = {
	top = 5,
	right = 5,
	bottom = 0,
	left = 5,
}

-- make clickable hyperlinks work
config.hyperlink_rules = wezterm.default_hyperlink_rules()

-- Linkify things that look like URLs with numeric addresses as hosts.
-- E.g. http://127.0.0.1:8000 for a local development server,
-- or http://192.168.1.1 for the web interface of many routers.
table.insert(config.hyperlink_rules, {
	regex = [[\b\w+://(?:[\d]{1,3}\.){3}[\d]{1,3}\S*\b]],
	format = "$0",
})

-- Make task numbers clickable
-- The first matched regex group is captured in $1.
table.insert(config.hyperlink_rules, {
	regex = [[\b(MP-\d+)\b]],
	format = "https://motimatic.atlassian.net/browse/$1",
})

table.insert(config.hyperlink_rules, {
	-- https://github.com/shinnn/github-username-regex  https://stackoverflow.com/a/64147124/5353461
	regex = [[(^|(?<=[\[(\s'"]))([0-9A-Za-z][-0-9A-Za-z]{0,38})/([A-Za-z0-9_.-]{1,100})((?=[])\s'".!?])|$)]],
	--  is/good  0valid0/-_.reponname  /bad/start  -bad/username  bad/end!  too/many/parts -bad/username
	--  [wraped/name] (aa/bb) 'aa/bb' "aa/bb"  end/punct!  end/punct.
	format = "https://www.github.com/$2/$3/",
	-- highlight = 0,  -- highlight this regex match group, use 0 for all
})

-- Tab/Status Bar
-- disables the 'modern' look of the tab bar
config.use_fancy_tab_bar = false
config.show_new_tab_button_in_tab_bar = false
config.hide_tab_bar_if_only_one_tab = true
config.status_update_interval = 1000
config.tab_max_width = 60
config.tab_bar_at_bottom = true

return config
