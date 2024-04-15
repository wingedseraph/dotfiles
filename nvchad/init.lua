if vim.loader then
	vim.loader.enable()
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

require("core")

local custom_init_path = vim.api.nvim_get_runtime_file("lua/custom/init.lua", false)[1]

if custom_init_path then
	dofile(custom_init_path)
end

require("core.utils").load_mappings()

local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"

-- bootstrap lazy.nvim!
if not vim.loop.fs_stat(lazypath) then
	require("core.bootstrap").gen_chadrc_template()
	require("core.bootstrap").lazy(lazypath)
end

dofile(vim.g.base46_cache .. "defaults")
vim.opt.rtp:prepend(lazypath)
-- require("start.ministatus")
-- require("plugins")
-- require("null-ls").setup()
-- vim.api.nvim_command("colorscheme habamax")
vim.api.nvim_exec(
	[[
		autocmd VimEnter * silent lua require("plugins")
	]],
	false
)

function setupHistory()
	-- Define an autocommand to execute History command on BufEnter event after a delay
	vim.defer_fn(function()
		vim.cmd("History")
	end, 0)
end
