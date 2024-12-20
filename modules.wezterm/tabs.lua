local wezterm = require("wezterm")

local module = {}

local SOLID_RIGHT_ARROW = wezterm.nerdfonts.pl_left_hard_divider
local TAB_BAR_BG = "#002b36"
-- local ACTIVE_TAB_BG = "#112641"
local ACTIVE_TAB_BG = require("modules.background_color")
local ACTIVE_TAB_FG = "#ebdbb2"
-- local INACTIVE_TAB_BG = "#112641"
local INACTIVE_TAB_BG = require("modules.background_color")
local INACTIVE_TAB_FG = "#8691a7"
local HOVER_TAB_BG = "#ebdbb2"
local HOVER_TAB_FG = "#112641"
local NEW_TAB_BG = INACTIVE_TAB_BG
local NEW_TAB_FG = INACTIVE_TAB_FG
function module.setup(config, enabled)
	enabled = enabled == nil and true or false
	config.enable_tab_bar = enabled
	config.hide_tab_bar_if_only_one_tab = false
	config.show_tabs_in_tab_bar = true
	config.switch_to_last_active_tab_when_closing_tab = false
	config.tab_and_split_indices_are_zero_based = false
	config.tab_bar_at_bottom = true
	config.show_new_tab_button_in_tab_bar = false
	config.use_fancy_tab_bar = false
	config.tab_max_width = 36

	config.colors = {
		tab_bar = {
			background = "#112641", -- minischeme
			active_tab = {
				bg_color = ACTIVE_TAB_BG,
				fg_color = ACTIVE_TAB_FG,
				intensity = "Normal",
				underline = "None",
				italic = false,
				strikethrough = false,
			},
			inactive_tab = {
				bg_color = INACTIVE_TAB_BG,
				fg_color = INACTIVE_TAB_FG,
			},
			inactive_tab_hover = {
				bg_color = HOVER_TAB_BG,
				fg_color = HOVER_TAB_FG,
				italic = true,
			},
			new_tab = {
				bg_color = NEW_TAB_BG,
				fg_color = NEW_TAB_FG,
			},
			new_tab_hover = {
				bg_color = HOVER_TAB_BG,
				fg_color = HOVER_TAB_FG,
				italic = true,
			},
		},
	}

	config.tab_bar_style = {
		new_tab = wezterm.format({
			{ Background = { Color = INACTIVE_TAB_BG } },
			{ Foreground = { Color = TAB_BAR_BG } },
			{ Text = SOLID_RIGHT_ARROW },
			{ Background = { Color = INACTIVE_TAB_BG } },
			{ Foreground = { Color = INACTIVE_TAB_FG } },
			{ Text = " + " },
			{ Background = { Color = TAB_BAR_BG } },
			{ Foreground = { Color = INACTIVE_TAB_BG } },
			{ Text = SOLID_RIGHT_ARROW },
		}),
		new_tab_hover = wezterm.format({
			{ Attribute = { Italic = false } },
			{ Background = { Color = HOVER_TAB_BG } },
			{ Foreground = { Color = TAB_BAR_BG } },
			{ Text = SOLID_RIGHT_ARROW },
			{ Background = { Color = HOVER_TAB_BG } },
			{ Foreground = { Color = HOVER_TAB_FG } },
			{ Text = " + " },
			{ Background = { Color = TAB_BAR_BG } },
			{ Foreground = { Color = HOVER_TAB_BG } },
			{ Text = SOLID_RIGHT_ARROW },
		}),
	}
end

wezterm.on("format-tab-title", function(tab, tabs, _, _, hover, _)
	local background = NEW_TAB_BG
	local foreground = NEW_TAB_FG

	local is_first = tab.tab_id == tabs[1].tab_id

	if tab.is_active then
		background = ACTIVE_TAB_BG
		foreground = ACTIVE_TAB_FG
	elseif hover then
		-- remove hover color
		-- background = HOVER_TAB_BG
		-- foreground = HOVER_TAB_FG
	end

	local leading_bg = background
	local trailing_fg = background

	local function check_start_arrow()
		if not is_first then
			return SOLID_RIGHT_ARROW
		else
			return " "
		end
	end

	local title = require("modules.window_name").get_window_title(tab)
	if is_first then
		title = title .. " "
	else
		title = " " .. title .. " "
	end

	return {
		{ Background = { Color = leading_bg } },
		{ Foreground = { Color = TAB_BAR_BG } },
		-- { Text = check_start_arrow() },

		{ Attribute = { Intensity = "Half" } },
		{ Background = { Color = background } },
		{ Foreground = { Color = foreground } },
		-- { Text = string.format(" %s", tab.tab_index + 1) },
		{ Attribute = { Intensity = "Normal" } },

		{ Background = { Color = background } },
		{ Foreground = { Color = foreground } },
		{ Text = string.format("%s", title) },

		{ Background = { Color = TAB_BAR_BG } },
		{ Foreground = { Color = trailing_fg } },
		-- { Text = SOLID_RIGHT_ARROW },
	}
end)

return module
