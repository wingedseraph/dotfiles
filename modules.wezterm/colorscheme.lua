local color_schemes = {
	"hardhacker",
	"3024 (base16)", -- good black background
	"3024 Night (Gogh)", -- good black background
	"Adventure", -- good black background
	"ayu",
	"Tomorrow Night Burns", -- black with red
	"Tomorrow Night Bright", -- bright black
	"tender (base16)", -- Gruvbox alt identical to colorsmech from nvim gruvbox
	"tokyonight",
	"thwump (terminal.sexy)",
	"Terminix Dark (Gogh)", -- identical to color_scheme from nvim yoru
	"Yousai (terminal.sexy)",
	"Twilight",
	"Tinacious Design (Dark)",
	"Thayer Bright",
	"Apple System Colors", -- black
	"flexoki-dark", -- pastel black
	"iTerm2 Pastel Dark Background", -- deep black
	"iTerm2 Smoooooth", -- pastel dark
	"Github Dark (Gogh)", -- pastel dark
	"Catppuccin Mocha", -- identical to colorsmech from nvim Catppuccin
	"Tokyo Night",
	"Summerfruit Dark (base16)", -- pastel
	"Vs Code Dark+ (Gogh)",
	"Kanagawa (Gogh)",
	"vulcan (base16)",
	"Atlas (base16)", -- solarized warm dark
	"Solarized Dark - Patched", -- solarized dark
	"Solarized Dark Higher Contrast", -- solarized dark
	"Selenized Dark (Gogh)", -- solarized
	"Spacemacs (base16)", -- dark with red
	"synthwave", -- black with neon
	"Square", -- pastel
	"Sandcastle (base16)", -- good pastel
	"Sea Shells (Gogh)", -- pastel dark
	"Seafoam Pastel", -- pastel green
	"Seti UI (base16)", -- good pastel dark
	"Silk Dark (base16)", -- light solarized
	"Slate", -- dark pastel with neon
	"SleepyHollow", -- dark pastel with orange
	"Smyck", -- good pastel with lightblue
	"Gruvbox dark, soft (base16)",
	"GitHub Dark",
	"Mariana",
	"Black Metal (Immortal) (base16)",
	"DanQing (base16)",
	"Dark Violet (base16)",
	"Fahrenheit",
	"Fideloper",
	"Material Palenight (base16)",
	"Monokai Remastered",
	"Afterglow",
	"Gruber (base16)", -- good pastel but tmux is toxic green
	"Google Dark (base16)",
	"Gigavolt (base16)", -- good blue pastel theme
	"Kimber (base16)", -- good pastel
	"Violet Dark",
	"Vice Dark (base16)", -- almost cyberpunk theme :>
	"Vaughn", --  interesting blue theme
	"Twilight", -- good monochrome
	"Atelier Cave (base16)",
	"Ashes (base16)", -- fav pink theme
	"Catppuccin Frappe",
	"Catppuccin Macchiato",
	"Ocean (base16)",
	"OneDark (base16)",
	"Overnight Slumber", -- now enabled
	"Tokyo Night Moon",
	"Everforest Dark (Gogh)",
	"Apprentice (base16)",
	"iceberg-dark",
	"lovelace",
}

-- Function to select a color scheme by name or index
local function select_color_scheme(identifier)
	if type(identifier) == "number" then
		return color_schemes[identifier]
	elseif type(identifier) == "string" then
		for _, scheme in ipairs(color_schemes) do
			if scheme == identifier then
				return scheme
			end
		end
	end
	return nil
end

-- Example usage
-- local selected_color_scheme = select_color_scheme(25) -- Select by index
local selected_color_scheme = select_color_scheme("Slate") -- Select by name

return selected_color_scheme
