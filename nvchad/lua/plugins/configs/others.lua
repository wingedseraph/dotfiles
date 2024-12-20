local M = {}
local utils = require("core.utils")

M.blankline = {
	indentLine_enabled = 0,
	filetype_exclude = {
		"help",
		"terminal",
		"lazy",
		"lspinfo",
		"TelescopePrompt",
		"TelescopeResults",
		"mason",
		"nvdash",
		"nvcheatsheet",
		"",
	},
	buftype_exclude = { "terminal", "nofile" },
	show_first_indent_level = false,
	show_current_context = true,
	show_current_context_start = true,
	use_treesitter = true,
	char = "",
	-- char = "╎",
	-- context_char = "",
}

M.luasnip = function(opts)
	require("luasnip").config.set_config(opts)

	-- vscode format
	require("luasnip.loaders.from_vscode").lazy_load()
	require("luasnip.loaders.from_vscode").lazy_load({ paths = vim.g.vscode_snippets_path or "" })

	-- snipmate format
	require("luasnip.loaders.from_snipmate").load()
	require("luasnip.loaders.from_snipmate").lazy_load({ paths = vim.g.snipmate_snippets_path or "" })

	-- lua format
	require("luasnip.loaders.from_lua").load()
	require("luasnip.loaders.from_lua").lazy_load({ paths = vim.g.lua_snippets_path or "" })

	vim.api.nvim_create_autocmd("InsertLeave", {
		callback = function()
			if
				require("luasnip").session.current_nodes[vim.api.nvim_get_current_buf()]
				and not require("luasnip").session.jump_active
			then
				require("luasnip").unlink_current()
			end
		end,
	})
end

M.gitsigns = {
	signs = {
		add = { text = "▒" },
		change = { text = "▒" },
		changedelete = { text = "▓" },
		delete = { text = "▓" },
		topdelete = { text = "▓" },
		untracked = { text = "░" },
	},
	preview_config = { border = "double" },
	diff_opts = { linematch = 60 },
	on_attach = function(bufnr)
		utils.load_mappings("gitsigns", { buffer = bufnr })
	end,
}

return M
