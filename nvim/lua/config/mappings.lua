local function map(mode, lhs, rhs, opts)
	-- set default value if not specify
	if opts.noremap == nil then
		opts.noremap = true
	end
	if opts.silent == nil then
		opts.silent = true
	end

	vim.keymap.set(mode, lhs, rhs, opts)
end

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

vim.g.mapleader = " "
vim.g.maplocalleader = " "

-- better up/down
vim.keymap.set({ "n", "x" }, "j", function()
	return vim.v.count > 0 and "j" or "gj"
end, { expr = true })
vim.keymap.set({ "n", "x" }, "k", function()
	return vim.v.count > 0 and "k" or "gk"
end, { expr = true })

map("n", "<C-u>", "<C-u>zz", {})
map("n", "<C-d>", "<C-d>zz", {})
map("n", "<C-b>", "<C-b>zz", {})
map("n", "<C-f>", "<C-f>zz", {})
map({ "v" }, "1", "$h", {})
map({ "n" }, "1", "$", {})
map("v", "<", "<gv", {})
map("v", ">", ">gv", {})

-- leader movements
map("n", "<Leader>s", ":source %<CR>", {})
map("n", "<M-e>", function()
	RunFile()
end, {})
-- system clipboard
map({ "n", "v" }, "<Leader>y", '"+y', {})
map({ "n" }, "<Leader>Y", '"+y$', {})

map("n", "<leader>st", "<cmd>StartupTime<cr>", {})
map("n", "<C-q>", "<cmd>q<cr>", {})
map("t", "<C-q>", "<cmd>bd!<cr>", {})
map("n", "<C-s>", "<cmd>update<cr>", {})
map({ "n", "v" }, "<Leader>p", '"+p', {})
map({ "n", "v" }, "<Leader>P", '"+P', {})
map({ "n" }, "<Leader>cd", "<cmd>cd %:h<cr>", {})
map({ "n" }, "<Leader>x", "<cmd>bd<cr>", {})
map({ "n" }, "<tab>", "<cmd>bnext<cr>", {})
map({ "n" }, "<S-tab>", "<cmd>bprevious<cr>", {})
map({ "n" }, "<Esc>", "<cmd>nohl<cr>", {})

map({ "n" }, "<C-a>", "gg<S-v>G", {})
map({ "n" }, "<S-tab>", "<cmd>bprevious<cr>", {})
-- may be inconvenienced by accidental sj presses in the terminal-insert
map({ "n" }, "sj", "<C-w>w", {})
map({ "t" }, "sj", "<C-\\><C-n><C-w>w", {})
vim.api.nvim_set_keymap("n", "<leader>i", "<cmd>Inspect<cr>", { noremap = true, silent = true })

-- Map Ctrl+n to exit terminal insert mode
vim.api.nvim_set_keymap("t", "<C-n>", [[<C-\><C-n>]], { noremap = true, silent = true })
-- try lint
vim.api.nvim_set_keymap("n", "<leader>ty", ":lua require('lint').try_lint()<CR>", { noremap = true, silent = true })

vim.keymap.set("n", "<leader>]", function()
	vim.diagnostic.enable(not vim.diagnostic.is_enabled())
end, { noremap = true, silent = true, desc = "toggle diagnostic" })
vim.keymap.set(
	"n",
	"<leader>cd",
	"<cmd>cd %:h<cr>",
	{ noremap = true, silent = true, desc = "change working directory to current file" }
)
vim.keymap.set("n", "J", "mzJ`z", { silent = true }) -- Don't move the cursor when using J
vim.keymap.set("n", "<leader>ww", "<cmd>set wrap!<CR>")
vim.keymap.set("n", ";", ":", { noremap = true })
vim.keymap.set({ "n", "t" }, "<A-i>", function()
	require("misc.term").toggle({
		pos = "float",
		id = "floatTerm",
		float_opts = {
			border = "rounded",
			width = 1,
			height = 0.9,
		},
	})
end, { desc = "Terminal Toggle Floating term" })

-- increment or decrement numbers
map({ "n", "v" }, "<leader>+", "<C-a>", { desc = "increment number" })
map({ "n", "v" }, "<leader>-", "<C-a>", { desc = "decrement number" })

---@diagnostic disable-next-line: lowercase-global
function fold_except_current()
	-- Get the current line number
	local current_line = vim.fn.line(".")
	-- Go to the first line and close all folds
	vim.cmd("normal! ggzM")
	-- Open folds around the current line
	vim.cmd("normal! " .. current_line .. "Gzv")
end

vim.keymap.set('n', '<C-ы>', ':w<CR>', { noremap = true, silent = true })
vim.keymap.set('i', '<C-ы>', '<Esc>:w<CR>a', { noremap = true, silent = true })
map("n", "<leader>z", ":lua fold_except_current()<CR>", { desc = "fold all except the current node" })

map("n", "<leader>T", function()
	local vsplit_exists = false
	for _, win in ipairs(vim.api.nvim_list_wins()) do
		local win_config = vim.api.nvim_win_get_config(win)
		if win_config.relative == "" and win_config.width < vim.api.nvim_get_option("columns") then
			vsplit_exists = true
			break
		end
	end
	if not vsplit_exists then
		vim.cmd("vsplit | terminal")
	else
		vim.cmd("wincmd l")
	end
	vim.fn.feedkeys("npm test\r")
end, {})

map("n", "<leader>te", function()
	local vsplit_exists = false
	for _, win in ipairs(vim.api.nvim_list_wins()) do
		local win_config = vim.api.nvim_win_get_config(win)
		if win_config.relative == "" and win_config.width < vim.api.nvim_get_option("columns") then
			vsplit_exists = true
			break
		end
	end
	if not vsplit_exists then
		vim.cmd("vsplit | terminal")
	else
		vim.cmd("wincmd l")
	end
	vim.fn.feedkeys("npm test\r")
	vim.defer_fn(function()
		vim.cmd("wincmd h")
	end, 1)
end, {})
