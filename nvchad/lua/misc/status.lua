-- TODO: rewrite statusline removing unused features and improving smooth loading and animations
local levels = {
	errors = vim.diagnostic.severity.ERROR,
	warnings = vim.diagnostic.severity.WARN,
	info = vim.diagnostic.severity.INFO,
	hints = vim.diagnostic.severity.HINT,
}

local function get_all_diagnostics(bufnr)
	local result = {}
	for k, level in pairs(levels) do
		result[k] = #vim.diagnostic.get(bufnr, { severity = level })
	end

	return result
end

local highlights = {
	reset = "%*",
	active = "%#StatusLineActiveItem#",
	error = "%#StatusLineError#",
	warning = "%#StatusLineWarning#",
	separator = "%#StatusLineSeparator#",
}

local icons = {
	error = " ",
	warning = " ",
	info = " ",
	hint = " ",
	ok = "",
}

local padding = " "
-- local separator = highlights.separator .. "│" .. highlights.reset
local alignment_group = "%="

local help_modified_read_only = "%(%h%m%r%)"
-- local virtual_column = "C%02v"

local function highlight_item(item, h)
	if item == nil then
		return nil
	end
	return h .. item .. highlights.reset
end

local function pad_item(item)
	if item == nil then
		return nil
	end
	return padding .. item .. padding
end

local function get_filename()
	local filetype = vim.bo.filetype
	if vim.api.nvim_buf_get_name(0) == "" then
		return nil
	end

	local filename

	if filetype == "help" then
		filename = '%<%{expand("%:t:r")}'
	else
		filename = '%<%{expand("%:~:.")}'
	end

	return pad_item(filename)
end

local function insert_diagnostic_part(status_parts, diagnostic, type)
	if diagnostic and diagnostic > 0 then
		if highlights[type] then
			table.insert(status_parts, highlight_item(icons[type] .. padding .. diagnostic, highlights[type]))
		else
			table.insert(status_parts, icons[type] .. padding .. diagnostic)
		end
	end
end

local progress_status = {}
local spinner_index = 1

local function lsp_progress()
	local in_progress_clients = 0
	for _, client in pairs(progress_status) do
		for _, _ in pairs(client) do
			in_progress_clients = in_progress_clients + 1
		end
	end
	if in_progress_clients > 0 then
		return true
	else
		return false
	end
end
M = {}

M.spinner_frames = {
	"",
	"",
	"",
	"",
	"",
	"",
	"",
	"",
	"",
	"",
	"",
	"",
	"",
	"",
	"",
	"",
	"",
	"",
	"",
	"",
	"",
	"",
	"",
	"",
	"",
	"",
	"",
}

local function start_timer()
	if timer == nil then
		timer = vim.uv.new_timer()
		timer:start(
			0,
			100,
			vim.schedule_wrap(function()
				if lsp_progress() then
					spinner_index = (spinner_index + 1) % #M.spinner_frames
					vim.cmd("redrawstatus!")
				elseif timer then
					spinner_index = 1
					-- TODO buggy timer
					if timer ~= nil then
						timer:close()
					end
					local function redraw_after_delay()
						vim.defer_fn(function()
							vim.cmd("redrawstatus!")
						end, 200)
					end
					redraw_after_delay()
				end
			end)
		)
	end
end
local function get_lines()
	-- pad current line number to number of digits in total lines to keep length
	-- of segment consistent
	local num_lines = vim.fn.line("$")
	local num_digits = string.len(num_lines)
	return "L%0" .. num_digits .. "l/%L"
end

vim.lsp.handlers["$/progress"] = function(_, msg, info)
	local client_id = tostring(info.client_id)
	local token = tostring(msg.token)

	if progress_status[client_id] == nil then
		progress_status[client_id] = {}
	end

	if msg.value.kind == "end" then
		progress_status[client_id][token] = nil
	else
		progress_status[client_id][token] = true
		-- TODO working bad need to rewrite
		-- start_timer()
	end
	vim.defer_fn(function()
		vim.cmd("redrawstatus!")
	end, 200)
end

