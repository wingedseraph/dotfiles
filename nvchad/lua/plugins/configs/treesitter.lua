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
	textobjects = {
		select = {
			enable = true,
			lookahead = true,
			include_surrounding_whitespace = function(object)
				local excluded_queries = {
					"@assignment.inner",
					"@assignment.outer",
					"@assignment.lhs",
					"@assignment.rhs",
					"@block.inner",
				}

				return not vim.tbl_contains(excluded_queries, object.query_string)
			end,
			keymaps = {
				["is"] = "@assignment.inner",
				["as"] = "@assignment.outer",
				["i,"] = "@assignment.lhs",
				["i."] = "@assignment.rhs",

				["a;"] = "@block.outer",
				["i;"] = "@block.inner",

				["ac"] = "@call.outer",
				["ic"] = "@call.inner",

				["aC"] = "@class.outer",
				["iC"] = "@class.inner",

				["az"] = "@comment.outer",
				["iz"] = "@comment.inner",

				["af"] = "@function.outer",
				["if"] = "@function.inner",

				["ax"] = "@parameter.outer",
				["ix"] = "@parameter.inner",

				["at"] = "@tag.outer",
				["it"] = "@tag.inner",
			},
		},
		swap = {
			enable = true,
			swap_next = {
				["g>"] = "@parameter.inner",
			},
			swap_previous = {
				["g<"] = "@parameter.inner",
			},
		},
		move = {
			enable = true,
			set_jumps = true,
			goto_next_start = {
				["]x"] = "@parameter.outer",
				["]i"] = "@import.outer",
				["]f"] = "@function.outer",
				["]c"] = "@class.outer",
				-- ["]d"] = "@declaration.outer",
				["]s"] = "@assignment.outer",
				["]z"] = "@comment.outer",
				-- ["]t"] = "@function.inner",
			},
			goto_next_end = {
				["]X"] = "@parameter.outer",
				["]I"] = "@import.outer",
				["]F"] = "@function.outer",
				["]C"] = "@class.outer",
				-- ["]D"] = "@declaration.outer",
				["]S"] = "@assignment.outer",
				["]Z"] = "@comment.outer",
			},
			goto_previous_start = {
				["[x"] = "@parameter.outer",
				["[i"] = "@import.outer",
				["[f"] = "@function.outer",
				["[c"] = "@class.outer",
				-- ["[d"] = "@declaration.outer",
				["[s"] = "@assignment.outer",
				["[z"] = "@comment.outer",
				-- ["[t"] = "@function.inner",
			},
			goto_previous_end = {
				["[X"] = "@parameter.outer",
				["[I"] = "@import.outer",
				["[F"] = "@function.outer",
				["[C"] = "@class.outer",
				-- ["[D"] = "@declaration.outer",
				["[S"] = "@assignment.outer",
				["[Z"] = "@comment.outer",
			},
		},
		lsp_interop = {
			enable = true,
			border = "none",
			floating_preview_opts = {},
			peek_definition_code = {
				["gK"] = "@function.outer",
			},
		},
	},
}

return options
