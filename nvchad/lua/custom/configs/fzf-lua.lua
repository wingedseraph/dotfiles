-- Map keybindings
vim.api.nvim_set_keymap("n", "<M-d>", ":FzfLua files<CR>", { noremap = true, silent = true })
vim.api.nvim_set_keymap("n", "<M-o>", ":FzfLua oldfiles<CR>", { noremap = true, silent = true })
vim.api.nvim_set_keymap("n", "<leader>o", ":FzfLua oldfiles<CR>", { noremap = true, silent = true })
vim.api.nvim_set_keymap("n", "<leader>ff", ":FzfLua files<CR>", { noremap = true, silent = true })
vim.api.nvim_set_keymap("n", "<leader>fw", ":FzfLua live_grep<CR>", { noremap = true, silent = true })
vim.api.nvim_set_keymap("n", "<leader>b", ":FzfLua buffers<CR>", { noremap = true, silent = true })
vim.api.nvim_set_keymap("n", "<leader>/", ":FzfLua lgrep_curbuf<CR>", { noremap = true, silent = true })
vim.api.nvim_set_keymap("n", "<leader>L", ":FzfLua lines<CR>", { noremap = true, silent = true })
vim.api.nvim_set_keymap("n", "<leader>'", ":FzfLua marks<CR>", { noremap = true, silent = true })
vim.api.nvim_set_keymap("n", "<leader>H", ":FzfLua help_tags<CR>", { noremap = true, silent = true })
vim.api.nvim_set_keymap("n", "<leader>k", ":FzfLua keymaps<CR>", { noremap = true, silent = true })
-- calling `setup` is optional for customization
require("fzf-lua").setup({
	winopts = {
		width = 1,
		height = 1,
		border = "none",
	},
})
