-- To find any highlight groups: "<cmd> Telescope highlights"
-- Each highlight group can take a table with variables fg, bg, bold, italic, etc
-- base30 variable names can also be used as colors

local M = {}
--stylua: ignore
---@type Base46HLGroupsList
M.override = {
	Comment = {
		italic = false,
	},
	-- Visual = { bg = "#231942", fg = "white" },
	-- Visual = { bg = "#4c3743" }, -- from everforest colorscheme
	-- Visual = { bg = "#cccccc" },
	Visual = { bg = "#223249" }, -- from tokyonight colorscheme
	MoreMsg = { fg = "pink" },
	-- MatchWord = { bg = "none" },
	-- MatchParen = { bg = "none" },
	VisualNOS = {bg='blue',fg='black' },
	IncSearch = { fg = "black", bg = "pink" },
	Search = { fg = "black", bg = "pink" },
	NormalFloat = { fg = "none", bg = "none" },
	FloatBorder = { fg = "none", bg = "none" },
	-- Cursor = { bg = "pink", fg = "black" },
	DiffChange = { fg = "black", bg = "pink" },
	-- CursorLine = { bg = "#2f2e3e" },
}
--stylua: ignore
---@type HLTable
M.add = {
	NvimTreeOpenedFolderName = { fg = "green", bold = true },
	-- Visual = { fg = "green", bold = true },
	--  gitsigns
	GitSignsChange = { fg = "green" },
	GitSignsAdd = { fg = "vibrant_green" },
	GitSignsDelete = { fg = "red" },
	GitSignsText = { fg = "white", bg = "red", bold = true },
}

return M
