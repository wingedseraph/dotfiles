-- @filetypes
if vim.bo.filetype ~= "markdown" then
	vim.highlight.priorities.semantic_tokens = 95
	vim.cmd("silent TSEnable highlight")
end

if vim.bo.filetype == "html" then
	vim.cmd("IlluminateResume")
end

if vim.bo.filetype == "markdown" then
	require("render-markdown").setup({})
end

if vim.bo.filetype == "norg" then
	require("neorg")
end

-- @require
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
-- require("nvim-navbuddy")
require("plugins.configs.lspconfig")

-- @opt
vim.opt.clipboard = "unnamedplus"

-------------------------------------
-----------function_call-------------
-------------------------------------

-- @vim.cmd
-- vim.cmd("colorscheme base16-vulcan")
-- vim.cmd("colorscheme base16-black-metal-dark-funeral")

-- @vim.notify
-- vim.notify("古池や蛙飛び込む水の音 ふるいけやかわずとびこむみずのおと")
