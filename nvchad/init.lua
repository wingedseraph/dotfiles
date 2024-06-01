-- Enable vim loader
pcall(function()
	vim.loader.enable()
end)

-- Minimal mode toggle
local minimal = 0
function Toggle_minimal()
	minimal = 1
end

-- Disable some default plugins
local disabled_plugins = {
	"gzip",
	"matchit",
	"netrwPlugin",
	"tarPlugin",
	"zipPlugin",
	"man",
	"2html_plugin",
	"remote_plugins",
	"node_provider",
	"perl_provider",
	"python_provider",
	"ruby_provider",
}

for _, plugin in ipairs(disabled_plugins) do
	vim.g["loaded_" .. plugin] = false
end

-- Main BOOT function
function BOOT()
	require("core")

	local custom_init_path = vim.api.nvim_get_runtime_file("lua/custom/init.lua", false)[1]
	if custom_init_path then
		dofile(custom_init_path)
	end

	local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
	if not vim.uv.fs_stat(lazypath) then
		require("core.bootstrap").gen_chadrc_template()
		require("core.bootstrap").lazy(lazypath)
	end

	vim.opt.rtp:prepend(lazypath)

	local file_size = vim.fn.getfsize(vim.fn.expand("%"))
	if file_size > 100 * 1024 or minimal == 1 then
		require("book_plugins")
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

-- Auto commands
vim.api.nvim_exec(
	[[
  autocmd VimEnter * silent lua BOOT()
  au BufReadPost * if line("'\"") >= 1 && line("'\"") <= line("$") | exe "normal! g`\"" | endif
]],
	false
)

-- Setup history
function SetupHistory()
	vim.defer_fn(function()
		vim.cmd("FzfLua oldfiles")
	end, 50)
end

require("misc.open_buffer_by_number")
-- Colorscheme and misc settings
-- Uncomment to use additional colorschemes
-- vim.cmd.colorscheme("catppuccin_macchiato")
-- vim.cmd.colorscheme("retrobox") -- or default

-- vim.cmd.colorscheme("Revolution")

-- require("misc.pax").load()
-- require("misc.neofusion").load()
-- require("oldworld").colorscheme() -- jsx good palette
-- require("mellow").colorscheme()
-- require("misc.base16").setup() -- mini colorscheme

require("misc.default_colorschemes_fix")

-- Uncomment if using misc.status
-- vim.opt.statusline = "%{mode()} %{expand('%:~:.')}"

-- TODO: write config in typescript haha)
-- https://www.reddit.com/r/neovim/comments/19bhncv/configure_neovim_using_typescript/
