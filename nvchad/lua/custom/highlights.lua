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
	VisualNOS = {bg='sun',fg='black' },
	-- IncSearch = { fg = "black", bg = "pink" },
	IncSearch = { fg = "sun", bg = "none" },
	Search = { fg = "black", bg = "sun" },
	NormalFloat = { fg = "none", bg = "none" },
	FloatBorder = { fg = "none", bg = "none" },
	-- Cursor = { bg = "pink", fg = "black" },
	DiffChange = { fg = "black", bg = "pink" },
	-- CursorLine = { bg = "#2f2e3e" },
  CmpItemKindText = { fg = "none", bg = "none" },
  CmpItemKindEnum = { fg = "none", bg = "none" },
  CmpItemKindFile = { fg = "none", bg = "none" },
  CmpItemKindType = { fg = "none", bg = "none" },
  CmpItemKindUnit = { fg = "none", bg = "none" },
  CmpItemKindFunction = { fg = "none", bg = "none" },
  CmpItemKindField = { fg = "none", bg = "none" },
  CmpItemKindSnippet = { fg = "none", bg = "none" },
  CmpItemKindConstant = { fg = "none", bg = "none" },
  CmpItemKindConstructor = { fg = "none", bg = "none" },
  CmpItemKindEnumMember = { fg = "none", bg = "none" },
  CmpItemKindProperty = { fg = "none", bg = "none" },
  CmpItemKindStruct = { fg = "none", bg = "none" },
  CmpItemKindVariable = { fg = "none", bg = "none" },
  CmpItemKindKeyword = { fg = "none", bg = "none" },
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
