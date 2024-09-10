local fn = vim.fn
-- local config = require("core.utils").load_config().ui.statusline

local function stbufnr()
	return vim.api.nvim_win_get_buf(vim.g.statusline_winid)
end

local function is_activewin()
	return vim.api.nvim_get_current_win() == vim.g.statusline_winid
end

M = {}
M.modes = {
	["n"] = { "NORMAL", "St_NormalMode" },
	["no"] = { "NORMAL (no)", "St_NormalMode" },
	["nov"] = { "NORMAL (nov)", "St_NormalMode" },
	["noV"] = { "NORMAL (noV)", "St_NormalMode" },
	["noCTRL-V"] = { "NORMAL", "St_NormalMode" },
	["niI"] = { "NORMAL i", "St_NormalMode" },
	["niR"] = { "NORMAL r", "St_NormalMode" },
	["niV"] = { "NORMAL v", "St_NormalMode" },
	["nt"] = { "NTERMINAL", "St_NTerminalMode" },
	["ntT"] = { "NTERMINAL (ntT)", "St_NTerminalMode" },

	["v"] = { "VISUAL", "St_VisualMode" },
	["vs"] = { "V-CHAR (Ctrl O)", "St_VisualMode" },
	["V"] = { "V-LINE", "St_VisualMode" },
	["Vs"] = { "V-LINE", "St_VisualMode" },
	[""] = { "V-BLOCK", "St_VisualMode" },

	["i"] = { "INSERT", "St_InsertMode" },
	["ic"] = { "INSERT (completion)", "St_InsertMode" },
	["ix"] = { "INSERT completion", "St_InsertMode" },

	["t"] = { "TERMINAL", "St_TerminalMode" },

	["R"] = { "REPLACE", "St_ReplaceMode" },
	["Rc"] = { "REPLACE (Rc)", "St_ReplaceMode" },
	["Rx"] = { "REPLACEa (Rx)", "St_ReplaceMode" },
	["Rv"] = { "V-REPLACE", "St_ReplaceMode" },
	["Rvc"] = { "V-REPLACE (Rvc)", "St_ReplaceMode" },
	["Rvx"] = { "V-REPLACE (Rvx)", "St_ReplaceMode" },

	["s"] = { "SELECT", "St_SelectMode" },
	["S"] = { "S-LINE", "St_SelectMode" },
	[""] = { "S-BLOCK", "St_SelectMode" },
	["c"] = { "COMMAND", "St_CommandMode" },
	["cv"] = { "COMMAND", "St_CommandMode" },
	["ce"] = { "COMMAND", "St_CommandMode" },
	["r"] = { "PROMPT", "St_ConfirmMode" },
	["rm"] = { "MORE", "St_ConfirmMode" },
	["r?"] = { "CONFIRM", "St_ConfirmMode" },
	["x"] = { "CONFIRM", "St_ConfirmMode" },
	["!"] = { "SHELL", "St_TerminalMode" },
}

M.mode = function()
	if not is_activewin() then
		return ""
	end

	local m = vim.api.nvim_get_mode().mode
	return "%#" .. M.modes[m][2] .. "#" .. " " .. M.modes[m][1] .. " "
end

M.fileInfoo = function()
	local icon = "󰈚 "
	local path = vim.api.nvim_buf_get_name(stbufnr())
	local name = (path == "" and "Empty ") or path:match("([^/\\]+)[/\\]*$")

	if name ~= "Empty " then
		local devicons_present, devicons = pcall(require, "nvim-web-devicons")

		if devicons_present then
			local ft_icon = devicons.get_icon(name)
			icon = (ft_icon ~= nil and ft_icon) or icon
		end

		name = " " .. name .. " "
	end

	local ok = pcall(require, "nvim-web-devicons")
	if ok then
		return "%#StText# " .. icon .. name
	else
		return "%#StText# " .. name
	end
end

M.git = function()
	if not vim.b[stbufnr()].gitsigns_head or vim.b[stbufnr()].gitsigns_git_status then
		return ""
	end

	return "  " .. vim.b[stbufnr()].gitsigns_status_dict.head .. "  "
end

M.gitchangess = function()
	if not vim.b[stbufnr()].gitsigns_head or vim.b[stbufnr()].gitsigns_git_status or vim.o.columns < 120 then
		return ""
	end

	local git_status = vim.b[stbufnr()].gitsigns_status_dict

	local added = (git_status.added and git_status.added ~= 0) and ("%#St_lspInfo#  " .. git_status.added .. " ")
		or ""
	local changed = (git_status.changed and git_status.changed ~= 0)
			and ("%#St_lspWarning#  " .. git_status.changed .. " ")
		or ""
	local removed = (git_status.removed and git_status.removed ~= 0)
			and ("%#St_lspError#  " .. git_status.removed .. " ")
		or ""

	return (added .. changed .. removed) ~= "" and (added .. changed .. removed .. " | ") or ""
end

-- LSP STUFF
M.LSP_progress = function()
	if not rawget(vim, "lsp") or vim.lsp.status or not is_activewin() then
		return ""
	end

	local Lsp = vim.lsp.util.get_progress_messages()[1]

	if vim.o.columns < 120 or not Lsp then
		return ""
	end

	if Lsp.done then
		vim.defer_fn(function()
			vim.cmd.redrawstatus()
		end, 1000)
	end

	local msg = Lsp.message or ""
	local percentage = Lsp.percentage or 0
	local title = Lsp.title or ""
	local spinners = { "", "󰪞", "󰪟", "󰪠", "󰪢", "󰪣", "󰪤", "󰪥" }
	---@diagnostic disable-next-line: undefined-field
	local ms = vim.uv.hrtime() / 1e6
	local frame = math.floor(ms / 120) % #spinners
	local content = string.format(" %%<%s %s %s (%s%%%%) ", spinners[frame + 1], title, msg, percentage)

	-- if config.lsprogress_len then
	-- 	content = string.sub(content, 1, config.lsprogress_len)
	-- end

	return ("%#St_LspProgress#" .. content) or ""
