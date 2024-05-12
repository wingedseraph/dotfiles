local wezterm = require("wezterm")

-- local act = wezterm.action
local config = {}
config.adjust_window_size_when_changing_font_size = false

-- =============================================================================================
-- =========================================== FONTS ===========================================
-- =============================================================================================
-- config.font_rules = {
-- 	{
-- 		intensity = "Normal",
-- 		font = wezterm.font({
-- 			family = "Iosevka Comfy",
-- 			weight = "Regular",
-- 		}),
-- 	},
-- }
-- config.font = wezterm.font({ family = "Brutalist Mono" })
-- config.font = wezterm.font({ family = "Anonymous Pro", weight = "Regular" })
-- config.font = wezterm.font({ family = "Dank Mono", weight = "Regular" })
-- config.font = wezterm.font({ family = "VictorMono Nerd Font Mono", weight = "Regular" })
-- config.font = wezterm.font({ family = "MonoLisa Nerd Font Mono", weight = "Regular" })
-- config.font = wezterm.font({ family = "Monaspace Krypton", weight = "Regular" })
-- config.font = wezterm.font({ family = "Monaspace Argon", weight = "Regular" })
-- config.font = wezterm.font({ family = "Monaspace Neon", weight = "Regular" })
-- config.font = wezterm.font({ family = "Monaspace Xenon" })
-- config.font = wezterm.font({ family = "IosevkaTerm Nerd Font" })
-- config.font = wezterm.font({ family = "CozetteVector", weight = "Regular" })
-- config.font = wezterm.font({ family = "Operator Mono Light", weight = "Regular" })
config.font = wezterm.font({ family = "JetBrainsMono Nerd Font" })
-- config.font = wezterm.font({ family = "DotGothic16" })
-- config.font = wezterm.font({ family = "BlexMono Nerd Font", weight = "Regular" })
-- config.font = wezterm.font({ family = "CaskaydiaCove NF" })
config.window_background_opacity = 1
config.cell_width = 0.9 -- like alacritty
config.line_height = 1.35
config.font_size = 15.0
config.front_end = "WebGpu"
config.freetype_load_flags = "NO_HINTING"
-- config.dpi = 104 -- working bad white lines on startup if dpi > 110
-- config.freetype_load_flags = "DEFAULT" -- NO_HINTING or DEFAULT
-- config.freetype_load_target = "Light" -- Normal, Light, Mono and HorizontalLcd
-- config.freetype_render_target = "HorizontalLcd"

-- =============================================================================================
-- =========================================== COLORS ==========================================
-- =============================================================================================
config.audible_bell = "Disabled"
config.colors = {
	-- background = "#002b36", -- solarized
	-- background = "#181818", -- sunburn
	background = "#1e1e1e", -- vscode
	-- background = "#1f1f28", -- kanagawa
	-- background = "#a1b26", -- tokyonight
	-- background = "#10262c", -- mini hue green
	-- background = "#2b1f31", -- mini hue purple
	-- background = "#002734", -- mini hue azure
	-- background = "#1d1d1d", -- adwaita
	-- background = "#101010", -- monochrome
	-- background = "#24292e", -- github dark
	-- background = "#041320", -- base 16 vulcan
	-- background = "#000000", -- lunaperche and base16-black-metal-gorgoroth
	-- background = "#1c1c1c", -- nvim colorscheme retrobox:like gruvbox

	-- cursor_bg = "#2b1f31",
}
-- COLORS_SCHEME
-- config.color_scheme = "hardhacker"
-- config.color_scheme = "3024 (base16)" -- good black background
-- config.color_scheme = "3024 Night (Gogh)" -- good black background
-- config.color_scheme = "Adventure" -- good black background
-- config.color_scheme = "ayu"
-- config.color_scheme = "Tomorrow Night Burns" -- black with red
-- config.color_scheme = "Tomorrow Night Bright" -- bright black
-- config.color_scheme = "tender (base16)" -- Gruvbox alt identical to colorsmech from nvim gruvbox.
config.color_scheme = "tokyonight"
-- config.color_scheme = "thwump (terminal.sexy)"
-- config.color_scheme = "Terminix Dark (Gogh)" -- identical to color_scheme from nvim yoru
-- config.color_scheme = "Yousai (terminal.sexy)"
-- config.color_scheme = "Twilight"
-- config.color_scheme = "Tinacious Design (Dark)"
-- config.color_scheme = "Thayer Bright"
-- config.color_scheme = "Apple System Colors" -- black
-- config.color_scheme = "flexoki-dark" -- pastel black
-- config.color_scheme = "iTerm2 Pastel Dark Background" -- deep black
-- config.color_scheme = "iTerm2 Smoooooth" -- pastel dark
-- config.color_scheme = "Github Dark (Gogh)" -- pastel dark
-- config.color_scheme = "Catppuccin Mocha" -- identical to colorsmech from nvim Catppuccin.
-- config.color_scheme = "Tokyo Night"
-- config.color_scheme = "Summerfruit Dark (base16)" -- pastel
-- config.color_scheme = "Vs Code Dark+ (Gogh)"
-- config.color_scheme = "Kanagawa (Gogh)"
-- config.color_scheme = "vulcan (base16)"

