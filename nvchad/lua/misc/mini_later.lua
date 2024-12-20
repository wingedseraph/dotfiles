local function mini_ai()
	require("mini.ai").setup()
	local ai = require("mini.ai")
	return {
		n_lines = 500,
		custom_textobjects = {
			o = ai.gen_spec.treesitter({
				a = { "@block.outer", "@conditional.outer", "@loop.outer" },
				i = { "@block.inner", "@conditional.inner", "@loop.inner" },
			}, {}),
			f = ai.gen_spec.treesitter({ a = "@function.outer", i = "@function.inner" }, {}),
			c = ai.gen_spec.treesitter({ a = "@class.outer", i = "@class.inner" }, {}),
			t = { "<([%p%w]-)%f[^<%w][^<>]->.-</%1>", "^<.->().*()</[^/]->$" },
			d = { "%f[%d]%d+" }, -- digits
			e = { -- Word with case
				{
					"%u[%l%d]+%f[^%l%d]",
					"%f[%S][%l%d]+%f[^%l%d]",
					"%f[%P][%l%d]+%f[^%l%d]",
					"^[%l%d]+%f[^%l%d]",
				},
				"^().*()$",
			},
			g = function() -- Whole buffer, similar to `gg` and 'G' motion
				local from = { line = 1, col = 1 }
				local to = {
					line = vim.fn.line("$"),
					col = math.max(vim.fn.getline("$"):len(), 1),
				}
				return { from = from, to = to }
			end,
			u = ai.gen_spec.function_call(), -- u for "Usage"
			U = ai.gen_spec.function_call({ name_pattern = "[%w_]" }), -- without dot in function name
		},
	}
end
-- require("mini.cursorword").setup()
local function mini_hi()
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
			done = { pattern = "%f[%w]()DONE()%f[%W]", group = "St_InsertMode" },

			-- Highlight hex color strings (`#rrggbb`) using that color
			hex_color = hipatterns.gen_highlighter.hex_color(),
		},
	})
end
local function mini_indent()
	require("mini.indentscope").setup({
		draw = {
			animation = require("mini.indentscope").gen_animation.none(),
		},
		symbol = "▎", -- default ╎, -- alts: ┊│┆ ┊  ▎││ ▏▏
		options = { try_as_border = true, border = "top" },
	})
end
-------------------------------------
-----------function_call-------------
-------------------------------------
-- mini_ai()
mini_hi()
-- if vim.bo.filetype == "html" then
-- 	mini_indent()
-- end

-------------------------------------
---------------require---------------
-------------------------------------
-- require("mini.hues").setup({ background = "#10262c", foreground = "#c0c8cb", saturation = "high" }) -- green
require("mini.move").setup()
-- local current_hl = vim.api.nvim_get_hl_by_name("MiniTablineCurrent", true)
-- local modified_current_hl = vim.api.nvim_get_hl_by_name("MiniTablineModifiedCurrent", true)
-- vim.api.nvim_set_hl(0, "MiniTablineCurrent", modified_current_hl)
-- vim.api.nvim_set_hl(0, "MiniTablineModifiedCurrent", current_hl)
