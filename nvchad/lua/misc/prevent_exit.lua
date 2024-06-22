-- Global variable to track the state
_G.can_exit_neovim = true

-- Function to prevent exiting when can_exit_neovim is false
function prevent_exit()
	if not _G.can_exit_neovim and #vim.api.nvim_tabpage_list_wins(0) == 1 then
		-- vim.api.nvim_echo({ { "Exiting Neovim is currently disabled", "ErrorMsg" } }, false, {})
		return true
	end
	return false
end

-- Function to toggle the exit state
function toggle_exit_state()
	_G.can_exit_neovim = not _G.can_exit_neovim
	if _G.can_exit_neovim then
		-- Re-enable exit commands and mappings
		vim.cmd([[command! -nargs=0 Q quit]])
		vim.cmd([[command! -nargs=0 Qa qa]])
		vim.cmd([[command! -nargs=0 Wq wq]])
		vim.cmd([[command! -nargs=0 Wqa wqa]])
		vim.api.nvim_set_keymap("n", "ZZ", ":wq<CR>", { noremap = true, silent = true })
		vim.api.nvim_del_keymap("n", "<C-q>")
		vim.api.nvim_echo({ { "Exiting Neovim is enabled", "Normal" } }, false, {})
	else
		-- Disable exit commands and mappings
		vim.cmd([[command! -nargs=0 Q echo "Exiting Neovim is currently disabled"]])
		vim.cmd([[command! -nargs=0 Qa echo "Exiting Neovim is currently disabled"]])
		vim.cmd([[command! -nargs=0 Wq echo "Exiting Neovim is currently disabled"]])
		vim.cmd([[command! -nargs=0 Wqa echo "Exiting Neovim is currently disabled"]])
		vim.api.nvim_set_keymap(
			"n",
			"ZZ",
			':echo "Exiting Neovim is currently disabled"<CR>',
			{ noremap = true, silent = true }
		)
		-- vim.api.nvim_set_keymap("n", "<C-q>", "<Nop>", { noremap = true, silent = true })
		-- vim.api.nvim_echo({ { "Exiting Neovim is disabled", "WarningMsg" } }, false, {})
	end
end
vim.defer_fn(function()
	toggle_exit_state()
end, 100)
-- Bind a key to toggle the exit state
vim.api.nvim_set_keymap("n", "<leader>te", ":lua toggle_exit_state()<CR>", { noremap = true, silent = true })
