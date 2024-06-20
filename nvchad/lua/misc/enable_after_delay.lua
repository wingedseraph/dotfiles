-- @filetypes
if vim.bo.filetype ~= "markdown" then
	vim.highlight.priorities.semantic_tokens = 95
	vim.cmd("silent TSEnable highlight")
end

if vim.bo.filetype == "markdown" then
	require("render-markdown").setup({})
	-- Function to toggle [ ] and [x] in the current line
	function toggle_checkbox()
		local line = vim.api.nvim_get_current_line()
		if string.match(line, "%[ %]") then
			line = string.gsub(line, "%[ %]", "[x]", 1)
		elseif string.match(line, "%[x%]") then
			line = string.gsub(line, "%[x%]", "[ ]", 1)
		end
		vim.api.nvim_set_current_line(line)
	end

	vim.api.nvim_buf_set_keymap(
		0,
		"n",
		"<leader><leader>",
		":lua toggle_checkbox()<CR>",
		{ noremap = true, silent = true }
	)
end

if vim.bo.filetype == "norg" then
	require("neorg")
end
if vim.bo.filetype == "html" then
	vim.cmd([[
			 set foldmethod=expr
			 set foldexpr=nvim_treesitter#foldexpr()
	       ]])
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

-- if vim.fn.has("nvim-0.10") == 1 then
-- 	vim.opt.smoothscroll = true
-- 	vim.opt.foldexpr = "v:lua.require'misc.lazy_ui'.foldexpr()"
-- 	vim.opt.foldmethod = "expr"
-- else
-- 	vim.opt.foldmethod = "indent"
-- 	vim.opt.foldtext = "v:lua.require'misc.lazy_ui'.foldtext()"
-- end

local ok = pcall(require, "indent_blankline")
if ok then
	vim.cmd.hi("clear IndentBlanklineContextStart")
	vim.cmd.hi("link IndentBlanklineContextStart Visual")
end
