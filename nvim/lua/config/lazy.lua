-- install lazy.nvim
local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not vim.loop.fs_stat(lazypath) then
	vim.fn.system({
		"git",
		"clone",
		"--filter=blob:none",
		"https://github.com/folke/lazy.nvim.git",
		"--branch=stable", -- latest stable release
		lazypath,
	})
end
vim.opt.rtp:prepend(lazypath)
-- DEFER_FN
function BOOT()
	vim.defer_fn(function()
		-- require("garbage-day.utils").start_lsp()
		vim.cmd("LspStart")
		vim.opt.clipboard = "unnamedplus"
	end, 1)
end

vim.api.nvim_exec2(
	[[
  autocmd VimEnter * silent lua BOOT()
  ]],
	{ output = false }
)
-- load plugins
-- require("lazy").setup("plugins")
vl = "VeryLazy"
require("lazy").setup("plugins", {
	defaults = {
		lazy = true,
	},
	change_detection = { notify = false },
	performance = {
		cache = {
			enabled = true,
		},
		rtp = {
			disabled_plugins = {
				"2html_plugin",
				"tohtml",
				"getscript",
				"getscriptPlugin",
				"gzip",
				"logipat",
				"netrw",
				"netrwPlugin",
				"netrwSettings",
				"netrwFileHandlers",
				"matchit",
				"tar",
				"tarPlugin",
				"rrhelper",
				"spellfile_plugin",
				"vimball",
				"vimballPlugin",
				"zip",
				"zipPlugin",
				-- "tutor",
				"rplugin",
				"syntax",
				"synmenu",
				"optwin",
				"compiler",
				"bugreport",
				"ftplugin",
			},
		},
	},
})
