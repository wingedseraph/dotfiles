-- Initialization =============================================================
pcall(function()
	vim.loader.enable()
end)

-- Define main config table
_G.Config = {
	path_package = vim.fn.stdpath("data") .. "/site/",
	path_source = vim.fn.stdpath("config") .. "/src/",
}

-- Ensure 'mini.nvim' is set up
local mini_path = Config.path_package .. "pack/deps/start/mini.nvim"
if not vim.loop.fs_stat(mini_path) then
	vim.cmd([[echo "Installing 'mini.nvim'" | redraw]])
	local clone_cmd = { "git", "clone", "--filter=blob:none", "https://github.com/echasnovski/mini.nvim", mini_path }
	vim.fn.system(clone_cmd)
end
require("mini.deps").setup({ path = { package = Config.path_package } })

-- Define helpers
local add, now, later = MiniDeps.add, MiniDeps.now, MiniDeps.later
local source = function(path)
	dofile(Config.path_source .. path)
end

function lazy()
	-- Settings and mappings ======================================================
	now(function()
		source("settings.lua")
	end)
	now(function()
		source("functions.lua")
	end)
	now(function()
		source("mappings.lua")
	end)
	now(function()
		source("mappings-leader.lua")
	end)
	if vim.g.vscode ~= nil then
		now(function()
			source("vscode.lua")
		end)
	end
	-- Mini.nvim ==================================================================
	add({ name = "mini.nvim", checkout = "HEAD" })

	-- Step one
	-- now(function() vim.cmd('colorscheme randomhue') end)
	-- Use this color scheme in 'mini.nvim' demos
	require("mini.hues").setup({ background = "#10262c", foreground = "#c0c8cb" })

	now(function()
		local filterout_lua_diagnosing = function(notif_arr)
			local not_diagnosing = function(notif)
				return not vim.startswith(notif.msg, "lua_ls: Diagnosing")
			end
			notif_arr = vim.tbl_filter(not_diagnosing, notif_arr)
			return MiniNotify.default_sort(notif_arr)
		end
		require("mini.notify").setup({
			content = { sort = filterout_lua_diagnosing },
			window = { config = { border = "double" } },
		})
		vim.notify = MiniNotify.make_notify()
	end)

	now(function()
		require("mini.sessions").setup()
	end)

	now(function()
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
      { hl = 'MiniStatuslineFilename', strings = { filename } },
      '%=', -- End left alignment
      { hl = 'MiniStatuslineFileinfo', strings = { fileinfo } },
      { hl = mode_hl,                  strings = { search, location } },
    })
  end
		statusline.setup({ content = { active = active } })
	end)

	now(function()
		require("mini.tabline").setup()
	end)

	-- Step two
	later(function()
		require("mini.extra").setup()
	end)

	later(function()
		local ai = require("mini.ai")
		ai.setup({
			custom_textobjects = {
				B = MiniExtra.gen_ai_spec.buffer(),
				F = ai.gen_spec.treesitter({ a = "@function.outer", i = "@function.inner" }),
			},
		})
	end)

	later(function()
		require("mini.align").setup()
	end)

	later(function()
		require("mini.basics").setup({
			options = {
				-- Manage options manually
				basic = false,
			},
			mappings = {
				windows = true,
				move_with_alt = true,
			},
			autocommands = {
				relnum_in_visual_mode = true,
			},
		})
	end)

	later(function()
		require("mini.bracketed").setup()
	end)

	later(function()
		require("mini.bufremove").setup()
	end)

	-- Don't really need it on daily basis
	-- later(function() require('mini.colors').setup() end)

	later(function()
		require("mini.comment").setup()
	end)

	later(function()
		local hipatterns = require("mini.hipatterns")
		local hi_words = MiniExtra.gen_highlighter.words
		hipatterns.setup({
			highlighters = {
				fixme = hi_words({ "FIXME", "Fixme", "fixme" }, "MiniHipatternsFixme"),
				hack = hi_words({ "HACK", "Hack", "hack" }, "MiniHipatternsHack"),
				todo = hi_words({ "TODO", "Todo", "todo" }, "MiniHipatternsTodo"),
				note = hi_words({ "NOTE", "Note", "note" }, "MiniHipatternsNote"),

				hex_color = hipatterns.gen_highlighter.hex_color(),
			},
		})
	end)

	later(function()
		require("mini.misc").setup({ make_global = { "put", "put_text", "stat_summary", "bench_time" } })
		MiniMisc.setup_auto_root()
	end)

	later(function()
		require("mini.move").setup({ options = { reindent_linewise = false } })
	end)

	later(function()
		require("mini.operators").setup()
	end)

	later(function()
		require("mini.pairs").setup({ modes = { insert = true, command = true, terminal = true } })
		vim.keymap.set("i", "<CR>", "v:lua.Config.cr_action()", { expr = true })
	end)

	later(function()
		require("mini.splitjoin").setup()
	end)

	later(function()
		require("mini.surround").setup({ search_method = "cover_or_next" })
		-- Disable `s` shortcut (use `cl` instead) for safer usage of 'mini.surround'
		vim.keymap.set({ "n", "x" }, "s", "<Nop>")
	end)

	later(function()
		require("mini.trailspace").setup()
	end)

	later(function()
		require("mini.visits").setup()
	end)

	-- Dependencies ===============================================================
	-- Colorful icons
	now(function()
		add("nvim-tree/nvim-web-devicons")
	end)

	-- Tree-sitter: advanced syntax parsing, highlighting, and text objects
	later(function()
		local ts_spec = {
			source = "nvim-treesitter/nvim-treesitter",
			checkout = "master",
			hooks = {
				post_checkout = function()
					vim.cmd("TSUpdate")
				end,
			},
		}
		add({ source = "nvim-treesitter/nvim-treesitter-textobjects", depends = { ts_spec } })
		source("plugins/nvim-treesitter.lua")
	end)

	-- Interact with Git hunks
	later(function()
		add("lewis6991/gitsigns.nvim")
		source("plugins/gitsigns.lua")
	end)

	-- Install LSP/formatting/linter executables
	later(function()
		add("williamboman/mason.nvim")
		require("mason").setup()
	end)

	-- Formatting
	later(function()
		add("stevearc/conform.nvim")
		source("plugins/conform.lua")
	end)

	-- Language server configurations
	now(function()
		add("neovim/nvim-lspconfig")
		source("plugins/nvim-lspconfig.lua")
	end)
	-- cmp
	now(function()
		add("hrsh7th/nvim-cmp")
		source("plugins/cmp.lua")
	end)

	-- Snippets
	later(function()
		add("L3MON4D3/LuaSnip")
		local src_file = vim.fn.has("nvim-0.10") == 1 and "my_snippets.lua" or "plugins/luasnip.lua"
		source(src_file)
	end)
	later(function()
		add("saadparwaiz1/cmp_luasnip")
		add("hrsh7th/cmp-nvim-lua")
		add("hrsh7th/cmp-nvim-lsp")
		add("hrsh7th/cmp-buffer")
		add("hrsh7th/cmp-path")
		add("windwp/nvim-autopairs")
		add("lukas-reineke/cmp-rg")
		add("hrsh7th/cmp-nvim-lsp-signature-help")
	end)

	-- Fzf
	later(function()
		add("ibhagwan/fzf-lua")
		source("plugins/fzf.lua")
	end)

	-- Yazi
	later(function()
		add("SR-Mystar/yazi.nvim")
		source("plugins/yazi.lua")
	end)

	-- better quickfix
	later(function()
		add("yorickpeterse/nvim-pqf")
		require("pqf").setup()
	end)
	-- multicursor
	later(function()
		add("mg979/vim-visual-multi")
	end)
end
vim.api.nvim_exec(
	[[
        autocmd VimEnter * silent! lua lazy()
    ]],
	false
)

vim.api.nvim_exec(
	[[
        autocmd BufEnter * silent! lua vim.defer_fn(function() vim.cmd('LspStart') end, 23)
    ]],
	false
)
vim.cmd([[
  au BufReadPost * if line("'\"") >= 1 && line("'\"") <= line("$") | exe "normal! g`\"" | endif
]])
function setupHistory()
	vim.defer_fn(function()
		-- vim.cmd("History") -- fzf.vim
		vim.cmd("FzfLua oldfiles") -- fzf.lua
	end, 80)
end
