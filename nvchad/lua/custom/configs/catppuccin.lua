return {
	compile = {
		enabled = true,
		path = vim.fn.stdpath("cache") .. "/catppuccin",
	},
	transparent_background = false,
	styles = {
		comments = { "italic" },
		conditionals = { "italic" },
		functions = { "italic" },
		strings = { "italic" },
	},
	integrations = {
		alpha = true,
		gitsigns = true,
		lsp_saga = true,
		cmp = true,
		nvimtree = true,
		treesitter_context = true,
		treesitter = true,
		ts_rainbow = true,
		symbols_outline = false,
		telescope = true,
		harpoon = true,
		native_lsp = {
			enabled = true,
			virtual_text = {
				errors = { "italic" },
				hints = { "italic" },
				warnings = { "italic" },
				information = { "italic" },
			},
			underlines = {
				errors = { "undercurl" },
				hints = { "undercurl" },
				warnings = { "undercurl" },
				information = { "undercurl" },
			},
		},
		indent_blankline = {
			enabled = true,
			colored_indent_levels = true,
		},
		markdown = true,
		mason = true,
		which_key = true,
	},
}
