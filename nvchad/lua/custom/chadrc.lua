---@type ChadrcConfig
local M = {}

-- Path to overriding theme and highlights files
local highlights = require("custom.highlights")

M.ui = {
	-- new themes only with files on windows:
	-- jabuti, flexoki,  mito-laser, chadracula-evondev, nano-light, flexoki-light, material-darker, material-lighter
	-- rosepine-dawn, solarized_osaka,
	---@diagnostic disable-next-line: assign-type-mismatch
	theme = "gruvbox_light",
	theme_toggle = { "solarized_dark", "solarized_dark" },
	hl_override = highlights.override,
	hl_add = highlights.add,
}

M.plugins = "custom.plugins"

-- check core.mappings for table structure
M.mappings = require("custom.mappings")

return M
