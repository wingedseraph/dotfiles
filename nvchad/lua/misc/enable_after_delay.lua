if vim.bo.filetype ~= "markdown" then
	vim.highlight.priorities.semantic_tokens = 95
	-- vim.cmd(" silent TSEnable highlight")
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
-- require("vscode").load()
vim.notify("bootstrap")
require("nvim-navbuddy")
-------------------------------------
-----------function_call-------------
-------------------------------------
