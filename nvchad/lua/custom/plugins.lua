-- function path_()

---@type NvPluginSpec[]

local plugins = {
	{
		"neovim/nvim-lspconfig",
		dependencies = {
			-- format & linting
			{
				-- "jose-elias-alvarez/null-ls.nvim",
				-- "nvimtools/none-ls.nvim",
				"mfussenegger/nvim-lint",
				config = function()
					require("custom.configs.null-ls")
				end,
			},
		},
		config = function()
			require("plugins.configs.lspconfig")
			require("custom.configs.lspconfig")
		end, -- Override to setup mason-lspconfig
	},
	{
		"folke/zen-mode.nvim",
		cmd = "ZenMode",
		opts = {
			window = {
				width = 130, -- width of the Zen window
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
		"stevearc/conform.nvim",
		enabled = true,
		event = "VeryLazy",
		config = function()
			require("conform").setup({
				notify_on_error = true,
				formatters_by_ft = {
					format_on_save = {
						-- These options will be passed to conform.format()
						-- timeout_ms = 50,
						timeout_ms = 3000,
						async = false, -- not recommended to change
						quiet = false, -- not recommended to change
						lsp_fallback = true, -- not recommended to change
						-- lsp_fallback = true,
					},
					lua = { "stylua" },
					-- Conform will run multiple formatters sequentially
					python = { "autopep8" },
					-- Use a sub-list to run only the first available formatter
					html = { { "prettierd" } },
					css = { { "prettierd" } },
					javascript = { { "eslint_d", "biome", "prettierd" } },
					c = { { "clang_format" } },

					vim.api.nvim_create_autocmd("BufWritePre", {
						pattern = "*",
						callback = function(args)
							require("conform").format({ bufnr = args.buf })
						end,
					}),
				},
			})
		end,
	},

	-- {
	-- 	"brenoprata10/nvim-highlight-colors",
	-- 	event = "VeryLazy",
	-- 	opts = {
	-- 		-- Ensure termguicolors is enabled if not already
	-- 		---Render style
	-- 		---@usage 'background'|'foreground'|'virtual'
	-- 		render = "virtual",
	-- 		---Set virtual symbol (requires render to be set to 'virtual')
	-- 		virtual_symbol = "■",
	-- 		---Highlight named colors, e.g. 'green'
	-- 		enable_named_colors = true,
	-- 		---Highlight tailwind colors, e.g. 'bg-blue-500'
	-- 		enable_tailwind = false,
	-- 		---Set custom colors
	-- 		---Label must be properly escaped with '%' to adhere to `string.gmatch`
	-- 		--- :help string.gmatch
	-- 		-- custom_colors = {
	-- 		-- 	{ label = "%-%-theme%-primary%-color", color = "#0f1219" },
	-- 		-- 	{ label = "%-%-theme%-secondary%-color", color = "#5a5d64" },
	-- 		-- },
	-- 	},
	-- },
	{
		"nacro90/numb.nvim",
		enabled = true,
		opts = {
			show_numbers = true, -- Enable 'number' for the window while peeking
			show_cursorline = true, -- Enable 'cursorline' for the window while peeking
			hide_relativenumbers = true, -- Enable turning off 'relativenumber' for the window while peeking
			number_only = false, -- Peek only when the command is only a number instead of when it starts with a number
			centered_peeking = true, -- Peeked line will be centered relative to window
		},
	},
	{ "psliwka/vim-smoothie", lazy = false },
	{
		"echasnovski/mini.indentscope",
		version = "*",
		ft = "python",
		opts = {
			options = { try_as_border = true },
		},
	},
	{ "dstein64/vim-startuptime", cmd = "StartupTime" },

	{ "onsails/lspkind.nvim" },
	-- { "rockerBOO/boo-colorscheme-nvim", event = "VeryLazy" },

	{
		"SmiteshP/nvim-navbuddy",
		opts = {
			lsp = { auto_attach = true },
			source_buffer = {
				follow_node = true, -- Keep the current node in focus on the source buffer
				highlight = true, -- Highlight the currently focused node
			},
			border = "none",
			size = { 60, 60 }, -- Or table format example: { height = "40%", width = "100%"}
			sections = {
				left = {
					size = "20%",
					border = "none", -- You can set border style for each section individually as well.
				},
				mid = {
					size = "60%",
					border = "none",
				},
				right = {
					-- No size option for right most section. It fills to
					-- remaining area.
					border = "none",
					preview = "leaf", -- Right section can show previews too.
					-- Options: "leaf", "always" or "never"
				},
			},
			node_markers = {
				enabled = false,
			},
		},

		dependencies = {
			"SmiteshP/nvim-navic",
			"MunifTanjim/nui.nvim",
		},
	},
	-- { "andersevenrud/nvim_context_vt", opts = {}, ft = "html", enabled = false },
	{
		"echasnovski/mini.hipatterns",
		version = "*",
	},
	-- { "yorickpeterse/nvim-pqf", opts = {}, event = "VeryLazy" },
	{ "kevinhwang91/nvim-bqf", opts = {}, event = "VeryLazy" },

	{
		"SR-Mystar/yazi.nvim",
		cmd = "Yazi",
		opts = {
			continue_use_it = true,
			size = {
				width = 0.9, -- maximally available columns
				height = 0.8, -- maximally available lines
			},
			border = "none",
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
	{
		"michaelb/sniprun",
		-- keys = {
		-- 	{
		-- 		"<leader>rr",
		-- 		mode = { "v" },
		-- 		function()
		-- 			vim.cmd("SnipRun")
		-- 		end,
		-- 		desc = "snip run",
		-- 	},
		-- 	{
		-- 		"<leader>rr",
		-- 		mode = { "n" },
		-- 		function()
		-- 			vim.cmd("SnipClose")
		-- 		end,
		-- 		desc = "snip close",
		-- 	},
		-- },
	},
	{
		"RRethy/vim-illuminate",
		cmd = "IlluminateResume",
		config = function()
			require("illuminate").configure({
				providers = {
					"lsp",
					-- "treesitter",
					-- "regex",
				},
				filetypes_denylist = {
					"dirbuf",
					"dirvish",
					"fugitive",
				},
				min_count_to_highlight = 2,
				under_cursor = true,
				modes_denylist = { "v", "V", "" },
			})
			vim.cmd("hi IlluminatedWordText guibg=#393E4D gui=none")
			vim.cmd("hi IlluminatedWordRead guibg=#393E4D gui=none")
		end,
	},
	-- { "capaj/vscode-standardjs-snippets", ft = { "javascript" } },
	{
		"xiyaowong/transparent.nvim",
		cmd = "TransparentEnable",
	},
	{
		"Exafunction/codeium.vim",
		enabled = false,
		event = "BufEnter",
		config = function()
			-- Change '<C-g>' here to any keycode you like.
			vim.keymap.set("i", "<C-g>", function()
				return vim.fn["codeium#Accept"]()
			end, { expr = true })
			vim.keymap.set("i", "<F4>", function()
				return vim.fn["codeium#CycleCompletions"](1)
			end, { expr = true })
			vim.keymap.set("i", "<c-,>", function()
				return vim.fn["codeium#CycleCompletions"](-1)
			end, { expr = true })
			vim.keymap.set("i", "<c-x>", function()
				return vim.fn["codeium#Clear"]()
			end, { expr = true })
		end,
	},
	{ "kdheepak/lazygit.nvim" },
	{
		"ramojus/mellifluous.nvim",
		lazy = false,
		priority = 100,
	},
	{ "ThePrimeagen/vim-be-good" },
	{ "mg979/vim-visual-multi", event = "VeryLazy", enabled = true },
	{
		"folke/flash.nvim",
		enabled = true,
		-- event = "BufRead",
		opts = {
			label = {
				style = "overlay", ---@type "eol" | "overlay" | "right_align" | "inline"
				rainbow = { enabled = true, shade = 3 },
			},
			modes = {
				search = {
					enabled = false,
				},
				char = {
					multi_line = false,
				},
			},
		},
    -- stylua: ignore
    keys = {
      { "s", mode = { "n", "o", "x" }, function() require("flash").jump() end, desc = "Flash" },
      { "S", mode = { "n", "o", "x" }, function() require("flash").treesitter() end, desc = "Flash Treesitter" },
      { "r", mode = "o", function() require("flash").remote() end, desc = "Remote Flash" },
      { "R", mode = { "o", "x" }, function() require("flash").treesitter_search() end, desc = "Treesitter Search" },
      -- { "<c-s>", mode = { "c" }, function() require("flash").toggle() end, desc = "Toggle Flash Search" },
      },
	},
	{
		"echasnovski/mini.hues",
	},
	{ "Mofiqul/vscode.nvim" },
	{
		"declancm/cinnamon.nvim",
		enabled = false,
		event = "VeryLazy",
		opts = {},
	},
	{
		"kevinhwang91/nvim-hlslens",
		opts = {
			calm_down = true,
			nearest_only = true,
			nearest_float_when = "never",
		},
		config = function()
			require("hlslens").setup()

			local kopts = { noremap = true, silent = true }

			vim.api.nvim_set_keymap(
				"n",
				"n",
				[[<Cmd>execute('normal! ' . v:count1 . 'n')<CR><Cmd>lua require('hlslens').start()<CR>]],
				kopts
			)
			vim.api.nvim_set_keymap(
				"n",
				"N",
				[[<Cmd>execute('normal! ' . v:count1 . 'N')<CR><Cmd>lua require('hlslens').start()<CR>]],
				kopts
			)
			vim.api.nvim_set_keymap("n", "*", [[*<Cmd>lua require('hlslens').start()<CR>]], kopts)
			vim.api.nvim_set_keymap("n", "#", [[#<Cmd>lua require('hlslens').start()<CR>]], kopts)
			vim.api.nvim_set_keymap("n", "g*", [[g*<Cmd>lua require('hlslens').start()<CR>]], kopts)
			vim.api.nvim_set_keymap("n", "g#", [[g#<Cmd>lua require('hlslens').start()<CR>]], kopts)
		end,
	},
	{
		"echasnovski/mini.tabline",
		opts = {},
		lazy = false,
		priority = 9,
		version = "*",
	},
	-- lazy.nvim
	{
		"folke/noice.nvim",
		event = "LspAttach",
		opts = {
			presets = {
				-- lsp_doc_border = true, -- add a border to hover docs and signature help
			},
			lsp = {
				override = {
					["vim.lsp.util.convert_input_to_markdown_lines"] = true,
					["vim.lsp.util.stylize_markdown"] = true,
					["cmp.entry.get_documentation"] = true, -- requires hrsh7th/nvim-cmp
				},
				hover = {
					enabled = true,
					silent = false, -- set to true to not show a message if hover is not available
					view = nil, -- when nil, use defaults from documentation
					opts = {}, -- merged with defaults from documentation
				},
				progress = {
					enabled = false,
				},
				signature = {
					enabled = true,
				},
				message = {
					-- Messages shown by lsp servers
					enabled = false,
				},
			},
			-- you can enable a preset for easier configuration
			cmdline = {
				enabled = false, -- enables the Noice cmdline UI
			},
			messages = {
				-- NOTE: If you enable messages, then the cmdline is enabled automatically.
				-- This is a current Neovim limitation.
				enabled = false, -- enables the Noice messages UI
			},
			popupmenu = {
				enabled = false, -- enables the Noice popupmenu UIs
			},
			notify = {
				enabled = false,
				view = "notify",
			},
		},
		dependencies = {
			-- if you lazy-load any plugin below, make sure to add proper `module="..."` entries
			"MunifTanjim/nui.nvim",
		},
	},
	{
		"echasnovski/mini.statusline",
		version = "*",
		lazy = false,
		config = function()
			-- require("vscode").load()
			vim.opt.showmode = false

			local statusline = require("mini.statusline")
    --stylua: ignore
    local active = function()
      local mode, mode_hl = statusline.section_mode({ trunc_width = 120 })
      -- Try out 'mini.git'
      local git_summary  = vim.b.minigit_summary or {}
      local git_head = git_summary.head_name or ''
      if git_head ~= '' then
        git_head = ' ' .. (git_head == 'HEAD' and git_summary.head:sub(1, 7) or git_head)
      end
      local git_status = git_summary.status or ''
      if git_status ~= '' then
        git_status = git_status == '  ' and '' or string.format('(%s)', git_status)
      end
      -- Try out 'mini.diff'
      local diff_summary  = vim.b.minidiff_summary_string
      local diff          = diff_summary ~= nil and string.format(' %s', diff_summary == '' and '-' or diff_summary) or ''
      local diagnostics   = statusline.section_diagnostics({ trunc_width = 75 })
      local filename      = statusline.section_filename({ trunc_width = 140 })
      local fileinfo      = statusline.section_fileinfo({ trunc_width = 120 })
      local location      = statusline.section_location({ trunc_width = 75 })
      local search        = statusline.section_searchcount({ trunc_width = 75 })

      return statusline.combine_groups({
        { hl = mode_hl,                  strings = { mode } },
        { hl = 'MiniStatuslineDevinfo',  strings = { git_head, diff, diagnostics } },
        '%<', -- Mark general truncate point
        { hl = 'MiniStatuslineFileinfo', strings = { filename } },
        '%=', -- End left alignment
        { hl = 'MiniStatuslineFileinfo', strings = { fileinfo } },
        { hl = mode_hl,                  strings = { search, location } },
      })
    end
			statusline.setup({ content = { active = active } })

			-- require("mini.statusline").setup({
			-- 	use_icons = false,
			-- })
			vim.wo.statusline = "%!v:lua.MiniStatusline.active()"
		end,
	},

	{ "nullchilly/fsread.nvim", cmd = "FSRead" }, -- change local re = cur:match("[%w\128-\255']+") in local files to search for cyrillic symbols
	{
		"ibhagwan/fzf-lua",
		-- lazy = false,
		event = "VeryLazy",
		dependencies = { "nvim-tree/nvim-web-devicons" },
		config = function()
			vim.api.nvim_set_keymap("n", "<M-d>", "<cmd>FzfLua files<cr>", { noremap = true, silent = true })
			vim.api.nvim_set_keymap("n", "<M-o>", "<cmd>FzfLua oldfiles<CR>", { noremap = true, silent = true })
			vim.api.nvim_set_keymap("n", "<leader>o", "<cmd>FzfLua oldfiles<CR>", { noremap = true, silent = true })
			vim.api.nvim_set_keymap("n", "<leader>ff", "<cmd>FzfLua files<CR>", { noremap = true, silent = true })
			vim.api.nvim_set_keymap("n", "<leader>fw", "<cmd>FzfLua live_grep<CR>", { noremap = true, silent = true })
			vim.api.nvim_set_keymap("n", "<leader>b", "<cmd>FzfLua buffers<CR>", { noremap = true, silent = true })
			vim.api.nvim_set_keymap("n", "<leader>/", "<cmd>FzfLua lgrep_curbuf<CR>", { noremap = true, silent = true })
			vim.api.nvim_set_keymap("n", "<leader>L", "<cmd>FzfLua lines<CR>", { noremap = true, silent = true })
			vim.api.nvim_set_keymap("n", "<leader>'", "<cmd>FzfLua marks<CR>", { noremap = true, silent = true })
			vim.api.nvim_set_keymap("n", "<leader>H", "<cmd>FzfLua help_tags<CR>", { noremap = true, silent = true })
			vim.api.nvim_set_keymap("n", "<leader>k", "<cmd>FzfLua keymaps<CR>", { noremap = true, silent = true })
			vim.api.nvim_set_keymap("n", "<leader>fz", "<cmd>FzfLua<cr>", { noremap = true, silent = true })

			require("fzf-lua").setup({
				keymap = {
					-- These override the default tables completely
					-- no need to set to `false` to disable a bind
					-- delete or modify is sufficient
					fzf = {
						-- fzf '--bind=' options
						-- ["ctrl-l"] = "clear-query",
						-- ["ctrl-c"] = "abort",
						-- ["tab"] = "toggle-out",
						-- ["f6"] = "toggle-in",
						-- ["ctrl-o"] = "toggle-all",
						-- ["ctrl-f"] = "preview-down",
						-- ["ctrl-b"] = "preview-up",
						-- Only valid with fzf previewers (bat/cat/git/etc)
						-- ["f3"] = "toggle-preview-wrap",
						-- ["f4"] = "toggle-preview",
						-- ["ctrl-d"] = "preview-page-down",
						-- ["ctrl-u"] = "preview-page-up",
					},
				},
				winopts = {
					width = 1,
					height = 1,
					border = "none",
					-- @windows usage
					-- preview = { hidden = "hidden" },
				},
			})
		end,
	},
	{
		"nvim-focus/focus.nvim",
		version = "*",
		opts = {
			ui = {
				number = false, -- Display line numbers in the focussed window only
				cursorline = false, -- Display a cursorline in the focussed window only
			},
			split = {
				-- bufnew = true, -- Create blank buffer for new split windows
				-- tmux = true, -- Create tmux splits instead of neovim splits
			},
		},
	},
	-- float terminal in neovim : very useful
	{
		"akinsho/toggleterm.nvim",
		version = "*",
		opts = {
			-- 'single' | 'double' | 'shadow' | 'curved' |
			-- The border key is *almost* the same as 'nvim_open_win'
			-- not natively supported but implemented in this plugin.
			-- see :h nvim_open_win for details on borders however
			-- the 'curved' border is a custom border type
			border = "curved",
			-- Change the default shell. Can be a string or a function returning a string
			close_on_exit = true, -- close the terminal window when the process exits
			direction = "float", -- "horizontal" | "tab" | "float",
			float_opts = {
				size = 120,
			},
		},
	},
	-- press jj in insert mode to exit : very useful
	{ "chaoren/vim-wordmotion", event = "VeryLazy" },
	{
		"max397574/better-escape.nvim",
		enabled = true,
		event = { "CursorHold", "CursorHoldI" },
		opts = {
			mapping = { "jj" }, -- a table with mappings to use
			timeout = vim.o.timeoutlen, -- the time in which the keys must be hit in ms. Use option timeoutlen by default
			clear_empty_lines = false, -- clear line after escaping if there is only whitespace
			keys = "<Esc>", -- keys used for escaping, if it is a function will use the result everytime
		},
	},
	{ "echasnovski/mini.ai", version = "*", event = "VeryLazy", opts = {} },
	{
		"junegunn/fzf.vim",
		enabled = false,
		lazy = false,
		-- event = "VeryLazy",
		dependencies = "junegunn/fzf",
		opts = require("custom.configs.fzf_vim"),
	},
	{ "echasnovski/mini.move", version = "*" },
	{
		"jghauser/mkdir.nvim",
	},

	{
		"uga-rosa/translate.nvim",
		event = "VeryLazy",
		keys = {
			{ "<leader>tr", "<cmd>Translate ru <CR>", mode = { "n", "v" } },
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
	{
		"zeioth/garbage-day.nvim",
		enabled = true,
		-- event = "VeryLazy",
		dependencies = "neovim/nvim-lspconfig",
		opts = {
			-- your options here
		},
	},
	{ "nvim-treesitter/nvim-treesitter-context", cmd = "TSContextEnable", opts = { mode = "cursor", max_lines = 3 } },
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
		"MeanderingProgrammer/markdown.nvim",

		name = "render-markdown", -- Only needed if you have another plugin named markdown.nvim
		dependencies = { "nvim-treesitter/nvim-treesitter" },
	},
	{
		"nvim-neorg/neorg",
		enabled = false,
		build = ":Neorg sync-parsers",
		-- ft = { "norg" },
		-- lazy = false,
		-- event = "VeryLazy",
		-- after = "nvim-treesitter",
		dependencies = { "nvim-lua/plenary.nvim" },
		opts = {
			load = {
				["core.defaults"] = {}, -- Loads default behaviour
				["core.concealer"] = {}, -- Adds pretty icons to your documents
				["core.dirman"] = { -- Manages Neorg workspaces
					config = {
						workspaces = {
							notes = "~/notes",
						},
					},
				},
			},
		},
	},
	{
		"hedyhli/outline.nvim",
		keys = { { "<leader>cs", "<cmd>Outline<cr>", desc = "Toggle Outline" } },
		cmd = "Outline",
		opts = function()
			local defaults = require("outline.config").defaults
			local opts = {
				symbols = {},
				symbol_blacklist = {},
			}

			local filter
			if type(filter) == "table" then
				filter = filter.default
				if type(filter) == "table" then
					for kind, symbol in pairs(defaults.symbols) do
						opts.symbols[kind] = {
							hl = symbol.hl,
						}
						if not vim.tbl_contains(filter, kind) then
							table.insert(opts.symbol_blacklist, kind)
						end
					end
				end
			end
			return opts
		end,
	},
}
return plugins
