pcall(function()
	vim.loader.enable()
end)
local minimal = 0
function Toggle_minimal()
	minimal = 1
end
-- Disable some default plugins that we have
vim.g.loaded_gzip = false
vim.g.loaded_matchit = false
vim.g.loaded = false
vim.g.loaded_netrwPlugin = false
vim.g.loaded_tarPlugin = false
vim.g.loaded_zipPlugin = false
vim.g.loaded_man = false
vim.g.loaded_2html_plugin = false
vim.g.loaded_remote_plugins = false

function BOOT()
	require("core")

	local custom_init_path = vim.api.nvim_get_runtime_file("lua/custom/init.lua", false)[1]

	if custom_init_path then
		dofile(custom_init_path)
	end

	local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"

	-- bootstrap lazy.nvim!
	if not vim.uv.fs_stat(lazypath) then
		require("core.bootstrap").gen_chadrc_template()
		require("core.bootstrap").lazy(lazypath)
	end

	-- dofile(vim.g.base46_cache .. "defaults")
	vim.opt.rtp:prepend(lazypath)
	-- @enable plugins

	local file_size = vim.fn.getfsize(vim.fn.expand("%"))
	if file_size > 100 * 1024 or minimal == 1 then
		require("book_plugins") -- very minimal config
	else
		require("core.utils").load_mappings()
		require("plugins")
		require("misc.status")
		vim.opt_local.statusline = [[%{%v:lua.statusline()%}]]

		vim.api.nvim_exec(
			[[
	           autocmd UIEnter * silent lua vim.defer_fn(function() require('misc.enable_after_delay') end, 253)
	      ]],
			false
		)
	end
end

-- @other
vim.api.nvim_exec(
	[[
		autocmd VimEnter * silent lua BOOT()
	]],
	false
)

vim.cmd([[
  au BufReadPost * if line("'\"") >= 1 && line("'\"") <= line("$") | exe "normal! g`\"" | endif
]])

function SetupHistory()
	vim.defer_fn(function()
		vim.cmd("FzfLua oldfiles") -- fzf.lua
	end, 50)
end

-- require("misc.base16").setup() -- minischeme colorscheme
vim.cmd.colorscheme("retrobox")
vim.cmd("hi LineNr guifg=NONE guibg=NONE")
-- fix for all vim colorschemes
vim.cmd("highlight clear Float")
vim.cmd("highlight clear NormalFloat")
vim.cmd("highlight link Float Folded")
vim.cmd("highlight link NormalFloat Folded")

-- if I use misc.status
-- vim.opt.statusline = "%{mode()} %{expand('%:~:.')}"
vim.opt.undodir = os.getenv("HOME") .. "/.config/nvim/tmp/undo"
vim.opt.undofile = true
