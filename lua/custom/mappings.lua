---@type MappingsTable
local M = {}
-- Use wslview for gx in WSL
-- @not need for mac
-- if vim.fn.has("unix") then
-- 	vim.g.netrw_browsex_viewer = "wslview"
-- end
----------------------------------Function----------------------------------
function ToggleTabline()
	-- Check if the tabline is currently visible
	local tabline_visible = vim.o.showtabline

	-- Toggle the visibility of the tabline
	if tabline_visible == 2 then
		-- If tabline is currently visible, hide it
		vim.o.showtabline = 0
	else
		-- If tabline is currently hidden, show it
		vim.o.showtabline = 2
	end
end
-- Define a function to determine the file type and execute the appropriate command
function RunFile()
	local file_type = vim.bo.filetype
	if file_type == "javascript" or file_type == "jsx" then
		vim.cmd("!node %")
	elseif file_type == "go" then
		vim.cmd("!go run %")
	elseif file_type == "python" then
		vim.cmd("!python3 % ")
	elseif file_type == "c" or file_type == "cpp" then
		vim.cmd("!gcc % && ./a.out")
	else
		print("unsupported file type")
	end
end
function Zen()
	vim.cmd("set laststatus=2")
	vim.opt.showmode = true
	-- vim.o.statusline = "%f %m %r%{&filetype}"
	-- vim.o.statusline = "%<%f %h%m%r%=%-14.(%l,%c%V%) %p%%"
	-- vim.o.statusline = "%<%f %h%m%r%=%-14.(%l,%c%V%) [%{&filetype}]"
	vim.o.statusline = vim.cmd("echo &statusline | set statusline&vi | echo &statusline")
	-- vim.o.statusline = "%<%f %m%r%y %LL " .. "%=" .. " 0x%-4.B %-16.(%lL,%cC%V,%oB%) %P"
	-- vim.o.showtabline = 0
	vim.opt.number = false
	vim.opt.relativenumber = false
end
function DisableStatusLine()
	vim.o.laststatus = 0
end
function GitStatusLine()
	if not vim.b.gitsigns_head or vim.b.gitsigns_git_status then
		return ""
	end
	local git_status = vim.b.gitsigns_status_dict
	local added = (git_status.added and git_status.added ~= 0) and ("  " .. git_status.added) or ""
	local changed = (git_status.changed and git_status.changed ~= 0) and ("  " .. git_status.changed) or ""
	local removed = (git_status.removed and git_status.removed ~= 0) and ("  " .. git_status.removed) or ""
	local branch_name = "  " .. git_status.head
	return branch_name .. added .. changed .. removed
end

function LSPDiagnostic()
	if not rawget(vim, "lsp") then
		return ""
	end

	local errors = #vim.diagnostic.get(0, { severity = vim.diagnostic.severity.ERROR })
	local warnings = #vim.diagnostic.get(0, { severity = vim.diagnostic.severity.WARN })
	local hints = #vim.diagnostic.get(0, { severity = vim.diagnostic.severity.HINT })
	local info = #vim.diagnostic.get(0, { severity = vim.diagnostic.severity.INFO })

	errors = (errors and errors > 0) and (" " .. errors .. " ") or ""
	warnings = (warnings and warnings > 0) and ("  " .. warnings .. " ") or ""
	hints = (hints and hints > 0) and ("󰛩 " .. hints .. " ") or ""
	info = (info and info > 0) and ("󰋼 " .. info .. " ") or ""

	return errors .. warnings .. hints .. info
end

function LSPStatus()
	if rawget(vim, "lsp") then
		for _, client in ipairs(vim.lsp.get_active_clients()) do
			if client.attached_buffers[vim.api.nvim_get_current_buf()] and client.name ~= "null-ls" then
				return (vim.o.columns > 100 and "~ " .. client.name .. " ") or client.name
			end
		end
	end
end

