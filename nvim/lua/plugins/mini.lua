return {
	{
		"folke/todo-comments.nvim",
		event = vl,
		dependencies = { "nvim-lua/plenary.nvim" },
		opts = {
			signs = false, -- show icons in the signs column
		},
	},
	{
		"echasnovski/mini.hipatterns",
		version = "*",
		enabled = false,
		event = vl,
		config = function()
			vim.cmd.hi("clear Todo")
			require("mini.hipatterns").setup()
			local hipatterns = require("mini.hipatterns")
			hipatterns.setup({
				highlighters = {
					-- Highlight standalone 'FIXME', 'HACK', 'TODO', 'NOTE', 'DONE':
					fixme = { pattern = "%f[%w]()FIXME()%f[%W]", group = "MiniHipatternsFixme" },
					hack = { pattern = "%f[%w]()HACK()%f[%W]", group = "MiniHipatternsHack" },
					todo = { pattern = "%f[%w]()TODO()%f[%W]", group = "MiniHipatternsTodo" },
					note = { pattern = "%f[%w]()NOTE()%f[%W]", group = "MiniHipatternsNote" },
					done = { pattern = "%f[%w]()DONE()%f[%W]", group = "Special" },

					-- Highlight hex color strings (`#rrggbb`) using that color
					hex_color = hipatterns.gen_highlighter.hex_color(),
				},
			})
		end,
	},
	{
		"echasnovski/mini.pairs",
		version = "*",
		event = vl,
		config = function()
			require("mini.pairs").setup({})
			vim.api.nvim_set_keymap(
				"i",
				" ",
				[[v:lua.MiniPairs.open('  ', '[%(%[{][%)%]}]')]],
				{ silent = true, expr = true, noremap = true }
			)
		end,
	},
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
	{ "echasnovski/mini.move", event = vl, opts = {} },
	{ "echasnovski/mini.ai", event = vl, opts = {} },
}
