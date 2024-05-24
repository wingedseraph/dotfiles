local wezterm = require("wezterm")

local M = {}

function M.set_font(config)
	-- local font = "Brutalist Mono"
	-- local font = "Anonymous Pro"
	-- local font = "Dank Mono"
	-- local font = "VictorMono Nerd Font Mono"
	-- local font = "MonoLisa Nerd Font Mono"
	-- local font = "Monaspace Krypton"
	-- local font = "Monaspace Argon"
	-- local font = "Monaspace Neon"
	-- local font = "Monaspace Xenon"
	local font = "Iosevka Comfy"
	-- local font = "IosevkaTerm Nerd Font"
	-- local font = "CozetteVector"
	-- local font = "Operator Mono Light"
	-- local font = "BlexMono Nerd Font"
	-- local font = "CaskaydiaCove NF"
	-- local font = "JetBrainsMono Nerd Font"
	config.font_rules = {
		{
			intensity = "Normal",
			font = wezterm.font({
				family = font,
				weight = "Regular",
			}),
		},
	}
	config.cell_width = 0.9 -- like alacritty
	-- config.line_height = 1.35
	config.font_size = 16.0
	config.front_end = "WebGpu"
	config.freetype_load_flags = "NO_HINTING"
end

return M
