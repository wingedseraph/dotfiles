local wezterm = require("wezterm")

local config = {}
config.adjust_window_size_when_changing_font_size = false

require("modules.font").set_font(config)

config.audible_bell = "Disabled"
config.colors = {
	background = require("modules.background_color"),
	tab_bar = {
		background = require("modules.background_color"),
	},
	-- cursor_bg = "#2b1f31",
}
config.color_scheme = require("modules.colorscheme")
-- @tab
config.tab_bar_at_bottom = true
config.show_new_tab_button_in_tab_bar = false
config.use_fancy_tab_bar = false
config.tab_max_width = 36
if wezterm.config_builder then
	---@diagnostic disable-next-line: lowercase-global
	builder = wezterm.config_builder()
end

require("modules.tabs").setup(builder, false)

config.window_background_opacity = 1
config.exit_behavior = "Close"
config.cursor_thickness = "150%"
config.underline_thickness = "250%"
config.initial_rows = 20
config.initial_cols = 120
config.hide_mouse_cursor_when_typing = true
config.hide_tab_bar_if_only_one_tab = true
config.window_decorations = "RESIZE" -- NONE, TITLE, RESIZE
config.keys = {
	-- { action = wezterm.action.ActivateCommandPalette, mods = "CTRL", key = "p" },
	{ action = wezterm.action.DecreaseFontSize, mods = "CTRL", key = "-" },
	{ action = wezterm.action.DecreaseFontSize, mods = "CTRL", key = "-" },
	{ action = wezterm.action.IncreaseFontSize, mods = "CTRL", key = "=" },
	-- { action = wezterm.action.ToggleFullScreen, mods = "ALT", key = "f" },
	{ action = wezterm.action.PasteFrom("Clipboard"), mods = "CTRL", key = "v" },
	{ action = wezterm.action.PasteFrom("PrimarySelection"), mods = "CTRL", key = "v" },
	{ action = wezterm.action.PasteFrom("Clipboard"), mods = "CTRL", key = "м" },
	{ action = wezterm.action.PasteFrom("PrimarySelection"), mods = "CTRL", key = "м" },
	{ key = "w", mods = "ALT", action = wezterm.action.CloseCurrentTab({ confirm = false }) },
	{ key = "ц", mods = "ALT", action = wezterm.action.CloseCurrentTab({ confirm = false }) },
	{ action = wezterm.action.ResetFontSize, mods = "CTRL", key = "0" },
	{ action = wezterm.action.ToggleFullScreen, key = "F11" },
}
config.mouse_bindings = {
	-- Clicking the scroll wheel while holding CTRL resets the font size
	{
		event = { Down = { streak = 1, button = "Middle" } },
		mods = "CTRL",
		action = wezterm.action.ResetFontSize,
	},

	-- Scrolling up while holding CTRL increases the font size
	{
		event = { Down = { streak = 1, button = { WheelUp = 1 } } },
		mods = "CTRL",
		action = wezterm.action.IncreaseFontSize,
	},

	-- Scrolling down while holding CTRL decreases the font size
	{
		event = { Down = { streak = 1, button = { WheelDown = 1 } } },
		mods = "CTRL",
		action = wezterm.action.DecreaseFontSize,
	},
}

-- ALT + number to activate that tab
-- for i = 1, 8 do
--   table.insert(config.keys, {
--     key = tostring(i),
--     mods = 'ALT',
--     action = act.ActivateTab(i - 1),
--   })
-- end

config.scrollback_lines = 10000
config.show_update_window = false
config.unicode_version = 15
config.window_close_confirmation = "NeverPrompt"
config.window_padding = { left = 0, right = 0, top = 0, bottom = 0 }
-- config.wsl_domains = wezterm.default_wsl_domains()
config.default_domain = "WSL:Debian"
config.default_cursor_style = "SteadyBlock" -- SteadyBlock, BlinkingBlock, SteadyUnderline, BlinkingUnderline, SteadyBar, and BlinkingBar
wezterm.on("user-var-changed", function(window, pane, name, value)
	local overrides = window:get_config_overrides() or {}
	if name == "ZEN_MODE" then
		local incremental = value:find("+")
		local number_value = tonumber(value)
		if incremental ~= nil then
			while number_value > 0 do
				window:perform_action(wezterm.action.IncreaseFontSize, pane)
				number_value = number_value - 1
			end
			overrides.enable_tab_bar = false
		elseif number_value < 0 then
			window:perform_action(wezterm.action.ResetFontSize, pane)
			overrides.font_size = nil
			overrides.enable_tab_bar = true
		else
			overrides.font_size = number_value
			overrides.enable_tab_bar = false
		end
	end
	window:set_config_overrides(overrides)
end)
-- rewrite config to use modules for colorscheme and background etc
-- now require is error cuz it is windows \
-- \Users\mi\scoop\apps\wezterm\current\wezterm_modules/
-- modules\tabs.lua
-- path ahahaha

return config
