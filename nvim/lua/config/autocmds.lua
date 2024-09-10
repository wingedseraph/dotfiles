-- Highlight when yanking
vim.api.nvim_create_autocmd("TextYankPost", {
	callback = function()
		vim.highlight.on_yank({ timeout = 200 })
	end,
})

-- Disable auto comment
vim.api.nvim_create_autocmd("BufEnter", {
	callback = function()
		vim.opt.formatoptions = { c = false, r = false, o = false }
	end,
})

-- keymap for .cpp file
vim.api.nvim_create_autocmd("BufEnter", {
	pattern = { "*.cpp", "*.cc" },
	callback = function()
		vim.keymap.set("n", "<Leader>e", ":terminal ./a.out<CR>", { silent = true })
		-- vim.keymap.set("n", "<Leader>e", ":!./sfml-app<CR>",
		--    { silent = true })
	end,
})

vim.api.nvim_create_autocmd("BufEnter", {
	pattern = { "*.md" },
	callback = function()
		vim.opt_local.conceallevel = 2
	end,
})
-- tab format for .lua file
vim.api.nvim_create_autocmd("BufEnter", {
	pattern = { "*.lua" },
	callback = function()
		vim.opt.shiftwidth = 3
		vim.opt.tabstop = 3
		vim.opt.softtabstop = 3
		-- vim.opt_local.colorcolumn = {70, 80}
	end,
})

-- keymap for .go file
vim.api.nvim_create_autocmd("BufEnter", {
	pattern = { "*.go" },
	callback = function()
		vim.keymap.set("n", "<Leader>e", ":terminal go run %<CR>", { silent = true })
	end,
})

-- keymap for .py file
vim.api.nvim_create_autocmd("BufEnter", {
	pattern = { "*.py" },
	callback = function()
		vim.keymap.set("n", "<Leader>e", ":terminal python3 %<CR>", { silent = true })
	end,
})

-- keymap for .ino file
vim.api.nvim_create_autocmd("BufEnter", {
	pattern = { "*.ino" },
	callback = function()
		vim.keymap.set(
			"n",
			"<Leader>c",
			":terminal arduino-cli compile --fqbn arduino:avr:uno %<CR>",
			{ silent = true }
		)
		vim.keymap.set(
			"n",
			"<Leader>u",
			":terminal arduino-cli upload -p /dev/ttyACM0 --fqbn arduino:avr:uno %<CR>",
			{ silent = true }
		)
		vim.keymap.set("n", "<Leader>m", ":terminal arduino-cli monitor -p /dev/ttyACM0<CR>", { silent = true })
	end,
})

-- adapted from https://github.com/ethanholz/nvim-lastplace/blob/main/lua/nvim-lastplace/init.lua
local ignore_buftype = { "quickfix", "nofile", "help", "terminal", "lazy" }
local ignore_filetype = { "gitcommit", "gitrebase", "svn", "hgcommit", "lazy" }