-- Templated off of https://github.com/sorbet/sorbet/blob/23836cbded86135219da1b204d79675a1615cc49/vscode_extension/src/SorbetStatusBarEntry.ts#L119
vim.lsp.handlers["sorbet/showOperation"] = function(err, result, context)
	if err ~= nil then
		error(err)
		return
	end
	local message = {
		token = result.operationName,
		value = {
			kind = result.status == "end" and "end" or "begin",
			title = result.description,
		},
	}
	vim.lsp.handlers["$/progress"](err, message, context, nil)
end

local function lsp_status()
	local bufnr = 0
	-- TODO rewrite later
	if #vim.lsp.buf_get_clients(bufnr) == 0 then
		return nil
	end
	local buf_diagnostics = get_all_diagnostics(bufnr) or nil
	if buf_diagnostics == nil then
		return nil
	end

	local status_parts = {}

	insert_diagnostic_part(status_parts, buf_diagnostics.errors, "error")
	insert_diagnostic_part(status_parts, buf_diagnostics.warnings, "warning")
	insert_diagnostic_part(status_parts, buf_diagnostics.info, "info")
	insert_diagnostic_part(status_parts, buf_diagnostics.hints, "hint")

	if #status_parts == 0 then
		if lsp_progress() then
			return nil
		else
			return nil
		end
	end

	return table.concat(status_parts, " ")
end

local function progress_spinner()
	if lsp_progress() then
		return M.spinner_frames[spinner_index + 1]
	else
		return nil
	end
end

local function insert_item(t, value)
	if value then
		table.insert(t, value)
	end
end

local non_standard_filetypes = { "", "Trouble", "vimwiki", "help", "startuptime" }

local function is_standard_filetype(ft)
	local ret = true
	for _, filetype in ipairs(non_standard_filetypes) do
		if ft == nil or ft == filetype then
			ret = false
			break
		end
	end
	return ret
end

local function get_left_segment(active, standard_filetype)
	local left_segment_items = {}
	local filename = get_filename()
	local mode_code = vim.api.nvim_get_mode().mode
	local mode_map = {
		n = "normal",
		i = "insert",
		c = "command",
		v = "visual",
		V = "v-line",
		[""] = "v-block", -- ^V is a block visual mode
		t = "terminal",
		R = "replace",
	}
	local mode = mode_map[mode_code] or mode_code
	local highlighted_filename = active and highlight_item(filename, highlights.active) or filename
	insert_item(left_segment_items, mode)
	insert_item(left_segment_items, highlighted_filename)
	-- insert_item(left_segment_items, pad_item(progress_spinner()))
	insert_item(left_segment_items, pad_item(lsp_status()))
	insert_item(left_segment_items, pad_item(get_lines()))

	-- if pcall(require, "nvim-navic") then
	-- 	navic = require("nvim-navic")
	-- 	insert_item(left_segment_items, navic.get_location())
	-- end

	if standard_filetype then
		insert_item(left_segment_items, help_modified_read_only)
	end
	-- insert_item(left_segment_items, pad_item(virtual_column))
	vim.opt.showmode = false

	return table.concat(left_segment_items, padding)
end

function _G.statusline(active)
	local standard_filetype = is_standard_filetype(vim.bo.filetype)
	return table.concat({
		get_left_segment(active, standard_filetype),
	}, alignment_group)
end

function M.augroup(name, augroup_opts)
	local group = vim.api.nvim_create_augroup(name, augroup_opts)
	return function(event, opts)
		vim.api.nvim_create_autocmd(event, vim.tbl_extend("force", { group = group }, opts))
	end
end
local autocmd = M.augroup("StatusLine", { clear = true })

autocmd({ "WinEnter", "BufEnter" }, {
	pattern = "*",
	callback = function()
		vim.opt_local.statusline = [[%{%v:lua.statusline(1)%}]]
	end,
	desc = "Statusline (active)",
})

autocmd({ "WinLeave", "BufLeave" }, {
	pattern = "*",
	callback = function()
		vim.opt_local.statusline = ""
	end,
	desc = "Statusline (inactive)",
})
