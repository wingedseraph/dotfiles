if vim.bo.filetype ~= "markdown" then
	vim.highlight.priorities.semantic_tokens = 95
	require("nvim-treesitter")
end

require("neorg")
require("cmp")
require("garbage-day.utils").start_lsp()
require("focus")
require("custom.highlights")
require("misc.mini_later")
require("hlslens")
require("toggleterm")
require("lazygit")
require("focus")
require("numb")
require("mkdir")
require("sniprun")
require("vim-be-good")
require("yazi").setup()
require("mini.hues").setup({
	background = "#10262c",
	foreground = "#c0c8cb",
})

vim.notify("bootstrap")