-- config.color_scheme = "Atlas (base16)" -- solarized warm dark
-- config.color_scheme = "Solarized Dark - Patched" -- solarized dark
-- config.color_scheme = "Solarized Dark Higher Contrast" -- solarized dark
-- config.color_scheme = "Selenized Dark (Gogh)" -- solarized

-- config.color_scheme = "Spacemacs (base16)" -- dark with red
-- config.color_scheme = "synthwave" -- black with neon
-- config.color_scheme = "Square" -- pastel
-- config.color_scheme = "Sandcastle (base16)" -- good pastel
-- config.color_scheme = "Sea Shells (Gogh)" -- pastel dark
-- config.color_scheme = "Seafoam Pastel" -- pastel green
-- config.color_scheme = "Seti UI (base16)" -- good pastel dark
-- config.color_scheme = "Silk Dark (base16)" -- light solarized
-- config.color_scheme = "Slate" -- dark pastel with neon
-- config.color_scheme = "SleepyHollow" -- dark pastel with orange
-- config.color_scheme = "Smyck" -- good pastel with lightblue
-- config.color_scheme = "Gruvbox dark, soft (base16)"
-- config.color_scheme = "GitHub Dark"
-- config.color_scheme = "Mariana"
-- config.color_scheme = "Mocha (base16)"
-- config.color_scheme = "Black Metal (Immortal) (base16)"
-- config.color_scheme = "DanQing (base16)"
-- config.color_scheme = "Dark Violet (base16)"
-- config.color_scheme = "Fahrenheit"
-- config.color_scheme = "Fideloper"
-- config.color_scheme = "Material Palenight (base16)"
-- config.color_scheme = "Monokai Remastered"
-- config.color_scheme = "Afterglow"
-- config.color_scheme = "Gruber (base16)" -- good pastel but tmux is toxic green
-- config.color_scheme = "Google Dark (base16)"
-- config.color_scheme = "Gigavolt (base16)" -- good blue pastel theme
-- config.color_scheme = "Kimber (base16)" -- good pastel
-- config.color_scheme = "Violet Dark"
-- config.color_scheme = "Vice Dark (base16)" -- almost cyberpunk theme :>
-- config.color_scheme = "Vaughn" --  interesting blue theme
-- config.color_scheme = "Twilight" -- good monochrome
-- config.color_scheme = "Atelier Cave (base16)"
-- config.color_scheme = "Ashes (base16)" -- fav pink theme
-- config.color_scheme = "Catppuccin Frappe"
-- config.color_scheme = "Catppuccin Macchiato"
-- config.color_scheme = "Ocean (base16)"
-- config.color_scheme = "OneDark (base16)"
-- config.color_scheme = "Overnight Slumber" -- now enabled
-- config.color_scheme = "Tokyo Night Moon"
-- config.color_scheme = "Everforest Dark (Gogh)"
-- config.color_scheme = "Apprentice (base16)"
-- config.color_scheme = "iceberg-dark"
-- config.color_scheme = "lovelace"

-- =============================================================================================
-- ===================================== ELSE ==================================================
-- =============================================================================================

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

-- hyperlink
-- Use the defaults as a base
-- config.hyperlink_rules = wezterm.default_hyperlink_rules()

-- make task numbers clickable
-- the first matched regex group is captured in $1.
-- table.insert(config.hyperlink_rules, {
--   regex = [[\b[tt](\d+)\b]],
--   format = 'https://example.com/tasks/?t=$1',
-- })

-- make username/project paths clickable. this implies paths like the following are for github.
-- ( "nvim-treesitter/nvim-treesitter" | wbthomason/packer.nvim | wez/wezterm | "wez/wezterm.git" )
-- as long as a full url hyperlink regex exists above this it should not match a full url to
-- github or gitlab / bitbucket (i.e. https://gitlab.com/user/project.git is still a whole clickable url)
-- table.insert(config.hyperlink_rules, {
--   regex = [[["]?([\w\d]{1}[-\w\d]+)(/){1}([-\w\d\.]+)["]?]],
--   format = 'https://www.github.com/$1/$3',
-- })
config.default_cursor_style = "SteadyBlock" -- SteadyBlock, BlinkingBlock, SteadyUnderline, BlinkingUnderline, SteadyBar, and BlinkingBar
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
return config
