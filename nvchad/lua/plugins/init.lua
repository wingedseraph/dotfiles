-- All plugins have lazy=true by default,to load a plugin on startup just lazy=false
-- List of all default plugins & their definitions
local default_plugins = {

	"nvim-lua/plenary.nvim",

	{
		"NvChad/base46",
		enabled = false,
		branch = "v2.0",
		build = function()
			require("base46").load_all_highlights()
		end,
	},

	{
		"NvChad/ui",
		branch = "v2.0",
		-- lazy = false,
		config = function()
			-- vim.wo.statusline = "%!v:lua.MiniStatusline.active()"
			-- require("mini.hues").setup({ background = "#10262c", foreground = "#c0c8cb", saturation = "high" }) -- green
		end,
	},

	{
		"lukas-reineke/indent-blankline.nvim",
		-- enabled = false,
		event = "VeryLazy",
		version = "2.20.7",

		-- init = function()
		-- 	require("core.utils").lazy_load("indent-blankline.nvim")
		-- end,
		opts = function()
			return require("plugins.configs.others").blankline
		end,
		config = function(_, opts)
			require("core.utils").load_mappings("blankline")
			dofile(vim.g.base46_cache .. "blankline")
			require("indent_blankline").setup(opts)

			-- vim.cmd("IndentBlanklineDisable")
			-- vim.api.nvim_create_autocmd({ "ModeChanged" }, {
			-- 	callback = function()
			-- 		vim.cmd("IndentBlanklineToggle")
			-- 	end,
			-- })
		end,
	},

	{
		"nvim-treesitter/nvim-treesitter",
		dependencies = { "nvim-treesitter/nvim-treesitter-textobjects" },
		-- event = "BufReadPre",
		event = "BufEnter",
		-- event = "InsertEnter",
		-- event = "UIEnter",
		init = function()
			require("core.utils").lazy_load("nvim-treesitter")
		end,
		cmd = { "TSInstall", "TSEnable", "TSBufDisable", "TSModuleInfo" },
		build = ":TSUpdate",
		opts = function()
			return require("plugins.configs.treesitter")
		end,
		config = function(_, opts)
			-- dofile(vim.g.base46_cache .. "syntax")
			require("nvim-treesitter.configs").setup(opts)
		end,
	},

	-- git stuff
	{
		"lewis6991/gitsigns.nvim",
		-- enabled = false,
		event = "VeryLazy",
		cmd = "Gitsigns",
		-- ft = { "gitcommit", "diff" },
		opts = function()
			return require("plugins.configs.others").gitsigns
		end,
		config = function(_, opts)
			dofile(vim.g.base46_cache .. "git")
			require("gitsigns").setup(opts)
		end,
	},

	-- lsp stuff
	{
		"williamboman/mason.nvim",
		cmd = { "Mason", "MasonInstall", "MasonInstallAll", "MasonUpdate" },
		opts = function()
			return require("plugins.configs.mason")
		end,
		config = function(_, opts)
			dofile(vim.g.base46_cache .. "mason")
			require("mason").setup(opts)

			-- custom nvchad cmd to install all mason binaries listed
			vim.api.nvim_create_user_command("MasonInstallAll", function()
				vim.cmd("MasonInstall " .. table.concat(opts.ensure_installed, " "))
			end, {})

			vim.g.mason_binaries_list = opts.ensure_installed
		end,
	},
	{
		"neovim/nvim-lspconfig",
		init = function()
			require("core.utils").lazy_load("nvim-lspconfig")
		end,
		config = function()
			require("plugins.configs.lspconfig")
		end,
	},

	-- load luasnips + cmp related in insert mode only
	{
		"hrsh7th/nvim-cmp",
		-- commit = "6c84bc75c64f778e9f1dcb798ed41c7fcb93b639", -- lock update (break codeium)
		event = "InsertEnter",
		-- event = "VeryLazy",
		cmd = "CmpStatus",
		dependencies = {
			{
				-- snippet plugin
				"L3MON4D3/LuaSnip",
				-- commit = "ea7d7ea510c641c4f15042becd27f35b3e5b3c2b",
				dependencies = "rafamadriz/friendly-snippets",
				opts = { history = true, updateevents = "TextChanged,TextChangedI" },
				config = function(_, opts)
					require("plugins.configs.others").luasnip(opts)
				end,
			},

			-- autopairing of (){}[] etc
			{
				"windwp/nvim-autopairs",
				opts = {
					fast_wrap = {},
					disable_filetype = { "TelescopePrompt", "vim" },
				},
				config = function(_, opts)
					require("nvim-autopairs").setup(opts)

					-- setup cmp for autopairs
					local cmp_autopairs = require("nvim-autopairs.completion.cmp")
					require("cmp").event:on("confirm_done", cmp_autopairs.on_confirm_done())
				end,
			},

			-- cmp sources plugins
			{
				"saadparwaiz1/cmp_luasnip",
				"hrsh7th/cmp-nvim-lua",
				"hrsh7th/cmp-nvim-lsp",
				"hrsh7th/cmp-buffer",
				"hrsh7th/cmp-path",
				"lukas-reineke/cmp-rg",
				-- "hrsh7th/cmp-nvim-lsp-signature-help",
				"may-uri/cmp-nvim-lsp-signature-help",
				-- "Exafunction/codeium.nvim",
				-- "capaj/vscode-standardjs-snippets",
				"hrsh7th/cmp-cmdline",
				"hrsh7th/cmp-nvim-lsp-document-symbol",
			},
		},
		opts = function()
			return require("plugins.configs.cmp")
		end,
		config = function(_, opts)
			require("cmp").setup(opts)
		end,
	},

	{
		"numToStr/Comment.nvim",
		enabled = false,
		keys = {
			{ "gcc", mode = "n", desc = "Comment toggle current line" },
			{ "gc", mode = { "n", "o" }, desc = "Comment toggle linewise" },
			{ "gc", mode = "x", desc = "Comment toggle linewise (visual)" },
			{ "gbc", mode = "n", desc = "Comment toggle current block" },
			{ "gb", mode = { "n", "o" }, desc = "Comment toggle blockwise" },
			{ "gb", mode = "x", desc = "Comment toggle blockwise (visual)" },
		},
		init = function()
			require("core.utils").load_mappings("comment")
		end,
		config = function(_, opts)
			require("Comment").setup(opts)
		end,
	},

	{
		"nvim-telescope/telescope.nvim",
		-- enabled = false,
		dependencies = {
			"nvim-treesitter/nvim-treesitter",
		},
		cmd = "Telescope themes",
		init = function()
			require("core.utils").load_mappings("telescope")
		end,
		opts = function()
			return require("plugins.configs.telescope")
		end,
		config = function(_, opts)
			dofile(vim.g.base46_cache .. "telescope")
			local telescope = require("telescope")
			telescope.setup(opts)

			-- load extensions
			for _, ext in ipairs(opts.extensions_list) do
				telescope.load_extension(ext)
			end
		end,
	},
}

local config = require("core.utils").load_config()

if #config.plugins > 0 then
	table.insert(default_plugins, { import = config.plugins })
	-- table.insert(default_plugins, { import = "custom.lang.tsjs" })
end

require("lazy").setup(default_plugins, config.lazy_nvim)