------------------------------------------------MappingsTable------------------------------------------------
-- vim.lsp.buf.format({ async = true })
M.general = {
	n = {
		-- ["p"] = { "P", "paste without copy to register", opts = { nowait = true } },
		["<M-n>"] = {
			"<cmd>Yazi<cr>",
			-- "<cmd>Lf<cr>",
			"file manager",
			opts = { nowait = true },
		},

		["<tab>"] = {
			"<cmd>bnext<cr>",
			"next buffer",
			opts = { nowait = true },
		},
		["<S-tab>"] = {
			"<cmd>bprevious<cr>",
			"previous buffer",
			opts = { nowait = true },
		},

		["N"] = {
			"nzz",
			"Bring search results to midscreen",
			opts = { nowait = true },
		},
		["n"] = {
			"nzz",
			"Bring search results to midscreen",
			opts = { nowait = true },
		},
		["<leader>T"] = {
			"<cmd>ToggleTerm<cr>",
			"toggle terminal",
			opts = { nowait = true },
		},
		["<leader>tb"] = {
			":lua ToggleTabline()<CR>",
			"toggle tab line",
			opts = { nowait = true },
		},
		["<leader>Key"] = {
			"<cmd>Telescope keymaps <CR>",
			"[T]elescope [K]eymaps",
			opts = { nowait = true },
		},
		["<leader>e"] = { "<cmd>:lua RunFile()<CR>", "run node or c compiler", opts = { nowait = true } },
		["<leader>rr"] = { "<cmd>SnipClose<CR>", "[S]nip [C]lose", opts = { nowait = true } },
		["<leader>lg"] = { "<cmd>LazyGit<CR>", "lazygit", opts = { nowait = true } },
		["<leader>ww"] = { "<cmd>set wrap!<CR>", "toggle wrap", opts = { nowait = true } },
		["<leader>z"] = { "<cmd>lua Zen()<CR>", "[Z]en [M]ode", opts = { nowait = true } },
		-- ["<A-b>"] = { ":Lexplore<CR>", "[T]oggle [N]etrw", opts = { nowait = true } },
		["<A-e>"] = { "<cmd>:lua RunFile()<CR>", "run node or c compiler", opts = { nowait = true } },
		["sj"] = { "<C-w>w", "cycle through windows", opts = { nowait = true } },
		["<leader>j"] = { "<C-w>w", "cycle through windows", opts = { nowait = true } },
		-- TODO: подумать как лучше оформить: открытие в нынешнем буффере
		-- либо открыть в новом и сразу перейти в этот буффер
		["<leader>n"] = { "<cmd>e $HOME/notes/norg/index.norg<cr>", "edit neorg notes index", opts = { nowait = true } },
		["gt"] = { "<cmd>bnext<CR>", "Next Buffer", opts = { nowait = true } },
		-- ["<tab>"] = { "<cmd>bnext<CR>", "next buffer", opts = { nowait = true } },
		-- ["<C-s>"] = { ":w<CR>", "[S]ave [F]ile", opts = { nowait = true } },
		-- ["<M-b>"] = { "<cmd>Oil<CR>", "[O]il", opts = { nowait = true } },
		["<C-q>"] = { "<cmd>q!<CR>", "quit without save", opts = { nowait = true } },
		-- ["<C-v>"] = { "P", "PASTE", opts = { nowait = true } },
		["<C-z>"] = { "u", "[U]ndo", opts = { nowait = true } },
		["<C-a>"] = { "gg<S-v>G", "[S]elect [A]ll", opts = { nowait = true } },
		-- ["<F1>"] = { "<cmd> Telescope find_files <CR>", "Live grep" },
		-- ["<F2>"] = { "<cmd> Telescope live_grep <CR>", "Live grep" },
		["NN"] = { "<cmd>tabnew $MYVIMRC<CR>", "Open init.lua", opts = { nowait = true } },
		[";"] = { ":", "enter command mode", opts = { nowait = true } },
		["1"] = { "$", "go to end of line", opts = { nowait = true } },

		-- probably working :x
		-- ["gx"] = {
		-- 	function()
		-- 		local cursor_position = vim.fn.getpos(".")
		-- 		local line = vim.fn.getline(cursor_position[2])
		-- 		-- https://doka.guide/
		-- 		local start_col, end_col = string.find(line, "https://[^ %c}]*")
		-- 		if start_col then
		-- 			local url = string.sub(line, start_col, end_col):gsub("[%c)}]+$", "") -- Remove trailing symbols after ')' and '}'
		-- 			local formatted_url = '"' .. url .. '"' -- Wrap URL in quotes to better work with open
		--
		-- 			if vim.fn.has("clipboard") == 1 then
		-- 				vim.fn.setreg("+", url) -- Use system clipboard
		-- 			else
		-- 				vim.fn.setreg('"', url) -- Fallback to default register
		-- 			end
		-- 			-- print(url)
		-- 			-- print(formatted_url)
		-- 			vim.cmd("silent !open " .. formatted_url)
		-- 		else
		-- 			print("no url found under the cursor")
		-- 		end
		-- 	end,
		-- 	"copy yank url under cursor to system clipboard and remove trailing symbols after '}'",
		-- 	opts = { nowait = true },
		-- },
	},
	v = {
		["<C-c>"] = { '"+y', "[C]opy", opts = { nowait = true } },
		-- ["<C-v>"] = { "P", "PASTE", opts = { nowait = true } },

		["<leader>rr"] = { ":SnipRun<CR>", "[S]nip [R]un", opts = { nowait = true } },
		[">"] = { ">gv", "indent" },
		["ge"] = { "G", "[L]ast [Line]", opts = { nowait = true } },
		["p"] = { "P", "paste without copy to register", opts = { nowait = true } },
		["1"] = { "$h", "go to end of line", opts = { nowait = true } },
	},
	i = {
		-- ["jj"] = { "<Esc>", "Next Buffer", opts = { nowait = true } },
	},
}

-- [[ Highlight on yank ]]
-- See `:help vim.highlight.on_yank()`
local highlight_group = vim.api.nvim_create_augroup("YankHighlight", { clear = true })
vim.api.nvim_create_autocmd("TextYankPost", {
	callback = function()
		vim.highlight.on_yank()
	end,
	group = highlight_group,
	pattern = "*",
})

return M
