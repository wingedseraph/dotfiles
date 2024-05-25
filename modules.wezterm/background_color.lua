local color_schemes = {
	{ name = "solarized", background = "#002b36" },
	{ name = "yellow-moon_vim", background = "#2a2e38" },
	{ name = "sunburn", background = "#181818" },
	{ name = "vscode", background = "#1e1e1e" },
	{ name = "kanagawa", background = "#1f1f28" },
	{ name = "mini_hue_green", background = "#10262c" },
	{ name = "mini_hue_purple", background = "#2b1f31" },
	{ name = "mini_hue_azure", background = "#002734" },
	{ name = "adwaita", background = "#1d1d1d" },
	{ name = "monochrome", background = "#101010" },
	{ name = "github_dark", background = "#24292e" },
	{ name = "base_16_vulcan", background = "#041320" },
	{ name = "lunaperche_and_base16-black-metal-gorgoroth_and_sun", background = "#000000" },
	{ name = "nvim_colorscheme_retrobox", background = "#1c1c1c" },
	{ name = "github_colorscheme", background = "#22272e" },
	{ name = "minischeme", background = "#112641" },
	{ name = "catppuccin", background = "#24273a" },
}

-- Function to select a color scheme by name or index
local function select_color_scheme(identifier)
	if type(identifier) == "number" then
		return color_schemes[identifier] and color_schemes[identifier].background or nil
	elseif type(identifier) == "string" then
		for _, scheme in ipairs(color_schemes) do
			if scheme.name == identifier or scheme.background == identifier then
				return scheme.background
			end
		end
	end
	return nil
end

-- Example usage
-- local selected_color_scheme = select_color_scheme(17) -- Select by index
-- local selected_color_scheme = select_color_scheme("#112641") -- Select by color code
local selected_color_scheme = select_color_scheme("catppuccin") -- Select by name

return selected_color_scheme
