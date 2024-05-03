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
vim.api.nvim_set_keymap("n", "<leader>fz", "<cmd>FzfLua<cr>", { noremap = true, silent = true })
-- calling `setup` is optional for customization

require("fzf-lua").setup({
	winopts = {
		width = 1,
		height = 1,
		border = "none",
	},
})
-- Set fzf layout options
vim.g.fzf_vim = {
	preview_window = { "right:50%", "P" },
}
-- vim.g.fzf_layout = { window = { width = vim.o.columns, height = vim.o.lines, border = "none" } }
vim.g.fzf_layout = { window = { width = 1.0, height = 1.0, border = "none" } }
vim.env.FZF_DEFAULT_COMMAND = "fdfind  .. --type f --exclude .git -i"

-- Set default fzf options
vim.env.FZF_DEFAULT_OPTS =
	'-i  --reverse --cycle --margin=2 --preview-window noborder --prompt="> " --marker=">" --pointer="◆" --scrollbar="" --layout=reverse --no-preview'
local fzf_default_opts = vim.env.FZF_DEFAULT_OPTS or ""
local additional_opts =
	"--bind=Tab:down --color=fg:#d0d0d0,fg+:#d0d0d0,bg:-1,bg+:-1 --color=hl:#5f87af,hl+:#5fd7ff,info:#afaf87,marker:#87ff00 --color=prompt:#d7005f,spinner:-1,pointer:-1,header:#87afaf --color=border:-1,label:#aeaeae,query:#d9d9d9"
vim.env.FZF_DEFAULT_OPTS = fzf_default_opts .. " " .. additional_opts
