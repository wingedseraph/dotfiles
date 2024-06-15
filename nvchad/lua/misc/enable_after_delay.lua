-- @filetypes
if vim.bo.filetype ~= "markdown" then
	vim.highlight.priorities.semantic_tokens = 95
	vim.cmd("silent TSEnable highlight")
end

if vim.bo.filetype == "markdown" then
	require("render-markdown").setup({})
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
local function augroup(name)
	return vim.api.nvim_create_augroup("my_augroup_" .. name, { clear = true })
end
vim.api.nvim_create_autocmd("BufEnter", {
	group = augroup("open_winbar"),
	pattern = "*",
	callback = function()
		local status, winbar = pcall(require, "lspsaga.symbol.winbar")
		if not status then
			return
		end
		local curbuf = vim.api.nvim_get_current_buf()
		local bo = vim.bo[curbuf]
		local disallow_filetypes = {
			"notify",
			"NvimTree",
			"neo-tree",
			"neo-tree-popup",
			"packer",
			"qf",
			"diff",
			"fugitive",
			"fugitiveblame",
		}
		local disallow_buftypes = {
			"nofile",
			"terminal",
			"help",
		}
		if bo.bt == "" and bo.ft == "" then
			return
		end

		if vim.tbl_contains(disallow_filetypes, bo.ft) or vim.tbl_contains(disallow_buftypes, bo.bt) then
			return
		end

		if winbar.get_bar() == nil then
			winbar.init_winbar(curbuf)
		end
	end,
})