end

M.LSP_Diagnostics_ = function()
	if not rawget(vim, "lsp") then
		-- return "%#St_lspError# 󰅚 0 %#St_lspWarning# 0"
		return ""
	end

	local errors = #vim.diagnostic.get(stbufnr(), { severity = vim.diagnostic.severity.ERROR })
	local warnings = #vim.diagnostic.get(stbufnr(), { severity = vim.diagnostic.severity.WARN })
	local hints = #vim.diagnostic.get(stbufnr(), { severity = vim.diagnostic.severity.HINT })
	local info = #vim.diagnostic.get(stbufnr(), { severity = vim.diagnostic.severity.INFO })

	---@diagnostic disable-next-line: cast-local-type
	errors = (errors > 0) and ("%#St_lspError#󰅚 " .. errors .. " ") or ""
	---@diagnostic disable-next-line: cast-local-type
	warnings = (warnings > 0) and ("%#St_lspWarning# " .. warnings .. " ") or ""
	---@diagnostic disable-next-line: cast-local-type
	hints = (hints > 0) and ("%#St_lspHints#󰛩 " .. hints .. " ") or ""
	---@diagnostic disable-next-line: cast-local-type
	info = (info > 0) and ("%#St_lspInfo# " .. info .. " ") or ""

	-- return vim.o.columns > 140 and errors .. warnings .. hints .. info or ""
	return errors .. (warnings .. (hints .. (info or "")))
end

M.filetype_ = function()
	local ft = vim.bo[stbufnr()].ft
	return ft == "" and "%#St_ft# {} plain text  " or "%#St_ft#{} " .. ft .. " "
end

M.LSP_status_ = function()
	if rawget(vim, "lsp") then
		for _, client in ipairs(vim.lsp.get_active_clients()) do
			if client.attached_buffers[stbufnr()] and client.name ~= "null-ls" then
				return (vim.o.columns > 100 and "%#St_LspStatus# 󰄭  " .. client.name .. "  ")
					or "%#St_LspStatus# 󰄭  LSP  "
			end
		end
	end

	return ""
end

M.cursor_position_ = function()
	local num_lines = vim.fn.line("$")
	local num_digits = string.len(num_lines)
	return vim.o.columns > 140 and "%#StText# Ln %0" .. num_digits .. "l/%L " or ""

	-- return vim.o.columns > 140 and "%#StText# Ln %l, Col %c  " or ""
	-- return vim.o.columns > 140 and "%#StText# Ln %l " or ""
end

M.file_encoding = function()
	local encode = vim.bo[stbufnr()].fileencoding
	return string.upper(encode) == "" and "" or "%#St_encode#" .. string.upper(encode) .. "  "
end

M.cwd = function()
	local dir_name = "%#St_cwd# 󰉖 " .. fn.fnamemodify(fn.getcwd(), ":t") .. " "
	return (vim.o.columns > 85 and dir_name) or ""
end

M.lsp_msg = function()
	-- if version < 10 then
	--   return ""
	-- end

	local msg = vim.lsp.status()

	if #msg == 0 or vim.o.columns < 120 then
		return ""
	end
	local spinners = { "", "󰪞", "󰪟", "󰪠", "󰪢", "󰪣", "󰪤", "󰪥" }
	-- local spinners = { "󰸶", "󰸸", "󰸷", "󰸴", "󰸵", "󰸳" }
	-- local spinners = { "", "", "", "󰺕", "", "" }
	---@diagnostic disable-next-line: undefined-field
	local ms = vim.uv.hrtime() / 1e6
	local frame = math.floor(ms / 100) % #spinners

	return spinners[frame + 1] .. " " .. msg
end
M.buf_flag = function()
	-- [+][RO]
	-- return H.add_highlight2("ErrorMsg", "%m") .. H.add_highlight2("WarningMsg", "%r")
	return string.format("%s ", "%m")
end
M.lsp_ = function()
	if rawget(vim, "lsp") then
		for _, client in ipairs(vim.lsp.get_clients()) do
			if client.attached_buffers[M.stbufnr()] then
				return (vim.o.columns > 100 and "   LSP ~ " .. client.name .. " ") or "   LSP "
			end
		end
	end

	return ""
end
M.time = function()
	-- set statusline=%f\ \ \ \ \Ln:\ %l/%L\ TIME:\ %{strftime('%c')}"
	return vim.fn.strftime("%H:%M ")
end
M.run = function()
	vim.o.showmode = false

	local modules = {
		M.mode(),
		M.fileInfoo(),
		M.buf_flag(),
		M.git(),
		M.LSP_Diagnostics_(),

		"%=",
		M.LSP_progress(),
		-- M.lsp_msg(), -- lsp +5 ms
		-- M.lsp_(),
		"%=",

		M.gitchangess(),
		M.cursor_position_(),
		-- M.file_encoding(),
		-- M.filetype_(),
		M.LSP_status_(),
		M.time(),
		-- M.cwd(),
	}

	-- if config.overriden_modules then
	-- 	config.overriden_modules(modules)
	-- end

	return table.concat(modules)
end
vim.api.nvim_create_autocmd("LspProgress", {
	callback = function(args)
		if string.find(args.match, "end") then
			vim.cmd("redrawstatus")
		end
		vim.cmd("redrawstatus")
	end,
})
vim.opt.statusline = "%!v:lua.M.run()"
vim.go.laststatus = 3

return M
