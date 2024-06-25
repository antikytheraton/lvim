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

wezterm.on("print_info", function(window)
	local mux = wezterm.mux
	local workspace = mux.get_active_workspace()
	local workspace2 = window:active_workspace()
	local window_id = window:window_id()
	wezterm.log_info("Workspace: " .. workspace)
	wezterm.log_info("Workspace option 2: " .. workspace2)
	wezterm.log_info("All Windows: " .. window_id)

	local tabs_info = window:tabs_with_info()
	local tab_details = {}

	for _, tab_info in ipairs(tabs_info) do
		local details = string.format(
			"Tab Index: %d, Is Active: %s, Tab ID: %d",
			tab_info.index,
			tostring(tab_info.is_active),
			tab_info.tab:tab_id()
		)
		table.insert(tab_details, details)
	end

	local tab_details_str = table.concat(tab_details, "; ")
	wezterm.log_info(string.format("Window ID: %d, Tabs Info: [%s]", window:window_id(), tab_details_str))
end)

---------------------------------------------------------------------------------------------
-- FUNCTIONS
---------------------------------------------------------------------------------------------

local get_last_folder_segment = function(cwd)
	if cwd == nil then
		return "N/A" -- or some default value
	end
	-- strip off 'file:///' if present
	local pathStripped = cwd:match("^file:///(.+)") or cwd
	-- normalize backslashes to slashes for windows paths
	pathStripped = pathStripped:gsub("\\", "/")
	-- split the path by '/'
	local path = {}
	for segment in string.gmatch(pathStripped, "[^/]+") do
		table.insert(path, segment)
	end
	return path[#path] -- returns the last element
end

local function get_current_working_dir(tab)
	local current_dir = tab.active_pane.current_working_dir or ""
	return get_last_folder_segment(current_dir)
end

local process_icons = {
	["docker"] = wezterm.nerdfonts.linux_docker,
	["docker-compose"] = wezterm.nerdfonts.linux_docker,
	["psql"] = wezterm.nerdfonts.dev_postgresql,
	["kuberlr"] = wezterm.nerdfonts.linux_docker,
	["kubectl"] = wezterm.nerdfonts.linux_docker,
	["stern"] = wezterm.nerdfonts.linux_docker,
	["nvim"] = wezterm.nerdfonts.custom_vim,
	["make"] = wezterm.nerdfonts.seti_makefile,
	["vim"] = wezterm.nerdfonts.dev_vim,
	["lvim"] = wezterm.nerdfonts.custom_vim,
	["go"] = wezterm.nerdfonts.seti_go,
	["zsh"] = wezterm.nerdfonts.dev_terminal,
	["bash"] = wezterm.nerdfonts.cod_terminal_bash,
	["btm"] = wezterm.nerdfonts.mdi_chart_donut_variant,
	["htop"] = wezterm.nerdfonts.mdi_chart_donut_variant,
	["cargo"] = wezterm.nerdfonts.dev_rust,
	["python"] = wezterm.nerdfonts.dev_python,
	["sudo"] = wezterm.nerdfonts.fa_hashtag,
	["lazydocker"] = wezterm.nerdfonts.linux_docker,
	["git"] = wezterm.nerdfonts.dev_git,
	["lua"] = wezterm.nerdfonts.seti_lua,
	["wget"] = wezterm.nerdfonts.mdi_arrow_down_box,
	["curl"] = wezterm.nerdfonts.mdi_flattr,
	["gh"] = wezterm.nerdfonts.dev_github_badge,
	["ruby"] = wezterm.nerdfonts.cod_ruby,
	["pwsh"] = wezterm.nerdfonts.seti_powershell,
	["node"] = wezterm.nerdfonts.dev_nodejs_small,
	["dotnet"] = wezterm.nerdfonts.md_language_csharp,
}

local function get_process(tab)
	local process_name = tab.active_pane.foreground_process_name:match("([^/\\]+)%.exe$")
		or tab.active_pane.foreground_process_name:match("([^/\\]+)$")
	local icon = process_icons[process_name] or wezterm.nerdfonts.seti_checkbox_unchecked
	return icon
end

-- This function returns the suggested title for a tab.
-- It prefers the title that was set via `tab:set_title()`
-- or `wezterm cli set-tab-title`, but falls back to the
-- title of the active pane in that tab.
local function tab_title(tab_info)
	local title = tab_info.tab_title
	-- if the tab title is explicitly set, take that
	if title and #title > 0 then
		-- return get_current_working_dir(tab_info)
		return title
	end
	-- Otherwise, use the title from the active pane
	-- in that tab
	return tab_info.active_pane.title
end

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
config.window_background_opacity = 0.9
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

-- The filled in variant of the < symbol
local SOLID_LEFT_ARROW = wezterm.nerdfonts.pl_right_hard_divider
-- The filled in variant of the > symbol
local SOLID_RIGHT_ARROW = wezterm.nerdfonts.pl_left_hard_divider

wezterm.on("format-tab-title", function(tab, tabs, panes, config, hover, max_width)
	local edge_background = "#0b0022"
	local background = "#1b1032"
	local foreground = "#808080"

	if tab.is_active then
		background = "#2b2042"
		foreground = "#c0c0c0"
	elseif hover then
		background = "#3b3052"
		foreground = "#909090"
	end

	local edge_foreground = background

	local title = tab_title(tab)

	-- ensure that the titles fit in the available space,
	-- and that we have room for the edges.
	title = wezterm.truncate_right(title, max_width - 2)

	return {
		{ Background = { Color = edge_background } },
		{ Foreground = { Color = edge_foreground } },
		{ Text = SOLID_LEFT_ARROW },
		{ Background = { Color = background } },
		{ Foreground = { Color = foreground } },
		{ Text = title },
		{ Background = { Color = edge_background } },
		{ Foreground = { Color = edge_foreground } },
		{ Text = SOLID_RIGHT_ARROW },
	}
end)

wezterm.on("update-status", function(window, pane)
	local workspace_or_leader = window:active_workspace()
	if window:active_key_table() then
		workspace_or_leader = window:active_key_table()
	end
	if window:leader_is_active() then
		workspace_or_leader = "LEADER"
	end

	local cmd = get_last_folder_segment(pane:get_foreground_process_name())
	local time = wezterm.strftime("%H:%M")
	local hostname = " " .. wezterm.hostname() .. " "

	window:set_right_status(wezterm.format({
		{ Text = wezterm.nerdfonts.oct_table .. " " .. workspace_or_leader },
		{ Text = " | " },
		{ Foreground = { Color = "#FFB86C" } },
		{ Text = wezterm.nerdfonts.fa_code .. " " .. cmd },
		"ResetAttributes",
		{ Text = " | " },
		{ Text = wezterm.nerdfonts.oct_person .. " " .. hostname },
		{ Text = " | " },
		{ Text = wezterm.nerdfonts.md_clock .. " " .. time },
	}))
end)

-- Panes
-- config.inactive_pane_hsb = {
-- 	saturation = 0.9,
-- 	brightness = 0.9,
-- }

---------------------------------------------------------------------------------------------
-- KEYS
---------------------------------------------------------------------------------------------
config.leader = { key = "a", mods = "CTRL", timeout_milliseconds = 1000 }
config.keys = {
	-- Pane Keybindings
	{ key = "-", mods = "LEADER", action = act.SplitVertical({ domain = "CurrentPaneDomain" }) },
	{ key = "|", mods = "LEADER", action = act.SplitHorizontal({ domain = "CurrentPaneDomain" }) },
	{ key = "h", mods = "CTRL|SHIFT", action = act.ActivatePaneDirection("Left") },
	{ key = "l", mods = "CTRL|SHIFT", action = act.ActivatePaneDirection("Right") },
	{ key = "k", mods = "CTRL|SHIFT", action = act.ActivatePaneDirection("Up") },
	{ key = "j", mods = "CTRL|SHIFT", action = act.ActivatePaneDirection("Down") },
	{ key = "x", mods = "LEADER", action = act.CloseCurrentPane({ confirm = true }) },
	{ key = "z", mods = "LEADER", action = act.TogglePaneZoomState },
	{ key = "s", mods = "LEADER", action = act.RotatePanes("Clockwise") },
	{ key = "r", mods = "LEADER", action = act.ActivateKeyTable({ name = "resize_pane", one_shot = false }) },

	-- Tab Keybindings
	{ key = "c", mods = "LEADER", action = act.SpawnTab("CurrentPaneDomain") },
	{ key = "RightArrow", mods = "SHIFT", action = act.ActivateTabRelative(1) },
	{ key = "LeftArrow", mods = "SHIFT", action = act.ActivateTabRelative(-1) },
	{ key = "t", mods = "LEADER", action = act.ShowTabNavigator },
	-- { key = "RightArrow", mods = "CTRL|SHIFT", action = act.MoveTabRelative(1) },
	-- { key = "LeftArrow", mods = "CTRL|SHIFT", action = act.MoveTabRelative(-1) },
	{ key = "m", mods = "LEADER", action = act.ActivateKeyTable({ name = "move_tab", one_shot = false }) },

	-- Workspace
	{ key = "w", mods = "LEADER", action = act.ShowLauncherArgs({ flags = "FUZZY|WORKSPACES" }) },
	{
		key = "W",
		mods = "LEADER",
		action = act.PromptInputLine({
			description = wezterm.format({
				{ Attribute = { Intensity = "Bold" } },
				{ Foreground = { AnsiColor = "Fuchsia" } },
				{ Text = "Enter name for new workspace" },
			}),
			action = wezterm.action_callback(function(window, pane, line)
				-- line will be `nil` if they hit escape without entering anything
				-- An empty string if they just hit enter
				-- Or the actual line of text they wrote
				if line then
					window:perform_action(
						act.SwitchToWorkspace({
							name = line,
						}),
						pane
					)
				end
			end),
		}),
	},

	-- Session Manager
	{ key = "S", mods = "LEADER", action = wezterm.action({ EmitEvent = "save_state" }) },
	{ key = "R", mods = "LEADER", action = wezterm.action({ EmitEvent = "restore_state" }) },
	{ key = "L", mods = "LEADER", action = wezterm.action({ EmitEvent = "load_state" }) },
}

config.key_tables = {
	resize_pane = {
		{ key = "h", action = act.AdjustPaneSize({ "Left", 1 }) },
		{ key = "j", action = act.AdjustPaneSize({ "Down", 1 }) },
		{ key = "k", action = act.AdjustPaneSize({ "Up", 1 }) },
		{ key = "l", action = act.AdjustPaneSize({ "Right", 1 }) },
		{ key = "Escape", action = "PopKeyTable" },
		{ key = "Enter", action = "PopKeyTable" },
	},
	move_tab = {
		{ key = "h", action = act.MoveTabRelative(-1) },
		{ key = "j", action = act.MoveTabRelative(-1) },
		{ key = "k", action = act.MoveTabRelative(1) },
		{ key = "l", action = act.MoveTabRelative(1) },
		{ key = "Escape", action = "PopKeyTable" },
		{ key = "Enter", action = "PopKeyTable" },
	},
}

return config
