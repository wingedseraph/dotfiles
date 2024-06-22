-- This is a WORK-IN-PROGRESS custom implementation of a statusline.
-- Once complete, it'll replace the lualine plugin
-- Inspirational resources are as follows:
-- https://nuxsh.is-a.dev/blog/custom-nvim-statusline.html

local M = {}

-- Return the current "mode" in Neovim (see ":h mode" for more info on this regards)
local mode = function()
	local modes = {
		["n"] = "NORMAL",
		["no"] = "NORMAL",
		["v"] = "VISUAL",
		["V"] = "VISUAL BLOCK",
		["s"] = "SELECT",
		["S"] = "SELECT LINE",
		[""] = "SELECT BLOCK",
		["i"] = "INSERT",
		["ic"] = "INSERT",
		["R"] = "REPLACE",
		["Rv"] = "VISUAL REPLACE",
		["c"] = "COMMAND",
		["cv"] = "VIM EX",
		["ce"] = "EX",
		["r"] = "PROMPT",
		["rm"] = "MOAR",
		["r?"] = "CONFIRM",
		["!"] = "SHELL",
		["t"] = "TERMINAL",
	}

	local current_mode = vim.api.nvim_get_mode().mode

	return string.format(" %s", modes[current_mode]:upper())
end

-- Return the LSP diagnostics info from the client to the statusline
local diagnostics = function()
	-- Initialise the count of the diagnostic information returned by the client
	local count = {}

	-- The levels of severity of the LSP diagnostics
	local levels = {
		errors = "Error",
		warnings = "Warn",
		info = "Info",
		hints = "Hint",
	}

	for key, level in pairs(levels) do
		count[key] = vim.tbl_count(vim.diagnostic.get(0, { severity = level }))
	end

	local errors = ""
	local warnings = ""
	local hints = ""
	local info = ""
	-- TODO make vars for diagnostic icons
	-- ERROR = "E",
	-- WARN = "W",
	-- INFO = "I",
	-- HINT = "H",

	-- ERROR = "",
	-- WARN = "",
	-- INFO = " ",
	-- HINT = "",

	-- ERROR = "",
	-- WARN = "",
	-- INFO = "",
	-- HINT = "",

	if count["errors"] ~= 0 then
		errors = " %#LspDiagnosticsSignError#E " .. count["errors"]
	end

	if count["warnings"] ~= 0 then
		errors = " %#LspDiagnosticsSignWarning#W " .. count["warnings"]
	end

	if count["hints"] ~= 0 then
		errors = " %#LspDiagnosticsSignHint#H " .. count["hints"]
	end

	if count["info"] ~= 0 then
		errors = " %#LspDiagnosticsSignInformation#I " .. count["info"]
	end

	return errors .. warnings .. hints .. info .. "%#Normal#"
end

-- Return the full filename path
local filepath = function()
	local fpath = vim.fn.fnamemodify(vim.fn.expand("%"), ":~:.")

	if fpath == "" or fpath == "." then
		return " "
	end

	return string.format(" %s", fpath)
end

-- Return the current location of the cursor
local cursor_location = function()
	local line = vim.fn.line(".")
	local column = vim.fn.col(".")

	return string.format("%s:%s", line, column)
end

-- Return the filetype of the current buffer
local filetype = function()
	local ftype = vim.bo.filetype

	return string.format(" [%s]", ftype)
end
local vcs = function()
	local git_info = vim.b.gitsigns_status_dict
	if not git_info or git_info.head == "" then
		return ""
	end
	local added = git_info.added and ("%#GitSignsAdd#+" .. git_info.added .. " ") or ""
	local changed = git_info.changed and ("%#GitSignsChange#~" .. git_info.changed .. " ") or ""
	local removed = git_info.removed and ("%#GitSignsDelete#-" .. git_info.removed .. " ") or ""
	if git_info.added == 0 then
		added = ""
	end
	if git_info.changed == 0 then
		changed = ""
	end
	if git_info.removed == 0 then
		removed = ""
	end
	return table.concat({
		" ",
		added,
		changed,
		removed,
		" ",
		"%#GitSignsAdd# ",
		git_info.head,
		" %#Normal#",
	})
end
-- Render the statusline programatically
function M.render()
	return table.concat({
		mode(),
		diagnostics(),
		filepath(),
		vcs(),
		"%=",
		cursor_location(),
		filetype(),
	})
end

return M
