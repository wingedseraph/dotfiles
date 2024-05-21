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
}

return options
