local wezterm = require("wezterm")

local M = {}

function M.set_font(config)
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
	-- config.font = wezterm.font({ family = "IosevkaTerm Nerd Font" })
	-- config.font = wezterm.font({ family = "CozetteVector", weight = "Regular" })
	-- config.font = wezterm.font({ family = "Operator Mono Light", weight = "Regular" })
	config.font = wezterm.font({ family = "JetBrainsMono Nerd Font" })
	-- config.font = wezterm.font({ family = "DotGothic16" })
	-- config.font = wezterm.font({ family = "BlexMono Nerd Font", weight = "Regular" })
	-- config.font = wezterm.font({ family = "CaskaydiaCove NF" })

	config.cell_width = 0.9 -- like alacritty
	-- config.line_height = 1.35
	config.font_size = 16.0
	config.front_end = "WebGpu"
	config.freetype_load_flags = "NO_HINTING"
end

return M
