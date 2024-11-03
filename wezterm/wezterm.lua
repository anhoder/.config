local wezterm = require("wezterm")
local config = wezterm.config_builder()

local term_editors = { "hx", "nvim", "vim" }
local win_ext = ".exe" -- extension to add to match Windows process names

-- check is editor
local function is_editor(name)
	if type(name) ~= "string" then
		return nil
	end
	-- wezterm.log_info("@isEditor,name=" .. name)
	for _, editor in pairs(term_editors) do
		if name == editor or name == editor .. win_ext then
			return true
		end
	end
	return false
end

-- get filename from path
local function basename(path)
	local isWin = wezterm.target_triple == "x86_64-pc-windows-msvc"
	if type(path) ~= "string" then
		return nil
	end
	if isWin then
		return path:gsub("(.*[/\\])(.*)", "%2") -- replace (path/ or path\)(file) with (file)
	else
		return path:gsub("(.*/)(.*)", "%2")
	end -- replace (path/)(file)          with (file)
end

-- close unless in an Editor, see github.com/wez/wezterm/issues/1417
local cb_pane_unless_editor = function(win, pane, mods, key, fallback_action)
	local proc_name = basename(pane:get_foreground_process_name())
	if is_editor(proc_name) then
		win:perform_action({ SendKey = { mods = mods, key = key } }, pane)
	else
		win:perform_action(fallback_action, pane)
	end
end

config.font = wezterm.font_with_fallback({
	{ family = "JetBrainsMono Nerd Font Mono" },
	"Symbols Nerd Font",
})
config.font_size = 15
config.bold_brightens_ansi_colors = "BrightAndBold"
config.color_scheme = "Gruvbox Dark (Gogh)"
config.animation_fps = 60
config.enable_kitty_keyboard = true
config.enable_csi_u_key_encoding = false
config.enable_scroll_bar = true
config.enable_tab_bar = true
config.front_end = "OpenGL"
config.window_background_opacity = 0.8
config.text_background_opacity = 0.5
config.macos_window_background_blur = 5
config.max_fps = 60
config.use_fancy_tab_bar = false
config.hide_tab_bar_if_only_one_tab = true
config.use_ime = true
config.native_macos_fullscreen_mode = true
config.window_padding = {
	left = 0,
	right = 0,
	top = 0,
	bottom = 0,
}
config.leader = { key = "a", mods = "CTRL", timeout_milliseconds = 1000 }
config.debug_key_events = false
config.keys = {
	{
		key = "\\",
		mods = "CMD",
		action = wezterm.action.SplitHorizontal({ domain = "CurrentPaneDomain" }),
	},
	{
		key = "|",
		mods = "CMD",
		action = wezterm.action.SplitVertical({ domain = "CurrentPaneDomain" }),
	},
	{
		key = "c",
		mods = "CMD",
		action = wezterm.action.DisableDefaultAssignment,
	},
	{
		key = "v",
		mods = "CMD",
		action = wezterm.action.DisableDefaultAssignment,
	},
	{
		key = "1",
		mods = "CMD",
		action = wezterm.action.DisableDefaultAssignment,
	},
	{
		key = "2",
		mods = "CMD",
		action = wezterm.action.DisableDefaultAssignment,
	},
	{
		key = "3",
		mods = "CMD",
		action = wezterm.action.DisableDefaultAssignment,
	},
	{
		key = "w",
		mods = "CMD",
		action = wezterm.action_callback(function(win, pane)
			return cb_pane_unless_editor(
				win,
				pane,
				nil,
				utf8.char(0xAA),
				wezterm.action.CloseCurrentPane({ confirm = true })
			)
		end),
	},
	{
		key = "Enter",
		mods = "CMD",
		action = wezterm.action.ToggleFullScreen,
	},
}

return config
