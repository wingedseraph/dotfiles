if vim.bo.filetype ~= "markdown" then
	vim.highlight.priorities.semantic_tokens = 95
	require("nvim-treesitter.configs")
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

vim.notify("bootstrap")
