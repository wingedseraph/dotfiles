vim.loader.enable()
vim.g.boot_nvchad = false

-------------------- CONFIG ------------------------
require("config.options")
require("config.mappings")
require("config.autocmds")
-------------------- LAZY ------------------------
require("config.lazy")
-- vim.defer_fn(function()
-- end, 1)

-------------------- THEME ------------------------
if vim.g.boot_nvchad == false then
	require("misc.user_colorschemes")
	require("misc.switch_buffers")
	-------------------- BUFTABLINE ------------------------
	require("misc.tabline").setup()
	-------------------- STATUSLINE ------------------------
	-- require("misc.mini_status").setup()
	require("config.chad_status")
end

-- require('time_tracker')
-- require('use_time_tracker')
