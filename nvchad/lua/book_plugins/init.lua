local default_plugins = {
	"nvim-lua/plenary.nvim",
	{
		"folke/zen-mode.nvim",
		cmd = "ZenMode",
		opts = {
			window = {
				width = 90, -- width of the Zen window
				height = 1, -- height of the Zen window
			},
			plugins = {
				tmux = { enabled = true }, -- disables the tmux statusline
				wezterm = {
					enabled = false,
					-- can be either an absolute font size or the number of incremental steps
					font = "+4", -- (10% increase per step)
				},
			},
		},
	},
	{
		"SR-Mystar/yazi.nvim",
		cmd = "Yazi",
		opts = {
			size = {
				width = 0.9, -- maximally available columns
				height = 0.8, -- maximally available lines
			},
			border = "none",
		},
		keys = {},
	},
	{ "nullchilly/fsread.nvim", cmd = "FSRead" },
	{
		"echasnovski/mini.bufremove",
		keys = {
			{
				"<leader>x",
				function()
					local bd = require("mini.bufremove").delete
					if vim.bo.modified then
						local choice =
							vim.fn.confirm(("Save changes to %q?"):format(vim.fn.bufname()), "&Yes\n&No\n&Cancel")
						if choice == 1 then -- Yes
							vim.cmd.write()
							bd(0)
						elseif choice == 2 then -- No
							bd(0, true)
						end
					else
						bd(0)
					end
				end,
				desc = "Delete Buffer",
			},
			{
				"<leader>X",
				function()
					require("mini.bufremove").delete(0, true)
				end,
				desc = "Delete Buffer (Force)",
			},
		},
	},
	{
		"potamides/pantran.nvim",
		event = "VeryLazy",
		keys = {
			{ "<leader>tr", "<cmd>Pantran mode=hover target=ru <CR>", mode = { "n", "v" } },
			{ "<leader>tR", "<cmd>Pantran mode=replace target=ru<CR>", mode = { "n", "v" } },
		},
		config = function()
			require("pantran").setup({
				default_engine = "google",
				engines = {
					google = {
						default_source = "auto",
						default_target = "ru-RU",
						format = "html",
					},
				},
			})
		end,
	},
	{
		"junegunn/fzf.vim",
		lazy = false,
		enabled = false,
		-- event = "VeryLazy",
		dependencies = "junegunn/fzf",
		config = function()
			require("custom.configs.fzf_vim")
		end,
	},
	{
		"echasnovski/mini.hipatterns",
		event = "VeryLazy",
		version = "*",
		opts = {
			highlighters = {
				-- Highlight standalone 'FIXME', 'HACK', 'TODO', 'NOTE'
				fixme = { pattern = "%f[%w]()FIXME()%f[%W]", group = "MiniHipatternsFixme" },
				hack = { pattern = "%f[%w]()HACK()%f[%W]", group = "MiniHipatternsHack" },
				todo = { pattern = "%f[%w]()TODO()%f[%W]", group = "MiniHipatternsTodo" },
				note = { pattern = "%f[%w]()NOTE()%f[%W]", group = "MiniHipatternsNote" },
				done = { pattern = "%f[%w]()DONE()%f[%W]", group = "St_InsertMode" },
			},
		},
	},
	-- { "dstein64/vim-startuptime", event = "VeryLazy" },
	{
		"uga-rosa/translate.nvim",
		event = "VeryLazy",
		enabled = false,

		keys = {
			{ "<leader>tr", "<cmd>Translate ru -output=split<CR>", mode = { "n", "v" } },
			{ "<leader>tR", "<cmd>Translate ru -output=replace<CR>", mode = { "n", "v" } },
		},
		opts = {
			silent = true,
			preset = {
				output = {
					split = {
						append = true,
					},
				},
			},
			default = {
				command = "translate_shell",
			},
		},
	},
}
local config = require("core.utils").load_config()

require("lazy").setup(default_plugins, config.lazy_nvim)
