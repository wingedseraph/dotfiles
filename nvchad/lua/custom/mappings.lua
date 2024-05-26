---@type MappingsTable
local M = {}
local opts = { noremap = true, silent = true, nowait = true }
----------------------------------Function----------------------------------
function RunFile()
	local file_type = vim.bo.filetype
	if file_type == "javascript" or file_type == "jsx" then
		vim.cmd("!node %")
	elseif file_type == "go" then
		vim.cmd("!go run %")
	elseif file_type == "python" then
		vim.cmd("!python3 % ")
	elseif file_type == "c" then
		vim.cmd("!gcc % && ./a.out")
	elseif file_type == "cpp" then
		vim.cmd("!cpp % && ./a.out")
	else
		vim.notify("unsupported file type")
	end
end
------------------------------------------------MappingsTable------------------------------------------------
M.general = {
	n = {

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

		["<leader>e"] = { "<cmd>:lua RunFile()<CR>", "run node or c compiler", opts = { nowait = true } },
		["<leader>rr"] = { "<cmd>SnipClose<CR>", "[S]nip [C]lose", opts = { nowait = true } },
		["<leader>lg"] = { "<cmd>LazyGit<CR>", "lazygit", opts = { nowait = true } },
		["<leader>ww"] = { "<cmd>set wrap!<CR>", "toggle wrap", opts = { nowait = true } },
		-- ["<A-b>"] = { ":Lexplore<CR>", "[T]oggle [N]etrw", opts = { nowait = true } },
		["<A-e>"] = { "<cmd>:lua RunFile()<CR>", "run node or c compiler", opts = { nowait = true } },
		["sj"] = { "<C-w>w", "cycle through windows", opts = { nowait = true } },
		["<leader>j"] = { "<C-w>w", "cycle through windows", opts = { nowait = true } },
		["gt"] = { "<cmd>bnext<CR>", "Next Buffer", opts = { nowait = true } },
		-- ["<tab>"] = { "<cmd>bnext<CR>", "next buffer", opts = { nowait = true } },
		["<C-q>"] = { "<cmd>q<CR>", "quit", opts = { nowait = true } },
		-- ["<C-v>"] = { "P", "PASTE", opts = { nowait = true } },
		["<C-z>"] = { "u", "[U]ndo", opts = { nowait = true } },
		["<C-a>"] = { "gg<S-v>G", "[S]elect [A]ll", opts = { nowait = true } },
		[";"] = { ":", "enter command mode", opts = { nowait = true } },
		["1"] = { "$", "go to end of line", opts = { nowait = true } },
		-- probably working :x
		["gx"] = {
			function()
				local cursor_position = vim.fn.getpos(".")
				local line = vim.fn.getline(cursor_position[2])
				-- https://doka.guide/
				local start_col, end_col = string.find(line, "https://[^ %c}]*")
				if start_col then
					local url = string.sub(line, start_col, end_col):gsub("[%c)}]+$", "") -- Remove trailing symbols after ')' and '}'
					local formatted_url = '"' .. url .. '"' -- Wrap URL in quotes to better work with open

					if vim.fn.has("clipboard") == 1 then
						vim.fn.setreg("+", url) -- Use system clipboard
					else
						vim.fn.setreg('"', url) -- Fallback to default register
					end
					-- print(url)
					-- print(formatted_url)
					vim.cmd("silent !open " .. formatted_url)
				else
					print("no url found under the cursor")
				end
			end,
			"copy yank url under cursor to system clipboard and remove trailing symbols after '}'",
			opts = { nowait = true },
		},
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