local function run()
	if vim.tbl_contains(ignore_buftype, vim.bo.buftype) then
		return
	end

	if vim.tbl_contains(ignore_filetype, vim.bo.filetype) then
		-- reset cursor to first line
		vim.cmd([[normal! gg]])
		return
	end

	-- If a line has already been specified on the command line, we are done
	--   nvim file +num
	if vim.fn.line(".") > 1 then
		return
	end

	local last_line = vim.fn.line([['"]])
	local buff_last_line = vim.fn.line("$")

	-- If the last line is set and the less than the last line in the buffer
	if last_line > 0 and last_line <= buff_last_line then
		local win_last_line = vim.fn.line("w$")
		local win_first_line = vim.fn.line("w0")
		-- Check if the last line of the buffer is the same as the win
		if win_last_line == buff_last_line then
			-- Set line to last line edited
			vim.cmd([[normal! g`"]])
		-- Try to center
		elseif buff_last_line - last_line > ((win_last_line - win_first_line) / 2) - 1 then
			vim.cmd([[normal! g`"zz]])
		else
			vim.cmd([[normal! G'"<c-e>]])
		end
	end
end

vim.api.nvim_create_autocmd({ "BufWinEnter", "FileType" }, {
	group = vim.api.nvim_create_augroup("nvim-lastplace", {}),
	callback = run,
})

-- To make :help | only the default behavior, you can use autocmd:
vim.api.nvim_create_autocmd("FileType", {
	pattern = { "help" },
	command = "wincmd o",
})

-- change working directory
vim.api.nvim_create_augroup("WorkingDirectory", { clear = true })
vim.api.nvim_create_autocmd({ "BufEnter" }, {
	pattern = { "*.*" },
	callback = function()
		local path = vim.fn.expand("%:h") .. "/"
		path = "cd " .. path
		vim.api.nvim_command(path)
	end,
	group = "WorkingDirectory",
})

-- auto-open folds when searching
function PauseFoldOnSearch()
	vim.opt.foldopen:remove({ "search" })

	vim.on_key(function(char)
		if vim.tbl_contains(ignore_buftype, vim.bo.buftype) then
			return
		end
		if vim.tbl_contains(ignore_filetype, vim.bo.filetype) then
			-- reset cursor to first line
			return
		end
		if vim.g.scrollview_refreshing then
			return
		end -- FIX https://github.com/dstein64/nvim-scrollview/issues/88#issuecomment-1570400161
		local key = vim.fn.keytrans(char)
		local isCmdlineSearch = vim.fn.getcmdtype():find("[/?]") ~= nil
		local isNormalMode = vim.api.nvim_get_mode().mode == "n"

		local searchStarted = (key == "/" or key == "?") and isNormalMode
		local searchConfirmed = (key == "<CR>" and isCmdlineSearch)
		local searchCancelled = (key == "<Esc>" and isCmdlineSearch)
		if not (searchStarted or searchConfirmed or searchCancelled or isNormalMode) then
			return
		end
		local foldsArePaused = not (vim.opt.foldenable:get())
		-- works for RHS, therefore no need to consider remaps
		local searchMovement = vim.tbl_contains({ "n", "N", "*", "#" }, key)

		local pauseFold = (searchConfirmed or searchStarted or searchMovement) and not foldsArePaused
		local unpauseFold = foldsArePaused and (searchCancelled or not searchMovement)
		if pauseFold then
			vim.opt_local.foldenable = false
		elseif unpauseFold then
			vim.opt_local.foldenable = true
			pcall(vim.cmd.foldopen, { bang = true }) -- after closing folds, keep the *current* fold open
		end
	end, vim.api.nvim_create_namespace("auto_pause_folds"))
end

PauseFoldOnSearch()

-- Disable folds in lazy, mason,etc
vim.api.nvim_create_autocmd("FileType", {
	pattern = { "lazy", "lspinfo", "mason" }, -- Specify the filetypes here
	callback = function()
		vim.opt_local.foldlevel = 99
		vim.opt_local.foldmethod = "manual" -- or "none" to completely disable folding
		vim.opt_local.foldenable = false
		vim.opt_local.cursorline = true
	end,
})
-- Close help with q or esc
vim.api.nvim_create_autocmd("FileType", {
	pattern = "help", -- Specify the 'help' filetype
	callback = function()
		vim.keymap.set("n", "q", ":bd!<CR>", { buffer = true, silent = true })
		vim.keymap.set("n", "<ESC>", ":bd!<CR>", { buffer = true, silent = true })
	end,
})
function SetupHistory()
	vim.defer_fn(function()
		vim.cmd("FzfLua oldfiles")
	end, 50)
end

-- Function to save cursor position, trim whitespaces, and restore cursor position
local function trim_whitespace_and_restore_cursor()
	-- Save the current cursor position
	local pos = vim.api.nvim_win_get_cursor(0)
	-- Trim trailing whitespaces
	vim.cmd([[
    %s/\s\+$//e
  ]])
	-- Restore the cursor position
	vim.api.nvim_win_set_cursor(0, pos)
end
vim.api.nvim_create_autocmd("BufWritePre", {
	pattern = "*",
	callback = trim_whitespace_and_restore_cursor,
})

-- Toggle autosave state
local autosave_enabled = false
local function toggle_autosave()
	vim.cmd(autosave_enabled and [[
    augroup AutoSave
      autocmd!
    augroup END
  ]] or [[
    augroup AutoSave
      autocmd!
      autocmd InsertLeave * :lua vim.cmd('write')
    augroup END
  ]])
	autosave_enabled = not autosave_enabled
	print("Autosave " .. (autosave_enabled and "enabled" or "disabled"))
end

-- Create a command to toggle autosave
vim.api.nvim_create_user_command("Autosave", toggle_autosave, {})

-- vim.api.nvim_create_autocmd("TermOpen", {
-- 	pattern = "*",
-- 	callback = function()
-- 		vim.cmd("startinsert")
-- 	end,
-- })

-- Close terminal buffer on process exit
vim.api.nvim_create_autocmd("BufLeave", {
	pattern = "term://*",
	command = "stopinsert",
})

function AddConsoleLog()
	local line = vim.api.nvim_win_get_cursor(0)[1]
	local text = vim.api.nvim_get_current_line()

	-- Determine the variable name
	local variable = string.match(text, "%s*(%a[%w_]*)%s*=")
	if not variable then
		variable = string.match(text, "%s*(%a[%w_]*)%s*$")
	end

	if variable then
		-- Construct the console.log statement
		local logStatement = string.format("console.log('%s: ', %s)", variable, variable)

		-- Insert the console.log statement below the variable
		vim.api.nvim_buf_set_lines(0, line, line, false, { logStatement })

		-- run the formatter
		-- vim.lsp.buf.format()
	else
		print("No variable found at the current line.")
	end
end

vim.api.nvim_set_keymap("n", "<Leader>cl", ":lua AddConsoleLog()<CR>", { noremap = true, silent = true })
vim.api.nvim_create_autocmd({ "UIEnter", "ColorScheme" }, {
	callback = function()
		local normal = vim.api.nvim_get_hl(0, { name = "Normal" })
		if not normal.bg then
			return
		end
		io.write(string.format("\027]11;#%06x\027\\", normal.bg))
	end,
})

vim.api.nvim_create_autocmd("UILeave", {
	callback = function()
		io.write("\027]111\027\\")
	end,
})

local scrolloff_percentage = 0.2
vim.api.nvim_create_autocmd({ "WinResized", "BufEnter" }, {
	callback = function()
		vim.opt.scrolloff = math.floor(vim.o.lines * scrolloff_percentage)
	end,
})

-- Create an augroup to encapsulate the autocmds
local insertonenter = vim.api.nvim_create_augroup("insertonenter", { clear = true })

-- Define the function to enter insert mode if the buffer is a terminal
local function InsertOnTerminal()
	if vim.bo.buftype == "terminal" then
		vim.cmd("startinsert")
	end
end

-- Create an autocmd for BufEnter to call the InsertOnTerminal function
vim.api.nvim_create_autocmd("BufEnter", {
	group = insertonenter,
	pattern = "*",
	callback = InsertOnTerminal,
})

-- Create an autocmd for TermOpen to call the InsertOnTerminal function (if in Neovim)
vim.api.nvim_create_autocmd("TermOpen", {
	group = insertonenter,
	pattern = "*",
	callback = InsertOnTerminal,
})
vim.api.nvim_create_autocmd("ColorScheme", {
	callback = function()
		vim.cmd.hi("clear IndentBlanklineContextStart")
		vim.cmd.hi("link IndentBlanklineContextStart Visual")
	end,
})
