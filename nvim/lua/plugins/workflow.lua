return {
	{ "nvim-tree/nvim-web-devicons" },
	{ "MagicDuck/grug-far.nvim", opts = {}, cmd = "GrugFar" },
	{ "mg979/vim-visual-multi", event = vl },
	{
		"backdround/global-note.nvim",
		event = vl,
		config = function()
			local global_note = require("global-note")
			local get_project_name = function()
				---@diagnostic disable-next-line: undefined-field
				local project_directory, err = vim.uv.cwd()
				if project_directory == nil then
					vim.notify(err, vim.log.levels.WARN)
					return nil
				end

				local project_name = vim.fs.basename(project_directory)
				if project_name == nil then
					vim.notify("Unable to get the project name", vim.log.levels.WARN)
					return nil
				end

				return project_name
			end
			global_note.setup({
				additional_presets = {
					project_local = {
						command_name = "ProjectNote",

						filename = function()
							return get_project_name() .. ".md"
						end,

						title = "Project note",
					},
				},
			})

			vim.keymap.set("n", "<leader>n", function()
				global_note.toggle_note("project_local")
			end, {
				desc = "todo, Toggle project note",
			})
		end,
	},
	{
		"samjwill/nvim-unception",
		-- enabled = false,
		event = vl,
	},
	{
		"folke/flash.nvim",
		enabled = true,
		event = vl,
		opts = {
			label = {
				style = "overlay", ---@type "eol" | "overlay" | "right_align" | "inline"
				rainbow = { enabled = true, shade = 4 },
			},
			modes = {
				search = {
					enabled = false,
				},
				char = {
					multi_line = false,
					jump_labels = true,
				},
			},
		},
      -- stylua: ignore
      keys = {
         { "s", mode = { "n", "o", "x" }, function() require("flash").jump() end,              desc = "Flash" },
         { "S", mode = { "n", "o", "x" }, function() require("flash").treesitter() end,        desc = "Flash Treesitter" },
         { "r", mode = "o",               function() require("flash").remote() end,            desc = "Remote Flash" },
         { "R", mode = { "o", "x" },      function() require("flash").treesitter_search() end, desc = "Treesitter Search" },
         -- { "<c-s>", mode = { "c" }, function() require("flash").toggle() end, desc = "Toggle Flash Search" },
      },
	},
	-- { "0xhoussam/fleet.nvim", dependencies = { "ofirgall/ofirkai.nvim", "dgox16/oldworld.nvim" }, event = vl },
	{
		"kdheepak/lazygit.nvim",
		config = function()
			vim.g.lazygit_floating_window_scaling_factor = 1 -- scaling factor for floating window
		end,
		keys = {
			{ "<leader>lg", "<cmd>LazyGit<cr>", desc = "LazyGit" },
		},
	},
	{
		"dstein64/vim-startuptime",
		enabled = false,
		event = vl,
	},
	{
		"SR-Mystar/yazi.nvim",
		cmd = "Yazi",
		opts = {
			continue_use_it = true,
			size = {
				width = 0.9, -- maximally available columns
				height = 0.8, -- maximally available lines
			},
			border = "rounded",
		},
		keys = {
			{
				"<M-n>",
				function()
					vim.cmd("Yazi")
				end,
				desc = "Open the file manager",
			},
		},
	},
	{ "tpope/vim-sleuth", event = vl },
	{
		"zeioth/garbage-day.nvim",
		enabled = false,
		lazy = true,
		-- event = vl,
		dependencies = "neovim/nvim-lspconfig",
		opts = {
			notifications = false,
		},
	},
	-- { 'Mofiqul/vscode.nvim',    dependencies = { 'vague2k/vague.nvim' }, event = vl },
	{
		"anuvyklack/windows.nvim",
		dependencies = "anuvyklack/middleclass",
		event = vl,
		config = function()
			require("windows").setup()
			vim.cmd("WindowsDisableAutowidth")
			vim.keymap.set("n", "<m-f>", "<cmd>WindowsMaximize<CR>")
		end,
	},
	{
		"folke/persistence.nvim",
		event = vl, -- this will only start session saving when an actual file was opened
		config = function()
			require("persistence").setup()
			vim.keymap.set("n", "<leader>sm", function()
				require("persistence").select()
			end, { desc = "session manager" })
		end,
	},
	{
		"folke/zen-mode.nvim",
		cmd = "ZenMode",
		opts = {
			on_open = function(win)
				vim.cmd.hi("clear ZenBg")
				vim.o.laststatus = 3
				local view = require("zen-mode.view")
				local layout = view.layout(view.opts)
				vim.api.nvim_win_set_config(win, {
					width = layout.width,
					height = layout.height - 1,
				})
				vim.api.nvim_win_set_config(view.bg_win, {
					width = vim.o.columns,
					height = view.height() - 1,
					row = 1,
					col = layout.col,
					relative = "editor",
				})
			end,
			window = {
				width = 130, -- width of the Zen window
				height = 1, -- height of the Zen window
			},
			plugins = {
				options = {
					enabled = true,
					ruler = false, -- disables the ruler text in the cmd line area
					showcmd = true, -- disables the command in the last line of the screen
					-- you may turn on/off statusline in zen mode by setting 'laststatus'
					-- statusline will be shown only if 'laststatus' == 3
					laststatus = 3, -- turn off the statusline in zen mode
				},
				twilight = { enabled = false }, -- enable to start Twilight when zen mode opens
				tmux = { enabled = true }, -- disables the tmux statusline
				wezterm = {
					enabled = false,
					-- can be either an absolute font size or the number of incremental steps
					font = "+4", -- (10% increase per step)
				},
			},
			-- callback where you can add custom code when the Zen window opens
		},
	},
}
