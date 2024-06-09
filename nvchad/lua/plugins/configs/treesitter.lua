local options = {
	ensure_installed = { "lua" },
	matchup = {
		enable = true,
	}, -- mandatory, false will disable the whole extension
	highlight = {
		-- enable = true,
		use_languagetree = true,
		additional_vim_regex_highlighting = true,
	},

	indent = { enable = true },

	incremental_selection = {
		enable = true,
		keymaps = {
			init_selection = "<c-space>",
			node_incremental = "<c-space>",
			scope_incremental = "<c-s>",
			node_decremental = "<c-backspace>",
		},
	},
}

return options
